import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_iq/widgets/app_theme.dart';
import 'package:provider/provider.dart';
import '../components/mdecine_provider.dart';
import 'edit_image.dart';
import 'user/display_image.dart';
import 'user/user.dart';
import 'user/user_data.dart';
import 'profile_edit.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  List<Map<String, dynamic>> reminders = [];

  @override
  void initState() {
    super.initState();
    user = UserData.getUser();
    _loadReminders();
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

  @override
  Widget build(BuildContext context) {
    user = UserData.getUser();
    final meds = Provider.of<MedicationProvider>(context).medications;

    return ListView(
      children: [
        Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black),
              actions: [
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    navigateSecondPage(ProfileEditPage());
                  },
                ),
              ],
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                navigateSecondPage(EditImagePage());
              },
              child: DisplayImage(
                imagePath: user.image,
                onPressed: () {},
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 24.w,
              ),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: 8.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    user.aboutMeDescription,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            if (reminders.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Reminders',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ),
              ...reminders.map((reminder) {
                final time = reminder['time'] as TimeOfDay;
                final type = reminder['type'] as String;
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
                  child: Card(
                    color: Colors.white,
                    elevation: 1,
                    child: ListTile(
                      leading: Icon(Icons.alarm, color: AppTheme.primary),
                      title: Text(type, style: TextStyle(fontSize: 16.sp)),
                      subtitle: Text(time.format(context),
                          style: TextStyle(fontSize: 14.sp)),
                    ),
                  ),
                );
              }).toList(),
            ],
            if (meds.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Medicines',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ),
              ...meds.map((med) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
                    child: Card(
                      color: Colors.white,
                      elevation: 1,
                      child: ListTile(
                        leading: Icon(Icons.medication_outlined,
                            color: Colors.purple, size: 24.sp),
                        title:
                            Text(med.name, style: TextStyle(fontSize: 16.sp)),
                        subtitle: Text(
                          med.times.map((t) => t.format(context)).join(', '),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        trailing: Text('${med.timesPerDay} times',
                            style: TextStyle(fontSize: 14.sp)),
                      ),
                    ),
                  )),
            ],
          ],
        ),
      ],
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {
      user = UserData.getUser();
    });
  }

  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
