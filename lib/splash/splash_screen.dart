import 'package:flutter/material.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/selection_row.dart';
import '../widgets/app_theme.dart';
import 'goal_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Bar
                Positioned(
                  top: 60,
                  left: 68,
                  child: SizedBox(
                    width: 350,
                    height: 6,
                    child: CustomPaint(
                      painter:
                          ProgressBarPainter(progress: 0.25), // 75% progress
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Tell us about yourself',
                  style: AppTheme.titleStyle,
                ),
                const SizedBox(height: 6),
                const Text(
                  'Your individual parametres are important for SugariQ for indepth personalization.',
                  style: AppTheme.subtitleStyle,
                ),
                const SizedBox(height: 46),
                SelectionRow(
                  title: 'Gender',
                  value: 'Male',
                  iconBackgroundColor: AppTheme.lightBlue,
                ),
                const SizedBox(height: 20),
                SelectionRow(
                  title: 'Age',
                  value: 'Select',
                  iconBackgroundColor: AppTheme.lightPurple,
                  isSelectable: true,
                ),
                const SizedBox(height: 20),
                SelectionRow(
                  title: 'Diabetes type',
                  value: 'Select',
                  iconBackgroundColor: AppTheme.lightRed,
                  isSelectable: true,
                ),
                const SizedBox(height: 218),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF6FBE5A), Color(0xFF85C26F)],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 44),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/diabetesType');
                      },
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Convergence',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
