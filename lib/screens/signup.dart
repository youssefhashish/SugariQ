import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_button.dart';
import '../../validator.dart';
import '../widgets/custom_text_filed.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    // TODO: implement initState
    super.initState();

    firstnameField = CustomTextField(
      baseColor: Color(0xFF5FB794),
      hintColor: Colors.grey,
      borderColor: Colors.black,
      errorColor: Colors.red,
      controller: firstname,
      obscureText: false,
      hint: "First Name",
      inputType: TextInputType.text,
      validator: Validator.validateName,
      onChanged: (value) {},
    );

    lastnameField = CustomTextField(
      baseColor: Color(0xFF5FB794),
      hintColor: Colors.grey,
      borderColor: Colors.black,
      errorColor: Colors.red,
      controller: lastname,
      obscureText: false,
      hint: "Last Name",
      inputType: TextInputType.text,
      validator: Validator.validateName,
      onChanged: (value) {},
    );

    emailField = CustomTextField(
      baseColor: Color(0xFF5FB794),
      hintColor: Colors.grey,
      borderColor: Colors.black,
      errorColor: Colors.red,
      controller: email,
      obscureText: false,
      hint: "E-mail",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
      onChanged: (value) {},
    );

    phonenumberField = CustomTextField(
      baseColor: Color(0xFF5FB794),
      hintColor: Colors.grey,
      borderColor: Colors.black,
      errorColor: Colors.red,
      controller: phonenumber,
      obscureText: false,
      hint: "Phone Number",
      inputType: TextInputType.number,
      validator: Validator.validateNumber,
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

    reenterpasswordField = CustomTextField(
      baseColor: Color(0xFF5FB794),
      hintColor: Colors.grey,
      borderColor: Colors.black,
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
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF5FB794),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(null),
              ),
            ],
            leading: Container(),
          ),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 30.0, right: 10.0),
                      child: Text(
                        "Register for an Account",
                        style: TextStyle(
                          fontFamily: "OpenSans-Bold",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 30.0, right: 10.0),
                      child: Text(
                        "Welcome!",
                        style: TextStyle(
                          fontFamily: "OpenSans-Bold",
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 1.0, left: 30.0, right: 30.0),
                      child: Text(
                        "We just need to get a few details from you to get you signed up to this service.",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 30.0, right: 30.0),
                      child: firstnameField,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 30.0, right: 30.0),
                      child: lastnameField,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 30.0, right: 30.0),
                      child: emailField,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 30.0, right: 30.0),
                      child: phonenumberField,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 30.0, right: 30.0),
                      child: passwordField,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 30.0, right: 30.0),
                      child: reenterpasswordField,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
                      child: CustomFlatButton(
                        title: "Submit",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        splashColor: Colors.black12,
                        borderColor: Colors.black,
                        borderWidth: 0,
                        color: Color(0xFF5FB794),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
