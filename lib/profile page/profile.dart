import 'dart:async';
import 'package:flutter/material.dart';
import 'edit_description.dart';
import 'edit_email.dart';
import 'edit_image.dart';
import 'edit_name.dart';
import 'edit_phone.dart';
import 'user/display_image.dart';
import 'user/user.dart';
import 'user/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final u = await UserData.getUser();
    setState(() {
      user = u;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: user == null
          ? Center(child: CircularProgressIndicator()) // show loader until user loads
          : Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF85C26F),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    navigateSecondPage(EditImagePage());
                  },
                  child: DisplayImage(
                    imagePath: user?.image ?? '',
                    onPressed: () {},
                  ),
                ),
                buildUserInfoDisplay('${user?.firstName ?? ''} ${user?.lastName ?? ''}', 'Name', EditNameFormPage()),
                buildUserInfoDisplay(user?.phoneNumber ?? '', 'Phone Number', EditPhoneFormPage()),
                buildUserInfoDisplay(user?.email ?? '', 'Email', null),
                Expanded(
                  child: buildAbout(user!),
                  flex: 4,
                ),
              ],
            ),
    );
  }

  Widget buildUserInfoDisplay(String value, String title, Widget? editPage) => Padding(
  padding: EdgeInsets.only(bottom: 10),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
      SizedBox(height: 1),
      Container(
        width: 350,
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: editPage == null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ),
                    )
                  : TextButton(
                      onPressed: () => navigateSecondPage(editPage),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16, height: 1.4),
                        ),
                      ),
                    ),
            ),
            if (editPage != null)
              Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 40.0),
          ],
        ),
      )
    ],
  ),
);

  Widget buildAbout(User user) => Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tell Us About Yourself',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 1),
            Container(
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        navigateSecondPage(EditDescriptionFormPage());
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            user.aboutMeDescription,
                            style: TextStyle(fontSize: 16, height: 1.4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 40.0),
                ],
              ),
            )
          ],
        ),
      );

  FutureOr onGoBack(dynamic value) {
    loadUser(); // refresh user after returning from any edit screen
  }

  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
