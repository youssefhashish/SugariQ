/*import 'package:flutter/material.dart';
import '../screens/meal.dart';

class AddMealScreen extends StatefulWidget {
  final Function(Meal) onMealAdded;

  const AddMealScreen({super.key, required this.onMealAdded});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String imageUrl = '';
  int calories = 0;
  int glucoseLevel = 0;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final meal = Meal(
        name: name,
        imageUrl: imageUrl,
        calories: calories,
        glucoseLevel: glucoseLevel,
      );

      widget.onMealAdded(meal);
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
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) => value!.isEmpty ? 'Enter image URL' : null,
                onSaved: (value) => imageUrl = value!,
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
}*/

import 'package:flutter/material.dart';
import '../screens/meal.dart';

class AddMealScreen extends StatefulWidget {
  final Function(Meal) onMealAdded;

  const AddMealScreen({super.key, required this.onMealAdded});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int calories = 0;
  int glucoseLevel = 0;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final meal = Meal(
        name: name,
        imageUrl: 'assets/meal.webp',
        calories: calories,
        glucoseLevel: glucoseLevel,
      );

      widget.onMealAdded(meal);
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
