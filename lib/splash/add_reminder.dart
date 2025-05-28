import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sugar_iq/screens/login.dart';
import 'package:sugar_iq/widgets/app_theme.dart';
import '../widgets/progress_indicator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final List<String> reminders = [];

  void _addReminder() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        reminders.add(pickedTime.format(context));
      });

      final now = DateTime.now();
      DateTime scheduledDate = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(Duration(days: 1));
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        reminders.length,
        'Glucose Check',
        'Time to check your glucose level',
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
    }
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 51.h, 24.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar
              SizedBox(
                width: double.infinity,
                height: 6.h,
                child: CustomPaint(
                  painter: ProgressBarPainter(progress: 1),
                ),
              ),
              SizedBox(height: 45.h),

              Text(
                'When do you measure glucose level?',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                  height: 1.5,
                  fontFamily: 'Cera Pro',
                ),
              ),
              SizedBox(height: 6.h),

              Text(
                'SugariQ will remind you to take measurements at the same time to get accurate statistics.',
                style: TextStyle(
                  color: const Color(0xFFABAFB3),
                  fontSize: 14.sp,
                  height: 1.5,
                  fontFamily: 'Abyssinica SIL',
                ),
              ),
              SizedBox(height: 38.h),

              // Add Reminder Button
              GestureDetector(
                onTap: _addReminder,
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E3E6),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Add a reminder ',
                            style: TextStyle(
                              color: const Color(0xFF0A0A0A),
                              fontFamily: 'Convergence',
                              fontSize: 16.sp,
                            ),
                          ),
                          TextSpan(
                            text: '+',
                            style: TextStyle(
                              color: const Color(0xFF0A0A0A),
                              fontFamily: 'Convergence',
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Display Reminders
              Expanded(
                child: ListView.builder(
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 60.h,
                      margin: EdgeInsets.only(bottom: 10.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8FB),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          reminders[index],
                          style: TextStyle(
                            color: const Color(0xFF0A0A0A),
                            fontFamily: 'Convergence',
                            fontSize: 16.sp,
                            height: 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Get Started Button
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 44.w,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogInScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Convergence',
                      fontSize: 20.sp,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
