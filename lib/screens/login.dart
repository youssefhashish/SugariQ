import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sugar_iq/widgets/app_theme.dart';
import '../../validator.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_filed.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  late CustomTextField usernameField;
  late CustomTextField passwordField;

  @override
  void initState() {
    super.initState();

    usernameField = CustomTextField(
      baseColor: Color(0xFF5FB794),
      hintColor: Colors.grey,
      borderColor: Colors.grey.shade300,
      errorColor: Colors.red,
      controller: username,
      obscureText: false,
      hint: "Username",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
      onChanged: (value) {},
    );

    passwordField = CustomTextField(
      baseColor: Color(0xFF5FB794),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Image.asset(
                      "assets/login_logo.png",
                      height: 400.h,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 5.h),
                    child: usernameField,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 5.h),
                    child: passwordField,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 200.w),
                    child: CustomFlatButton(
                      title: "Forget password?",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgotPassword');
                      },
                      splashColor: Colors.black12,
                      color: Colors.transparent,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 50.h, left: 40.w, right: 40.w),
                    child: CustomFlatButton(
                      title: "Login",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavWrapper()),
                        );
                      },
                      splashColor: Colors.black12,
                      color: AppTheme.primary,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    child: CustomFlatButton(
                      title: "Don’t have an account?",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      textColor: AppTheme.primaryBlue,
                      onPressed: () {
                        Navigator.of(context).pushNamed("/signup");
                      },
                      splashColor: Colors.black12,
                      color: Colors.transparent,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
