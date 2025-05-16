import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/meal.dart';
import '../screens/report.dart';

class WeeklyMedicalReport extends StatelessWidget {
  final List<GlucoseMeasurement> measurements;

  const WeeklyMedicalReport({required this.measurements, super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final weekAgo = now.subtract(Duration(days: 7));

    final weeklyMeasurements =
        measurements.where((m) => m.dateTime.isAfter(weekAgo)).toList();

    final avgWeeklyGlucose = weeklyMeasurements.isEmpty
        ? 0
        : weeklyMeasurements.fold(0.0, (sum, m) => sum + m.value) /
            weeklyMeasurements.length;

    String glucoseComment;
    if (avgWeeklyGlucose == 0) {
      glucoseComment = "No glucose data available this week.";
    } else if (avgWeeklyGlucose < 70) {
      glucoseComment =
          "Your blood glucose levels are quite low this week. You may be experiencing hypoglycemia.";
    } else if (avgWeeklyGlucose <= 130) {
      glucoseComment =
          "Your average glucose is within the target range this week. Keep it up!";
    } else {
      glucoseComment =
          "Your glucose levels are slightly high this week. Review your meals and activity.";
    }

    return FutureBuilder<List<Meal>>(
      future: _loadWeeklyMeals(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final weeklyMeals = snapshot.data!;

        String mealsComment;
        if (weeklyMeals.isEmpty) {
          mealsComment = "No meals were logged this week.";
        } else {
          final avgCalories =
              weeklyMeals.fold(0, (sum, meal) => sum + meal.calories) /
                  weeklyMeals.length;

          if (avgCalories < 400) {
            mealsComment = "Your meals were light this week.";
          } else if (avgCalories <= 700) {
            mealsComment = "Your meals seem balanced this week.";
          } else {
            mealsComment = "You had high-calorie meals this week.";
          }
        }

        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
          margin: EdgeInsets.only(top: 20),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Weekly Medical Report 🩺",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.monitor_heart, color: Colors.purple),
                    SizedBox(width: 8),
                    Text(
                        "Avg Glucose: ${avgWeeklyGlucose.toStringAsFixed(1)} mg/dL",
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),
                Text(glucoseComment,
                    style: TextStyle(fontSize: 14, color: Colors.black87)),
                SizedBox(height: 12),
                Text("Meals Eaten This Week 🍽️:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                if (weeklyMeals.isEmpty)
                  Text("No meals added this week",
                      style: TextStyle(color: Colors.grey))
                else
                  Column(
                    children: weeklyMeals.map((meal) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: meal.imageUrl.startsWith('assets/')
                            ? Image.asset(meal.imageUrl,
                                width: 50, height: 50, fit: BoxFit.cover)
                            : Image.network(meal.imageUrl,
                                width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(meal.name),
                        subtitle: Text(
                            "${meal.calories} kcal • ${DateFormat('yMMMd').format(meal.dateTime)}"),
                      );
                    }).toList(),
                  ),
                SizedBox(height: 8),
                Text(mealsComment,
                    style: TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<Meal>> _loadWeeklyMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? mealsJson = prefs.getStringList('meals');

    if (mealsJson == null) return [];

    final now = DateTime.now();
    final weekAgo = now.subtract(Duration(days: 7));

    final meals = mealsJson
        .map((mealStr) => Meal.fromJson(jsonDecode(mealStr)))
        .where((meal) => meal.dateTime.isAfter(weekAgo))
        .toList();

    return meals;
  }
}
