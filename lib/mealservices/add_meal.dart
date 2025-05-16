import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/meal.dart';

class AddMealScreen extends StatefulWidget {
  final Function(Meal) onMealAdded;

  const AddMealScreen({super.key, required this.onMealAdded});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String name = '';
  int calories = 0;
  int glucoseLevel = 0;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final meal = Meal(
        name: name,
        imageUrl: 'assets/meal.webp',
        calories: calories,
        glucoseLevel: glucoseLevel,
        dateTime: DateTime.now(),
      );

      widget.onMealAdded(meal);

      // Save to Firestore
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('meals')
            .add(meal.toJson());
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Meal Manually"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Meal Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter a meal name' : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Calories (kcal)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter calories' : null,
                onSaved: (value) => calories = int.parse(value!),
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Glucose Level (mg/dL)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter glucose level' : null,
                onSaved: (value) => glucoseLevel = int.parse(value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Add Meal"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
