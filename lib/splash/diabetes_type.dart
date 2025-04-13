import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/text_style.dart';

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
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedType = 'Type 1';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: selectedType == 'Type 1'
                        ? Colors.purple.shade50
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          color: selectedType == 'Type 1'
                              ? Colors.purple.shade300
                              : Colors.transparent,
                          border: Border.all(
                            color: selectedType == 'Type 1'
                                ? Colors.purple.shade300
                                : Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: selectedType == 'Type 1'
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Type 1',
                        style: AppTextStyles.buttonText
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedType = 'Type 2';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: selectedType == 'Type 2'
                        ? Colors.purple.shade50
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          color: selectedType == 'Type 2'
                              ? Colors.purple.shade300
                              : Colors.transparent,
                          border: Border.all(
                            color: selectedType == 'Type 2'
                                ? Colors.purple.shade300
                                : Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: selectedType == 'Type 2'
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Type 2',
                        style: AppTextStyles.buttonText
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedType = 'Gestational';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: selectedType == 'Gestational'
                        ? Colors.purple.shade50
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          color: selectedType == 'Gestational'
                              ? Colors.purple.shade300
                              : Colors.transparent,
                          border: Border.all(
                            color: selectedType == 'Gestational'
                                ? Colors.purple.shade300
                                : Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: selectedType == 'Gestational'
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Gestational',
                        style: AppTextStyles.buttonText
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
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
                        vertical: 20,
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
