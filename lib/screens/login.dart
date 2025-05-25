import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.asset(
                      "assets/login_logo.png",
                      height: 400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 40.0, right: 40.0),
                    child: usernameField,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 40.0, right: 40.0),
                    child: passwordField,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 200.0),
                      child: CustomFlatButton(
                        title: "Forget password?",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgotPassword');
                        },
                        splashColor: Colors.black12,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        color: Colors.transparent,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 50.0, left: 40.0, right: 40.0),
                    child: CustomFlatButton(
                      title: "Login",
                      fontSize: 22,
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
                      borderColor: Colors.black,
                      borderWidth: 0,
                      color: AppTheme.primary,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                      child: CustomFlatButton(
                        title: "Don’t have an account?",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        textColor: AppTheme.primaryBlue,
                        onPressed: () {
                          Navigator.of(context).pushNamed("/signup");
                        },
                        splashColor: Colors.black12,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        color: Colors.transparent,
                      ))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
