/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _message;

  Future<void> _resetPassword() async {
    setState(() {
      _loading = true;
      _message = null;
    });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      setState(() {
        _message =
            "📩 A password reset link has been sent to your email address.";
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = "❌ Error: ${e.message}";
      });
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Enter your email to receive a password reset link.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address.';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton.icon(
                    icon: Icon(Icons.send),
                    label: Text('Send Reset Link'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _resetPassword();
                      }
                    },
                  ),
            if (_message != null) ...[
              SizedBox(height: 20),
              Text(
                _message!,
                style: TextStyle(
                  color: _message!.startsWith("❌") ? Colors.red : Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ]
          ],
        ),
      ),
    );
  }
}*/
