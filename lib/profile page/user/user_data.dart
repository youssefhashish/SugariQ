import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'user.dart';

class UserData {
  static final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User myUser = User(
    image: "assets/logo.jpg",
    firstName: 'Test',
    lastName: 'Test',
    email: 'test.test@gmail.com',
    phoneNumber: '(208) 206-5039',
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

static Future<User> getUser() async {
  final currentUser = _auth.currentUser;
  if (currentUser != null) {
    final doc = await _firestore.collection('users').doc(currentUser.uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      return User.fromJson({
        ...data,
        'email': currentUser.email ?? '', // force email from Firebase Auth
      });
    }
  }
  return myUser;
}

}
