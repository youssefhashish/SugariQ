// ------------------------- Settings Screen -------------------------
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
