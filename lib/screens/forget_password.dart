import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/app_theme.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _message;

  Future<void> _resetPassword() async {
    setState(() {
      _loading = true;
      _message = null;
    });

    /*try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      setState(() {
        _message =
            "📩 A password reset link has been sent to your email address.";
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = "❌ Error: \${e.message}";
      });
    }*/

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => Scaffold(
        backgroundColor: const Color(0xFFF1F4F8),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/Forget_Pasword.png',
                      height: 300.h,
                    ),
                    SizedBox(height: 30.h),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.buttonColor,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: _loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _resetPassword();
                                }
                              },
                        child: _loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Reset Password',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    if (_message != null)
                      Text(
                        _message!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: _message!.startsWith("❌")
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
