import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarCheckScreen extends StatefulWidget {
  const CalendarCheckScreen({super.key});

  @override
  _CalendarCheckScreenState createState() => _CalendarCheckScreenState();
}

class _CalendarCheckScreenState extends State<CalendarCheckScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadEventsFromFirestore();
  }

  Future<void> _loadEventsFromFirestore() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('calendarEvents')
            .get();

        setState(() {
          _events = {
            for (var doc in snapshot.docs)
              (doc['date'] as Timestamp).toDate():
                  List<String>.from(doc['events'] as List)
          };
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load events: $e')),
      );
    }
  }

  Future<void> _addEventToFirestore(DateTime date, String event) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final docRef = _firestore
            .collection('users')
            .doc(user.uid)
            .collection('calendarEvents')
            .doc(date.toIso8601String());

        final doc = await docRef.get();
        if (doc.exists) {
          await docRef.update({
            'events': FieldValue.arrayUnion([event]),
          });
        } else {
          await docRef.set({
            'date': date,
            'events': [event],
          });
        }

        setState(() {
          _events.update(
            date,
            (existing) => [...existing, event],
            ifAbsent: () => [event],
          );
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add event: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              eventLoader: (day) {
                return _events[day] ?? [];
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 20),
            Text(
              _selectedDay == null
                  ? 'No date selected'
                  : 'Selected Date: ${_selectedDay!.toLocal()}\nEvents: ${_events[_selectedDay]?.join(', ') ?? 'None'}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_selectedDay != null) {
                  final event = await showDialog<String>(
                    context: context,
                    builder: (context) {
                      String newEvent = '';
                      return AlertDialog(
                        title: const Text('Add Event'),
                        content: TextField(
                          onChanged: (value) => newEvent = value,
                          decoration: const InputDecoration(hintText: 'Event'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, newEvent),
                            child: const Text('Add'),
                          ),
                        ],
                      );
                    },
                  );

                  if (event != null && event.isNotEmpty) {
                    _addEventToFirestore(_selectedDay!, event);
                  }
                }
              },
              child: const Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}
