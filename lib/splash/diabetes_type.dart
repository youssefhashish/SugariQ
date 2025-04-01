import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/selection_options.dart';
import '../widgets/text_style.dart';
import 'goal_screen.dart';

class DiabetesTypeScreen extends StatefulWidget {
  const DiabetesTypeScreen({super.key});

  @override
  _DiabetesTypeScreenState createState() => _DiabetesTypeScreenState();
}

class _DiabetesTypeScreenState extends State<DiabetesTypeScreen> {
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 53),
              // Progress Bar
              Positioned(
                top: 60,
                left: 68,
                child: SizedBox(
                  width: 350,
                  height: 6,
                  child: CustomPaint(
                    painter: ProgressBarPainter(progress: 0.50), // 50% progress
                  ),
                ),
              ),
              const SizedBox(height: 33),
              const Text(
                'What diabetes type do you have?',
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: 40),
              SelectionOption(
                text: 'Type 1',
                isSelected: selectedType == 'Type 1',
                onTap: () => setState(() => selectedType = 'Type 1'),
              ),
              const SizedBox(height: 20),
              SelectionOption(
                text: 'Type 2',
                isSelected: selectedType == 'Type 2',
                onTap: () => setState(() => selectedType = 'Type 2'),
              ),
              const SizedBox(height: 20),
              SelectionOption(
                text: 'Gestational',
                isSelected: selectedType == 'Gestational',
                onTap: () => setState(() => selectedType = 'Gestational'),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 32),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppTheme.buttonGradientStart,
                        AppTheme.buttonGradientEnd,
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/goalScreen');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 44,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
