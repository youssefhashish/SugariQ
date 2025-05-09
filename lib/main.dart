import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_iq/splash/add_reminder.dart';
import 'package:sugar_iq/splash/prediction_page.dart';

import '../splash/diabetes_type.dart';
import '../splash/splash_screen.dart';
import 'components/mdecine_provider.dart';
import 'profile page/profile.dart';
import 'profile page/user/user_data.dart';
import 'screens/report.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/onBoarding.dart';
import 'screens/settings.dart';
import 'screens/signup.dart';
import 'splash/goal_screen.dart';
import 'screens/reminder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserData.init();
  final prefs = await SharedPreferences.getInstance();
  final Login = prefs.getBool("onboarding") ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MedicationProvider()),
      ],
      child: DiabetesPredictionApp(Login: Login),
    ),
  );
}

class DiabetesPredictionApp extends StatelessWidget {
  final bool Login;

  const DiabetesPredictionApp({super.key, required this.Login});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SugarIQ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      debugShowCheckedModeBanner: false,
      home: Login ? LogInScreen() : OnBoarding(),
      routes: {
        '/goalScreen': (context) => BloodSugarGoalScreen(),
        '/diabetesType': (context) => DiabetesTypeScreen(),
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LogInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/settings': (context) => SettingsScreen(),
        '/reminder': (context) => ReminderPage(),
        '/progress': (context) => MyReportPage(),
        '/profile': (context) => ProfilePage(),
        '/addReminder': (context) => AddReminder(),
        '/prediction': (context) => PredictionScreen(),
      },
    );
  }
}
