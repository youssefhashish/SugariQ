import 'package:flutter/material.dart';

import '../splash/diabetes_type.dart';
import '../splash/splash_screen.dart';
import 'screens/medicine_reminder.dart';
import 'screens/report.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/onBoarding.dart';
import 'screens/reminder.dart';
import 'screens/settings.dart';
import 'screens/signup.dart';
import 'splash/goal_screen.dart';

void main() {
  runApp(DiabetesPredictionApp());
}

class DiabetesPredictionApp extends StatelessWidget {
  const DiabetesPredictionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetes Prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      debugShowCheckedModeBanner: false,
      home: OnBoarding(),
      routes: {
        '/goalScreen': (context) => BloodSugarGoalScreen(),
        '/diabetesType': (context) => DiabetesTypeScreen(),
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LogInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/settings': (context) => SettingsScreen(),
        '/reminder': (context) => ReminderScreen(),
        '/calendar': (context) => CalendarCheckScreen(),
        '/progress': (context) => GlucoseProgressScreen(),
      },
    );
  }
}
