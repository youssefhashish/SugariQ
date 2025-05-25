import 'package:flutter/material.dart';
import 'package:sugar_iq/widgets/app_theme.dart';

import '../widgets/progress_indicator.dart';

class BloodSugarGoalScreen extends StatefulWidget {
  const BloodSugarGoalScreen({super.key});

  @override
  _BloodSugarGoalScreenState createState() => _BloodSugarGoalScreenState();
}

class _BloodSugarGoalScreenState extends State<BloodSugarGoalScreen> {
  String lowestValue = '';
  String highestValue = '';
  bool isFirstInputActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // Progress Bar
              SizedBox(
                width: double.infinity,
                height: 6,
                child: CustomPaint(
                  painter: ProgressBarPainter(progress: 0.75),
                ),
              ),
              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'Convergence',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(text: 'Your blood sugar goal '),
                    TextSpan(
                      text: 'before',
                      style: TextStyle(
                        fontFamily: 'Convergence',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                    const TextSpan(text: ' meal? 🍏'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Input Fields
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isFirstInputActive
                            ? AppTheme.primary
                            : const Color(0xFFE0E3E6),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                isFirstInputActive = true;
                              });
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Lowest value',
                              hintStyle: TextStyle(
                                fontFamily: 'Convergence',
                                fontSize: 16,
                                color: Color(0xFFABAFB3),
                              ),
                            ),
                            style: const TextStyle(
                              fontFamily: 'Convergence',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                lowestValue = value;
                              });
                            },
                          ),
                        ),
                        const Text(
                          'mg / dl',
                          style: TextStyle(
                            fontFamily: 'Convergence',
                            fontSize: 16,
                            color: Color(0xFF0A0A0A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: !isFirstInputActive
                            ? AppTheme.primary
                            : const Color(0xFFE0E3E6),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                isFirstInputActive = false;
                              });
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Highest value',
                              hintStyle: TextStyle(
                                fontFamily: 'Convergence',
                                fontSize: 16,
                                color: Color(0xFFABAFB3),
                              ),
                            ),
                            style: const TextStyle(
                              fontFamily: 'Convergence',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                highestValue = value;
                              });
                            },
                          ),
                        ),
                        const Text(
                          'mg / dl',
                          style: TextStyle(
                            fontFamily: 'Convergence',
                            fontSize: 16,
                            color: Color(0xFF0A0A0A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Next Button
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 44,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.primary,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addReminder');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontFamily: 'Convergence',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
