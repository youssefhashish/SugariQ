import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sugar_iq/profile%20page/profile_edit.dart';
import 'package:sugar_iq/widgets/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 18.sp)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildSectionTitle('Account'),
          _buildSettingItem('Manage Profile', Icons.person),
          _buildDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Row(
              children: [
                Icon(Icons.notifications, color: Colors.grey, size: 24.sp),
                SizedBox(width: 20.w),
                Text('Notification', style: TextStyle(fontSize: 16.sp)),
                const Spacer(),
                Switch(
                  value: isNotificationOn,
                  activeColor: AppTheme.buttonColor,
                  onChanged: (val) {
                    setState(() {
                      isNotificationOn = val;
                    });
                  },
                ),
              ],
            ),
          ),
          _buildSectionTitle('About'),
          _buildSettingItem('Rate Us', Icons.star_outline),
          _buildDivider(),
          _buildSettingItem('Privacy & Policy', Icons.privacy_tip_outlined),
          _buildDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.grey, size: 24.sp),
                SizedBox(width: 20.w),
                Text('Version', style: TextStyle(fontSize: 16.sp)),
                const Spacer(),
                Text('1.0.0',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16.sp)),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () => _showLogoutConfirmation(context),
                child: Text(
                  'LOG OUT',
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.red.shade50,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () => _showDeleteAccountConfirmation(context),
                child:
                    Text('DELETE ACCOUNT', style: TextStyle(fontSize: 16.sp)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: InkWell(
        onTap: () {
          if (title == 'Manage Profile') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileEditPage()));
          }
          if (title == 'Privacy & Policy') {
            Navigator.pushNamed(context, '/privacy');
          }
        },
        child: Row(
          children: [
            Icon(icon, color: Colors.grey, size: 24.sp),
            SizedBox(width: 20.w),
            Text(title, style: TextStyle(fontSize: 16.sp)),
            const Spacer(),
            Icon(Icons.chevron_right, color: Colors.grey, size: 22.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1.h,
      thickness: 1.h,
      indent: 20.w,
      endIndent: 20.w,
      color: const Color(0xFFEEEEEE),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Log Out', style: TextStyle(fontSize: 18.sp)),
        content: Text('Are you sure you want to log out?',
            style: TextStyle(fontSize: 16.sp)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontSize: 16.sp)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            child: Text('Log Out',
                style: TextStyle(color: Colors.red, fontSize: 16.sp)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account', style: TextStyle(fontSize: 18.sp)),
        content: Text(
          'This will permanently delete your account and all associated data.',
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontSize: 16.sp)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account deleted successfully')),
              );
            },
            child: Text('Delete',
                style: TextStyle(color: Colors.red, fontSize: 16.sp)),
          ),
        ],
      ),
    );
  }
}
