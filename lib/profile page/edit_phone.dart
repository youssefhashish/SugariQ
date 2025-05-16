import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'user/user_data.dart';
import 'user/user.dart';

class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key}) : super(key: key);

  @override
  EditPhoneFormPageState createState() => EditPhoneFormPageState();
}

class EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    user = await UserData.getUser();
    setState(() {
      phoneController.text =
          user!.phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    });
  }

  Future<void> updateUserValue(String phoneNumber) async {
    if (user == null) return;

    String formattedPhoneNumber = "(" +
        phoneNumber.substring(0, 3) +
        ") " +
        phoneNumber.substring(3, 6) +
        "-" +
        phoneNumber.substring(6);

    User updatedUser = user!.copy(phoneNumber: formattedPhoneNumber);
    await UserData.setUser(updatedUser);
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 10,
        ),
        body: user == null
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        width: 320,
                        child: Text(
                          "What's Your Phone Number?",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: SizedBox(
                          height: 100,
                          width: 320,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (!isNumeric(value)) {
                                return 'Only numbers please';
                              } else if (value.length < 10) {
                                return 'Must be at least 10 digits';
                              }
                              return null;
                            },
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Your Phone Number',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: 320,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      updateUserValue(phoneController.text)
                                          .then((_) {
                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              )))
                    ]),
              ));
  }
}
