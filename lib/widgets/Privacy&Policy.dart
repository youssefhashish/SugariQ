import 'package:flutter/material.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Policy'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1978B4),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Your privacy is important to us. This policy explains how we collect, use, and protect your information.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 18),
            Text(
              "• We collect only the data necessary to provide and improve our services.",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 10),
            Text(
              "• Your data is stored securely and is not shared with third parties except as required by law.",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 10),
            Text(
              "• You can request to delete your account and data at any time from the app settings.",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 10),
            Text(
              "• We may update this policy from time to time. Please review it regularly.",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 24),
            Text(
              "If you have any questions about our privacy practices, please contact us at support@sugariq.com.",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
