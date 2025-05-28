import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sugar_iq/screens/saved_meals.dart';
import 'package:sugar_iq/widgets/chatbot_FAB.dart';
import '../../widgets/medicine_card.dart';
import '../../widgets/info_card.dart';
import '../components/mdecine_provider.dart';
import '../main.dart';
import '../profile page/user/user.dart';
import '../profile page/user/user_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _infoCardRefreshKey = 0;

  void _refreshInfoCard() {
    setState(() {
      _infoCardRefreshKey++;
    });
  }

  late User user;
  @override
  void initState() {
    super.initState();
    user = UserData.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final meds = Provider.of<MedicationProvider>(context).medications;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.black54, size: 24.sp),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.bar_chart, 'MY REPORT', () {
              Navigator.pushNamed(context, '/progress');
            }),
            _buildDrawerItem(Icons.notifications_none_outlined, 'REMINDERS',
                () {
              Navigator.pushNamed(context, '/reminder');
            }),
            _buildDrawerItem(Icons.bookmark_border, 'SAVED MEAL', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SavedMealsPage(
                    onMealsUpdated: _refreshInfoCard,
                  ),
                ),
              );
            }),
            Divider(),
            _buildDrawerItem(Icons.settings_outlined, 'SETTINGS', () {
              Navigator.pushNamed(context, '/settings');
            }),
            _buildDrawerItem(Icons.headset_mic_outlined, 'HELP & CENTER', () {
              _showHelpDialog();
            }),
            _buildDrawerItem(Icons.info_outline, 'ABOUT', () {
              _showAboutDialog();
            }),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Hi, Youssef',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.sp,
            fontFamily: 'Convergence',
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: ValueListenableBuilder<String?>(
              valueListenable: profileImageNotifier,
              builder: (context, imagePath, _) {
                ImageProvider imageProvider;
                if (imagePath == null ||
                    imagePath.isEmpty ||
                    !(File(imagePath).existsSync())) {
                  imageProvider = AssetImage('assets/logo.png');
                } else {
                  imageProvider = FileImage(File(imagePath));
                }
                return CircleAvatar(
                  radius: 18.r,
                  backgroundImage: imageProvider,
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 14.h),
                      InfoCard(key: ValueKey(_infoCardRefreshKey)),
                      SizedBox(height: 30.h),
                      Text(
                        'Medicines 💊',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Convergence',
                        ),
                      ),
                      SizedBox(height: 23.h),
                      ...meds.map(
                        (med) => Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: MedicineCard(
                            image: '',
                            title: med.name,
                            subtitle: med.times
                                .map((t) => t.format(context))
                                .join(', '),
                            frequency: '${med.timesPerDay} times',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ChatBotButton(),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54, size: 22.sp),
      title: Text(
        title,
        style: TextStyle(color: Colors.black87, fontSize: 16.sp),
      ),
      onTap: onTap,
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Help & Center', style: TextStyle(fontSize: 18.sp)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue, size: 22.sp),
              title: Text('support@sugariq.com',
                  style: TextStyle(fontSize: 14.sp)),
            ),
            SizedBox(height: 8.h),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.green, size: 22.sp),
              title:
                  Text('+20 120 298 5507', style: TextStyle(fontSize: 14.sp)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close',
                style: TextStyle(color: Colors.black, fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('About SugarIQ', style: TextStyle(fontSize: 18.sp)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SugarIQ is your smart diabetes companion.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Color(0xFF1978B4),
              ),
            ),
            SizedBox(height: 10.h),
            Text('• Track your glucose, meals, and medications easily.',
                style: TextStyle(fontSize: 14.sp)),
            SizedBox(height: 6.h),
            Text('• Get personalized reminders and reports.',
                style: TextStyle(fontSize: 14.sp)),
            SizedBox(height: 6.h),
            Text(
                '• Designed to help you manage your health and live better every day.',
                style: TextStyle(fontSize: 14.sp)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close',
                style: TextStyle(color: Colors.black, fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}
