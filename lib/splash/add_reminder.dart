import 'package:flutter/material.dart';
import 'package:sugar_iq/screens/login.dart';
import 'package:sugar_iq/splash/goal_screen.dart';

class AddReminder extends StatelessWidget {
  const AddReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 51.0, 24.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and progress bar
              Positioned(
                top: 60,
                left: 68,
                child: SizedBox(
                  width: 350,
                  height: 6,
                  child: CustomPaint(
                    painter: ProgressBarPainter(progress: 1), // 100% progress
                  ),
                ),
              ),
              const SizedBox(height: 45),

              // Heading
              Text(
                'When do you measure glucose level?',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 1.5,
                  fontFamily: 'Cera Pro',
                ),
              ),
              const SizedBox(height: 6),

              // Subtitle
              Text(
                'SugariQ will remind you to take measurements at the same time to get accurate statistics.',
                style: TextStyle(
                  color: const Color(0xFFABAFB3),
                  fontSize: 14,
                  height: 1.5,
                  fontFamily: 'Abyssinica SIL',
                ),
              ),
              const SizedBox(height: 38),

              // Add reminder button
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E3E6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Add a reminder ',
                          style: TextStyle(
                            color: const Color(0xFF0A0A0A),
                            fontFamily: 'Convergence',
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: '+',
                          style: TextStyle(
                            color: const Color(0xFF0A0A0A),
                            fontFamily: 'Convergence',
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Time display
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8FB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '10:00 PM',
                    style: TextStyle(
                      color: const Color(0xFF0A0A0A),
                      fontFamily: 'Convergence',
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Get Started button
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogInScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF6FBE5A), Color(0xFF85C26F)],
                      transform: GradientRotation(104 * 3.14159 / 180),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Convergence',
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
