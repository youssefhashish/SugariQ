import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

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

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: username.text.trim(),
        password: password.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavWrapper()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                      padding: const EdgeInsets.only(left: 200.0),
                      child: CustomFlatButton(
                        title: "Forget password?",
                        fontSize: 14,
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
                    padding: const EdgeInsets.only(
                        top: 50.0, left: 40.0, right: 40.0),
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : CustomFlatButton(
                            title: "Login",
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.white,
                            onPressed: _login,
                            splashColor: Colors.black12,
                            borderColor: Colors.black,
                            borderWidth: 0,
                            color: Color(0xFF85C26F),
                          ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                      child: CustomFlatButton(
                        title: "Don’t have an account? Register",
                        fontSize: 14,
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
    );
  }
}
