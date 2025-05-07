import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/app_theme.dart';
import '../widgets/progress_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? gender;
  String? age;
  String? diabetesType;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic> get userPreferences => {
        'gender': gender,
        'age': age,
        'diabetesType': diabetesType,
      };

  @override
  void initState() {
    super.initState();
    _loadUserDataFromFirestore();
  }

  Future<void> _loadUserDataFromFirestore() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        final data = doc.data();
        if (data != null) {
          setState(() {
            gender = data['gender'];
            age = data['age'];
            diabetesType = data['diabetesType'];
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data: $e')),
      );
    }
  }

  Future<void> _saveUserDataToFirestore() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'gender': gender,
          'age': age,
          'diabetesType': diabetesType,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save user data: $e')),
      );
    }
  }

  Future<void> _saveUserPreferences() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'preferences': userPreferences,
      }, SetOptions(merge: true));
    }
  }

  void _selectOption(
      String title, List<String> options, ValueChanged<String> onSelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: options.map((option) {
          return ListTile(
            title: Text(option),
            onTap: () {
              Navigator.pop(context);
              onSelected(option);
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(24, 80, 24, 32),
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            Positioned(
              top: 60,
              left: 68,
              child: SizedBox(
                width: 350,
                height: 6,
                child: CustomPaint(
                  painter: ProgressBarPainter(progress: 0.25), // 25% progress
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Tell us about yourself',
              style: AppTheme.titleStyle,
            ),
            const SizedBox(height: 6),
            const Text(
              'Your individual parametres are important for SugariQ for indepth personalization.',
              style: AppTheme.subtitleStyle,
            ),
            const SizedBox(height: 46),
            _buildTile(
              icon: Icons.person_outline,
              iconBgColor: Colors.blue.shade50,
              title: 'Gender',
              value: gender ?? 'Select',
              onTap: () => _selectOption('Gender', ['Male', 'Female'], (val) {
                setState(() => gender = val);
                _saveUserDataToFirestore();
              }),
            ),
            SizedBox(
              height: 40,
            ),
            _buildTile(
              icon: Icons.calendar_today_outlined,
              iconBgColor: Colors.purple.shade50,
              title: 'Age',
              value: age ?? 'Select',
              onTap: () => _selectOption(
                  'Age', List.generate(100, (i) => '${i + 1}'), (val) {
                setState(() => age = val);
                _saveUserDataToFirestore();
              }),
            ),
            SizedBox(
              height: 40,
            ),
            _buildTile(
              icon: Icons.bloodtype_outlined,
              iconBgColor: Colors.red.shade50,
              title: 'Diabetes type',
              value: diabetesType ?? 'Select',
              onTap: () => _selectOption(
                  'Diabetes type', ['Type 1', 'Type 2', 'Gestational'], (val) {
                setState(() => diabetesType = val);
                _saveUserDataToFirestore();
              }),
            ),
            const SizedBox(height: 185),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF6FBE5A), Color(0xFF85C26F)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 44,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/diabetesType');
                  },
                  child: const Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Convergence',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/prediction');
                },
                child: Text(
                  'You want to make sure if you have Diabetes or not?',
                  style: TextStyle(color: Color(0xFF1978B4)),
                )),
          ],
        ),
      ),
    );
  }
}

Widget _buildTile({
  required IconData icon,
  required Color iconBgColor,
  required String title,
  required String value,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Container(
      decoration: BoxDecoration(
          color: iconBgColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(8.0),
      height: 55,
      width: 55,
      child: Icon(icon, color: Colors.black54),
    ),
    title: Text(title),
    trailing: TextButton(
      onPressed: onTap,
      child: Text(
        value,
        style: TextStyle(
          color: value == 'Select' ? Colors.blue : Colors.black,
        ),
      ),
    ),
  );
}
