import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../validator.dart';
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
    // TODO: implement initState
    super.initState();

    usernameField = CustomTextField(
      baseColor: Color(0xFF5FB794),
      hintColor: Colors.grey,
      borderColor: Colors.black,
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
      borderColor: Colors.black,
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
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Image.asset("assets/logo.jpg"),
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
                        padding: const EdgeInsets.only(
                            top: 50.0, left: 40.0, right: 40.0),
                        child: CustomFlatButton(
                          title: "Login",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pushNamed("/home");
                          },
                          splashColor: Colors.black12,
                          borderColor: Colors.black,
                          borderWidth: 0,
                          color: Color(0xFF5FB794),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 50.0, left: 100.0, right: 100.0),
                          child: CustomFlatButton(
                            title: "Forget password?",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgetPassword');
                            },
                            splashColor: Colors.black12,
                            borderColor: Colors.transparent,
                            borderWidth: 0,
                            color: Colors.transparent,
                          )),
                      Padding(
                          padding:
                              const EdgeInsets.only(left: 80.0, right: 80.0),
                          child: CustomFlatButton(
                            title: "Don’t have an account? Register",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            textColor: Color(0xFFAC0808),
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
        ),
      ),
    );
  }
}
