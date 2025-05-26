import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_iq/splash/add_reminder.dart';
import 'package:sugar_iq/splash/prediction_page.dart';
import 'package:sugar_iq/splash/splash_screen.dart';

import 'profile page/Health_info.dart';
import 'components/mdecine_provider.dart';
import 'components/profile_image_notifier.dart';
import 'profile page/profile.dart';
import 'profile page/user/user_data.dart';
import 'screens/forget_password.dart';
import 'screens/report.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/onBoarding.dart';
import 'screens/settings.dart';
import 'screens/signup.dart';
import 'splash/goal_screen.dart';
import 'screens/reminder.dart';
import 'widgets/Privacy&Policy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserData.init();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool("Login") ?? false;
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MedicationProvider()),
      ],
      child: DiabetesPredictionApp(isLoggedIn: isLoggedIn),
    ),
  );
}

final profileImageNotifier = ProfileImageNotifier(UserData.getUser().image);

class DiabetesPredictionApp extends StatelessWidget {
  final bool isLoggedIn;

  const DiabetesPredictionApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SugarIQ',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Always start with splash screen
      routes: {
        '/goalScreen': (context) => BloodSugarGoalScreen(),
        //'/diabetesType': (context) => DiabetesTypeScreen(),
        '/health_info': (context) => HealthInfo(),
        '/login': (context) => LogInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/settings': (context) => SettingsScreen(),
        '/reminder': (context) => ReminderPage(),
        '/progress': (context) => MyReportPage(),
        '/profile': (context) => ProfilePage(),
        '/addReminder': (context) => AddReminder(),
        '/prediction': (context) => PredictionScreen(),
        '/forgotPassword': (context) => ForgotPasswordPage(),
        '/onboarding': (context) => OnBoarding(),
        '/privacy': (context) => PrivacyPolicyWidget(),
      },
    );
  }
}
