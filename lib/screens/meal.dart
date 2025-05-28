import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_iq/widgets/app_theme.dart';
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

  const MealsPage({Key? key, this.onMealAdded}) : super(key: key);
  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  List<Meal> addedMeals = [];

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? mealsJson = prefs.getStringList('meals');

    if (mealsJson != null) {
      setState(() {
        addedMeals = mealsJson
            .map((mealStr) => Meal.fromJson(jsonDecode(mealStr)))
            .toList();
      });
    }
  }

  Future<void> _saveMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> mealsJson =
        addedMeals.map((meal) => jsonEncode(meal.toJson())).toList();
    await prefs.setStringList('meals', mealsJson);
  }

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
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AddMealScreen(onMealAdded: _addMeal),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
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
            padding: EdgeInsets.all(16.w),
            children: meals.map((meal) {
              return Card(
                margin: EdgeInsets.only(bottom: 12.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(meal.image,
                        width: 60.w, height: 60.h, fit: BoxFit.cover),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to load meals, please try again later')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Meals 🍽️',
            style: TextStyle(color: Colors.black, fontSize: 20.sp)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: addedMeals.isEmpty
          ? Center(
              child: Text(
                'No meals added yet',
                style: TextStyle(fontSize: 18.sp, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: addedMeals.length,
              itemBuilder: (context, index) {
                final meal = addedMeals[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  elevation: 3,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(12.r),
                        ),
                        child: Container(
                          width: 100.w,
                          height: 100.h,
                          child: meal.imageUrl.startsWith('assets/')
                              ? Image.asset(
                                  meal.imageUrl,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  meal.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image_not_supported),
                                ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meal.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  const Icon(Icons.local_fire_department,
                                      size: 16, color: Colors.red),
                                  SizedBox(width: 4.w),
                                  Text('${meal.calories} kcal',
                                      style: TextStyle(fontSize: 12.sp)),
                                  SizedBox(width: 12.w),
                                  const Icon(Icons.monitor_heart,
                                      size: 16, color: Colors.purple),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Text(
                                        'Glucose: ${meal.glucoseLevel} mg/dL',
                                        style: TextStyle(fontSize: 12.sp),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              addedMeals.removeAt(index);
                            });
                            _saveMeals();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        onPressed: _showMealPicker,
        child: Icon(Icons.add, size: 30.sp, color: Colors.black),
      ),
    );
  }
}
