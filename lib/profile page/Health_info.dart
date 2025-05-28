import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/app_theme.dart';
import '../splash/prediction_page.dart';

class HealthInfo extends StatefulWidget {
  const HealthInfo({super.key});

  @override
  State<HealthInfo> createState() => _HealthInfoState();
}

class _HealthInfoState extends State<HealthInfo> {
  String? gender;
  String? age;
  String? diabetesType;

  @override
  void initState() {
    super.initState();
    gender = PredictionScreen.lastGender;
    age = PredictionScreen.lastAge;
    diabetesType = PredictionScreen.lastDiabetesType;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, __) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Health Info',
            style: TextStyle(
              color: AppTheme.primary,
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20.w),
          constraints: BoxConstraints(maxWidth: 480.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your individual parameters are important for SugariQ for in-depth personalization.',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 30.h),
              _buildInfoCard(
                icon: Icons.person_outline,
                iconColor: Colors.blue.shade50,
                title: 'Gender',
                value: gender ?? 'Not set',
              ),
              SizedBox(height: 20.h),
              _buildInfoCard(
                icon: Icons.calendar_today_outlined,
                iconColor: Colors.purple.shade50,
                title: 'Age',
                value: age ?? 'Not set',
              ),
              SizedBox(height: 20.h),
              _buildInfoCard(
                icon: Icons.bloodtype_outlined,
                iconColor: Colors.red.shade50,
                title: 'Diabetes type',
                value: diabetesType ?? 'Not set',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.all(8.0.w),
          height: 55.h,
          width: 55.w,
          child: Icon(icon, color: Colors.black54, size: 24.sp),
        ),
        title: Text(title, style: TextStyle(fontSize: 16.sp)),
        trailing: Text(value, style: TextStyle(fontSize: 16.sp)),
        enabled: false,
      ),
    );
  }
}
