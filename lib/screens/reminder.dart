import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/mdecine_provider.dart';
import '../components/medication_model.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> reminders = [];

  String selectedType = 'Glucose Check';
  final _formKey = GlobalKey<FormState>();
  String medName = '';
  int timesPerDay = 1;
  List<TimeOfDay> times = [TimeOfDay.now()];

  @override
  void initState() {
    super.initState();
    _loadRemindersFromFirestore();
  }

  Future<void> _loadRemindersFromFirestore() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('reminders')
            .get();

        setState(() {
          reminders = snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'type': data['type'],
              'time': TimeOfDay(
                hour: data['time']['hour'],
                minute: data['time']['minute'],
              ),
            };
          }).toList();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load reminders: $e')),
      );
    }
  }

  Future<void> _saveReminderToFirestore(Map<String, dynamic> reminder) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('reminders')
            .add({
          'type': reminder['type'],
          'time': {
            'hour': reminder['time'].hour,
            'minute': reminder['time'].minute,
          },
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save reminder: $e')),
      );
    }
  }

  Future<void> _deleteReminderFromFirestore(int index) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('reminders')
            .get();

        await snapshot.docs[index].reference.delete();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete reminder: $e')),
      );
    }
  }

  void _submitReminder() {
    if (selectedType == 'Medication') {
      if (_formKey.currentState!.validate()) {
        Provider.of<MedicationProvider>(context, listen: false).addMedication(
          Medication(name: medName, timesPerDay: timesPerDay, times: times),
        );
        Navigator.pop(context);
      }
    } else {
      TimeOfDay selectedTime = times[0];
      final reminder = {
        'type': selectedType,
        'time': selectedTime,
      };
      setState(() {
        reminders.add(reminder);
      });
      _saveReminderToFirestore(reminder);
      Navigator.pop(context);
    }
  }

  void _deleteReminder(int index) {
    setState(() {
      reminders.removeAt(index);
    });
    _deleteReminderFromFirestore(index);
  }

  void _deleteMedication(int index) {
    final provider = Provider.of<MedicationProvider>(context, listen: false);
    provider.medications.removeAt(index);
    provider.notifyListeners();
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
        backgroundColor: const Color(0xFF85C26F),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
