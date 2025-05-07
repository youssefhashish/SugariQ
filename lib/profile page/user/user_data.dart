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

  static Future<void> setUser(User user) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .set(user.toJson(), SetOptions(merge: true));
        myUser = user;
      }
    } catch (e) {
      print('❌ Error updating user: $e');
    }
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
