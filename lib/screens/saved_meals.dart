import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_iq/screens/meal.dart';
import 'package:sugar_iq/widgets/app_theme.dart';

class SavedMealsPage extends StatefulWidget {
  final Function onMealsUpdated;

  const SavedMealsPage({super.key, required this.onMealsUpdated});

  @override
  State<SavedMealsPage> createState() => _SavedMealsPageState();
}

class _SavedMealsPageState extends State<SavedMealsPage> {
  List<Meal> meals = [];
  Set<int> eatenIndexes = {};

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final mealsJson = prefs.getStringList('meals') ?? [];
    final eatenJson = prefs.getStringList('eatenMeals') ?? [];

    setState(() {
      meals = mealsJson.map((e) => Meal.fromJson(jsonDecode(e))).toList();
      eatenIndexes = eatenJson.map((e) => int.parse(e)).toSet();
    });
  }

  Future<void> _toggleEaten(int index) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (eatenIndexes.contains(index)) {
        eatenIndexes.remove(index);
      } else {
        eatenIndexes.add(index);
      }
    });

    await prefs.setStringList(
      'eatenMeals',
      eatenIndexes.map((i) => i.toString()).toList(),
    );

    widget.onMealsUpdated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Meals'),
        backgroundColor: AppTheme.primary,
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(meal.imageUrl),
            ),
            title: Text(meal.name),
            subtitle: Text('Glucose: ${meal.glucoseLevel} mg/dL'),
            trailing: Checkbox(
              value: eatenIndexes.contains(index),
              onChanged: (_) => _toggleEaten(index),
            ),
          );
        },
      ),
    );
  }
}
