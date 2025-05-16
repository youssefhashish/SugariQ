import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../mealservices/add_meal.dart';
import '../mealservices/spoonacular_services.dart';

class Meal {
  final String name;
  final String imageUrl;
  final int calories;
  final int glucoseLevel;
  final DateTime dateTime;

  Meal({
    required this.name,
    required this.imageUrl,
    required this.calories,
    required this.glucoseLevel,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'calories': calories,
        'glucoseLevel': glucoseLevel,
        'dateTime': dateTime.toIso8601String(),
      };

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        name: json['name'],
        imageUrl: json['imageUrl'],
        calories: json['calories'],
        glucoseLevel: json['glucoseLevel'],
        dateTime: DateTime.parse(json['dateTime']),
      );
}

class MealsPage extends StatefulWidget {
  final VoidCallback? onMealAdded;

  const MealsPage({super.key, this.onMealAdded});
  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  List<Meal> addedMeals = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadMealsFromFirestore();
  }

  Future<void> _loadMealsFromFirestore() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('meals')
            .get();

        setState(() {
          addedMeals = snapshot.docs
              .map((doc) => Meal.fromJson(doc.data()))
              .toList();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load meals: $e')),
      );
    }
  }

  Future<void> _saveMealsToFirestore() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final batch = _firestore.batch();
        final mealsCollection = _firestore
            .collection('users')
            .doc(user.uid)
            .collection('meals');

        // Clear existing meals
        final existingMeals = await mealsCollection.get();
        for (var doc in existingMeals.docs) {
          batch.delete(doc.reference);
        }

        // Add updated meals
        for (var meal in addedMeals) {
          final docRef = mealsCollection.doc();
          batch.set(docRef, meal.toJson());
        }

        await batch.commit();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save meals: $e')),
      );
    }
  }

  /*void _addMeal(Meal meal) {
    final mealWithTime = Meal(
      name: meal.name,
      imageUrl: meal.imageUrl,
      calories: meal.calories,
      glucoseLevel: meal.glucoseLevel,
      dateTime: DateTime.now(),
    );

    setState(() {
      addedMeals.add(mealWithTime);
    });
    _saveMealsToFirestore();
    _saveMeals();
  }*/
  void _addMeal(Meal meal) {
    final mealWithTime = Meal(
      name: meal.name,
      imageUrl: meal.imageUrl,
      calories: meal.calories,
      glucoseLevel: meal.glucoseLevel,
      dateTime: DateTime.now(),
    );

    setState(() {
      addedMeals.add(mealWithTime);
    });
    _saveMeals();

    if (widget.onMealAdded != null) {
      widget.onMealAdded!();
    }
  }

  void _showMealPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Choose from online meals'),
              onTap: () {
                Navigator.pop(context);
                _fetchAndShowSpoonacularMeals();
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Add a meal manually'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddMealScreen(
                      onMealAdded: _addMeal,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _fetchAndShowSpoonacularMeals() async {
    try {
      final meals = await SpoonacularService.fetchMeals();
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: meals.map((meal) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(meal.image,
                        width: 60, height: 60, fit: BoxFit.cover),
                  ),
                  title: Text(meal.title),
                  subtitle:
                      Text('${meal.calories} kcal • Carbs: ${meal.carbs} g'),
                  trailing: const Icon(Icons.add),
                  onTap: () {
                    _addMeal(Meal(
                      name: meal.title,
                      imageUrl: meal.image,
                      calories: meal.calories,
                      glucoseLevel: meal.carbs.toInt(),
                      dateTime: DateTime.now(),
                    ));
                    Navigator.pop(context);
                  },
                ),
              );
            }).toList(),
          );
        },
      );
    } catch (e) {
      SnackBar(content: Text('Failed to fetch meals: $e'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Meals 🍽️', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: addedMeals.isEmpty
          ? const Center(
              child: Text(
                'No meals added yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: addedMeals.length,
              itemBuilder: (context, index) {
                final meal = addedMeals[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(12)),
                          child: meal.imageUrl.startsWith('assets/')
                              ? Image.asset(
                                  meal.imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  meal.imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(meal.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.local_fire_department,
                                      size: 16, color: Colors.red),
                                  const SizedBox(width: 2),
                                  Text('${meal.calories} kcal',
                                      style: const TextStyle(fontSize: 12)),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.monitor_heart,
                                      size: 16, color: Colors.purple),
                                  const SizedBox(width: 2),
                                  Text('Glucose: ${meal.glucoseLevel} mg/dL',
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            addedMeals.removeAt(index);
                          });
                          _saveMealsToFirestore();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF85C26F),
        onPressed: _showMealPicker,
        child: Icon(Icons.add, size: 30, color: Colors.black),
      ),
    );
  }
}
