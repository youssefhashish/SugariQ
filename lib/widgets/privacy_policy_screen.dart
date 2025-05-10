import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Privacy & Policy',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100], // Light grey background for the body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Terms & Conditions',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 8),
            const Text(
              'By clicking “I Agree” you are agreeing to the Terms and Conditions.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 14, color: Colors.black87, height: 1.5),
                    children: <TextSpan>[
                      const TextSpan(
                          text:
                              'These terms and conditions ("User Terms”) read with the Privacy Policy available on the Application constitutes a '),

                      TextSpan(
                          text:
                              'legal binding agreement between You and SugarIQ and shall apply to and govern Your visit to and use',
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                      const TextSpan(
                          text:
                              ', of the Application (whether in the capacity of an user or a Practitioner) and any of its products or services through mobile phone as well as to all information, recommendations and or Services provided to You on or through the Application.'),
                      // Add more TextSpans here if there are more distinct parts or highlights
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[50],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'I Agree',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// To run this screen, you can use a main.dart file like this:
/*
import 'package:flutter/material.dart';
// Assuming your privacy_policy_screen.dart file is in the lib directory
// import 'privacy_policy_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Privacy Policy Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Example font, adjust as needed
      ),
      home: const PrivacyPolicyScreen(), // Set PrivacyPolicyScreen as home
    );
  }
}
*/
