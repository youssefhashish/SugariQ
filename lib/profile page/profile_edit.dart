import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'user/user.dart';
import 'user/user_data.dart';
import 'package:sugar_iq/widgets/app_theme.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController descController;
  late User user;

  @override
  void initState() {
    super.initState();
    user = UserData.getUser();
    nameController = TextEditingController(text: user.name);
    phoneController = TextEditingController(text: user.phone);
    emailController = TextEditingController(text: user.email);
    descController = TextEditingController(text: user.aboutMeDescription);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    descController.dispose();
    super.dispose();
  }

  void saveProfile() {
    final updatedUser = user.copy(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      aboutMeDescription: descController.text,
    );
    UserData.setUser(updatedUser);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: AppTheme.primary, fontSize: 20.sp),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/health_info');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(fontSize: 16.sp),
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                labelStyle: TextStyle(fontSize: 16.sp),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(fontSize: 16.sp),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(fontSize: 16.sp),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(fontSize: 18.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
