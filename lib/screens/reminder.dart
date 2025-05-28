import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_iq/widgets/app_theme.dart';
import 'dart:convert';
import '../components/mdecine_provider.dart';
import '../components/medication_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  List<Map<String, dynamic>> reminders = [];

  String selectedType = 'Glucose Check';
  final _formKey = GlobalKey<FormState>();
  String medName = '';
  int timesPerDay = 1;
  List<TimeOfDay> times = [TimeOfDay.now()];

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    _loadReminders();
    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  void _pickTime(int index) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: times[index],
    );
    if (picked != null) {
      setState(() => times[index] = picked);
    }
  }

  Future<void> _submitReminder() async {
    if (selectedType == 'Medication') {
      if (_formKey.currentState!.validate()) {
        Provider.of<MedicationProvider>(context, listen: false).addMedication(
          Medication(name: medName, timesPerDay: timesPerDay, times: times),
        );
        for (int i = 0; i < times.length; i++) {
          final now = DateTime.now();
          DateTime scheduledDate = DateTime(
            now.year,
            now.month,
            now.day,
            times[i].hour,
            times[i].minute,
          );

          if (scheduledDate.isBefore(now)) {
            scheduledDate = scheduledDate.add(const Duration(days: 1));
          }

          await flutterLocalNotificationsPlugin.zonedSchedule(
            DateTime.now().millisecondsSinceEpoch ~/ 1000 + i,
            'Medication Reminder',
            'Time to take $medName (Dose ${i + 1})',
            tz.TZDateTime.from(scheduledDate, tz.local),
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'med_channel',
                'Medications',
                channelDescription: 'Medication reminders',
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.time,
          );
        }

        Navigator.pop(context);
      }
    } else {
      TimeOfDay selectedTime = times[0];
      setState(() {
        reminders.add({
          'type': selectedType,
          'time': selectedTime,
        });
      });

      final now = DateTime.now();
      DateTime scheduledDate = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        reminders.length,
        selectedType,
        'It\'s time for your $selectedType',
        tz.TZDateTime.from(scheduledDate, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'reminder_channel',
            'Reminders',
            channelDescription: 'Reminder notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      _saveReminders();
      Navigator.pop(context);
    }
  }

  void _deleteReminder(int index) {
    setState(() {
      reminders.removeAt(index);
    });
    _saveReminders();
  }

  void _deleteMedication(int index) {
    final provider = Provider.of<MedicationProvider>(context, listen: false);
    provider.medications.removeAt(index);
    provider.notifyListeners();
  }

  Future<void> _saveReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> reminderStrings = reminders.map((reminder) {
      return json.encode({
        'type': reminder['type'],
        'timeHour': reminder['time'].hour,
        'timeMinute': reminder['time'].minute,
      });
    }).toList();
    await prefs.setStringList('glucose_reminders', reminderStrings);
  }

  Future<void> _loadReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? reminderStrings = prefs.getStringList('glucose_reminders');
    if (reminderStrings != null) {
      setState(() {
        reminders = reminderStrings.map((str) {
          final data = json.decode(str);
          return {
            'type': data['type'],
            'time':
                TimeOfDay(hour: data['timeHour'], minute: data['timeMinute']),
          };
        }).toList();
      });
    }
  }

  void _addReminder() {
    selectedType = 'Glucose Check';
    times = [TimeOfDay.now()];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Reminder'),
          content: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedType,
                    items: ['Glucose Check', 'Medication']
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setModalState(() {
                          selectedType = value;
                          if (value == 'Medication') {
                            timesPerDay = 1;
                            times = [TimeOfDay.now()];
                          }
                        });
                      }
                    },
                  ),
                  if (selectedType == 'Glucose Check')
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        Text('Time: ${times[0].format(context)}'),
                        TextButton(
                          onPressed: () async {
                            TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: times[0],
                            );
                            if (picked != null) {
                              setModalState(() => times[0] = picked);
                            }
                          },
                          child: const Text('Pick Time'),
                        ),
                      ],
                    )
                  else
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Medication Name'),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter name'
                                : null,
                            onChanged: (value) => medName = value,
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<int>(
                            value: timesPerDay,
                            decoration: const InputDecoration(
                                labelText: 'Times per day'),
                            items: List.generate(6, (i) => i + 1)
                                .map((num) => DropdownMenuItem(
                                    value: num, child: Text('$num times')))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setModalState(() {
                                  timesPerDay = val;
                                  times = List.generate(
                                      val, (i) => TimeOfDay.now());
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          ...List.generate(timesPerDay, (index) {
                            return Row(
                              children: [
                                Text(
                                    'Time ${index + 1}: ${times[index].format(context)}'),
                                TextButton(
                                  onPressed: () async {
                                    TimeOfDay? picked = await showTimePicker(
                                      context: context,
                                      initialTime: times[index],
                                    );
                                    if (picked != null) {
                                      setModalState(
                                          () => times[index] = picked);
                                    }
                                  },
                                  child: const Text('Pick Time'),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _submitReminder,
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final meds = Provider.of<MedicationProvider>(context).medications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Glucose Check Reminders',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...List.generate(reminders.length, (index) {
            final reminder = reminders[index];
            final time = reminder['time'] as TimeOfDay;
            final type = reminder['type'] as String;
            return ListTile(
              leading: const Icon(Icons.alarm),
              title: Text(type),
              subtitle: Text(time.format(context)),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteReminder(index),
              ),
            );
          }),
          const Divider(),
          const Text(
            'Medication Reminders',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...List.generate(meds.length, (index) {
            final med = meds[index];
            return ListTile(
              leading: const Icon(Icons.medication_outlined),
              title: Text(med.name),
              subtitle:
                  Text(med.times.map((t) => t.format(context)).join(', ')),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteMedication(index),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
