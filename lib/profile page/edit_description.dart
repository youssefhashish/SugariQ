import 'package:flutter/material.dart';
import 'user/user_data.dart';

class EditDescriptionFormPage extends StatefulWidget {
  @override
  _EditDescriptionFormPageState createState() =>
      _EditDescriptionFormPageState();
}

class _EditDescriptionFormPageState extends State<EditDescriptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void updateUserValue(String description) {
    user.aboutMeDescription = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 10,
        ),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    width: 350,
                    child: const Text(
                      "What type of passenger\nare you?",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                        height: 250,
                        width: 350,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 200) {
                              return 'Please describe yourself but keep it under 200 characters.';
                            }
                            return null;
                          },
                          controller: descriptionController,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 15, 10, 100),
                              hintMaxLines: 3,
                              hintText:
                                  'Write a little bit about yourself. Do you like chatting? Are you a smoker? Do you bring pets with you? Etc.'),
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF85C26F)),
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                updateUserValue(descriptionController.text);
                                await UserData.setUser(UserData.myUser);
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}
