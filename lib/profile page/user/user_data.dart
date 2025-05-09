import 'dart:convert';

import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static User myUser = User(
    image: "assets/logo.jpg",
    name: 'Test Test',
    email: 'test.test@gmail.com',
    phone: '(208) 206-5039',
    aboutMeDescription: 'ADD YOUR DESCRIPTION HERE. (Optional)',
  );

  static void updateUser(User user) {
    myUser = user;
  }

  static void updateImage(String newImagePath) {
    myUser.image = newImagePath;
  }

  static void updateName(String name) {
    myUser.name = name;
  }

  static void updatePhone(String phone) {
    myUser.phone = phone;
  }

  static void updateEmail(String email) {
    myUser.email = email;
  }

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());
    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);
    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
