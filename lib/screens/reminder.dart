// ------------------------- Reminder Screen -------------------------
import 'package:flutter/material.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Morning Medication'),
            subtitle: Text('8:00 AM'),
          ),
          ListTile(
            title: Text('Evening Medication'),
            subtitle: Text('8:00 PM'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
