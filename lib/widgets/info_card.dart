/*import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFEBF1FE),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 8.0,
              animation: true,
              percent: 0.7,
              center: Text(
                "70%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Color(0xFF85C26F),
            ),
            SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''Eaten
48 GL of 64 GL''',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 35, 149, 219),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '16 GL left',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )
          ]),
          const SizedBox(height: 14),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: 'The ',
                  style: TextStyle(fontFamily: 'Airbnb Cereal App'),
                ),
                TextSpan(
                  text: 'glycemic load ',
                  style: TextStyle(fontFamily: 'Convergence'),
                ),
                TextSpan(
                  text:
                      '(GL) is a measure of the type and quantity of the carbs you eat.',
                  style: TextStyle(fontFamily: 'Airbnb Cereal App'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../screens/meal.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({super.key});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  double glucosePercent = 0.0;
  int totalGlucose = 0;
  int eatenGlucose = 0;

  @override
  void initState() {
    super.initState();
    _loadGlucoseData();
  }

  Future<void> _loadGlucoseData() async {
    final prefs = await SharedPreferences.getInstance();
    final mealsJson = prefs.getStringList('meals') ?? [];
    final eatenJson = prefs.getStringList('eatenMeals') ?? [];

    final meals = mealsJson.map((e) => Meal.fromJson(jsonDecode(e))).toList();
    final eatenIndexes = eatenJson.map((e) => int.parse(e)).toSet();

    int total = 0;
    int eaten = 0;

    for (int i = 0; i < meals.length; i++) {
      total += meals[i].glucoseLevel;
      if (eatenIndexes.contains(i)) {
        eaten += meals[i].glucoseLevel;
      }
    }

    setState(() {
      totalGlucose = total;
      eatenGlucose = eaten;
      glucosePercent = total == 0 ? 0.0 : eaten / total;
    });
  }

  @override
  Widget build(BuildContext context) {
    final remaining = totalGlucose - eatenGlucose;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF1FE),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 8.0,
              animation: true,
              percent: glucosePercent.clamp(0.0, 1.0),
              center: Text(
                "${(glucosePercent * 100).toInt()}%",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: const Color(0xFF85C26F),
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eaten\n$eatenGlucose GL of $totalGlucose GL',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 35, 149, 219),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$remaining GL left',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            )
          ]),
          const SizedBox(height: 14),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: 'The ',
                  style: TextStyle(fontFamily: 'Airbnb Cereal App'),
                ),
                TextSpan(
                  text: 'glycemic load ',
                  style: TextStyle(fontFamily: 'Convergence'),
                ),
                TextSpan(
                  text:
                      '(GL) is a measure of the type and quantity of the carbs you eat.',
                  style: TextStyle(fontFamily: 'Airbnb Cereal App'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
