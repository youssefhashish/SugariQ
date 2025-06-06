import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sugar_iq/widgets/app_theme.dart';
import '../../validator.dart';
import '../widgets/custom_text_filed.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController reenterpassword = TextEditingController();

  late CustomTextField firstnameField;
  late CustomTextField lastnameField;
  late CustomTextField emailField;
  late CustomTextField phonenumberField;
  late CustomTextField passwordField;
  late CustomTextField reenterpasswordField;

  @override
  void initState() {
    super.initState();

    firstnameField = CustomTextField(
      baseColor: AppTheme.primary,
      hintColor: Colors.grey,
      borderColor: Colors.grey.shade300,
      errorColor: Colors.red,
      controller: firstname,
      obscureText: false,
      hint: "First Name",
      inputType: TextInputType.text,
      validator: Validator.validateName,
      onChanged: (value) {},
    );

    lastnameField = CustomTextField(
      baseColor: AppTheme.primary,
      hintColor: Colors.grey,
      borderColor: Colors.grey.shade300,
      errorColor: Colors.red,
      controller: lastname,
      obscureText: false,
      hint: "Last Name",
      inputType: TextInputType.text,
      validator: Validator.validateName,
      onChanged: (value) {},
    );

    emailField = CustomTextField(
      baseColor: AppTheme.primary,
      hintColor: Colors.grey,
      borderColor: Colors.grey.shade300,
      errorColor: Colors.red,
      controller: email,
      obscureText: false,
      hint: "E-mail",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
      onChanged: (value) {},
    );

    phonenumberField = CustomTextField(
      baseColor: AppTheme.primary,
      hintColor: Colors.grey,
      borderColor: Colors.grey.shade300,
      errorColor: Colors.red,
      controller: phonenumber,
      obscureText: false,
      hint: "Phone Number",
      inputType: TextInputType.phone,
      validator: Validator.validateNumber,
      onChanged: (value) {},
    );

    passwordField = CustomTextField(
      baseColor: AppTheme.primary,
      hintColor: Colors.grey,
      borderColor: Colors.grey.shade300,
      errorColor: Colors.red,
      controller: password,
      obscureText: true,
      hint: "Password",
      inputType: TextInputType.text,
      validator: Validator.validatePassword,
      onChanged: (value) {},
    );

    reenterpasswordField = CustomTextField(
      baseColor: AppTheme.primary,
      hintColor: Colors.grey,
      borderColor: Colors.grey.shade300,
      errorColor: Colors.red,
      controller: reenterpassword,
      obscureText: true,
      hint: "Re-Enter Password",
      inputType: TextInputType.text,
      validator: Validator.validatePassword,
      onChanged: (value) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FB),
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 16.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Register for an Account",
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans-Bold",
                        color: Color(0xFF222B45),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Welcome!",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5FB794),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "We just need a few details to get you signed up.",
                      style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                    ),
                    SizedBox(height: 24.h),
                    firstnameField,
                    SizedBox(height: 10.h),
                    lastnameField,
                    SizedBox(height: 10.h),
                    emailField,
                    SizedBox(height: 10.h),
                    phonenumberField,
                    SizedBox(height: 10.h),
                    passwordField,
                    SizedBox(height: 10.h),
                    reenterpasswordField,
                    SizedBox(height: 30.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          elevation: 2,
                        ),
                        onPressed: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, '/prediction');
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
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
