import 'package:flutter/material.dart';

class BloodSugarGoalScreen extends StatefulWidget {
  const BloodSugarGoalScreen({super.key});

  @override
  _BloodSugarGoalScreenState createState() => _BloodSugarGoalScreenState();
}

class _BloodSugarGoalScreenState extends State<BloodSugarGoalScreen> {
  String lowestValue = '';
  String highestValue = '';
  bool isFirstInputActive = true;

  void onKeyPress(String value) {
    setState(() {
      if (isFirstInputActive) {
        if (lowestValue.length < 3) {
          // Limit to 3 digits
          lowestValue += value;
        }
      } else {
        if (highestValue.length < 3) {
          // Limit to 3 digits
          highestValue += value;
        }
      }
    });
  }

  void onBackspace() {
    setState(() {
      if (isFirstInputActive) {
        if (lowestValue.isNotEmpty) {
          lowestValue = lowestValue.substring(0, lowestValue.length - 1);
        }
      } else {
        if (highestValue.isNotEmpty) {
          highestValue = highestValue.substring(0, highestValue.length - 1);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final maxWidth = screenSize.width > 375 ? 375.0 : screenSize.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: screenSize.height,
        width: maxWidth,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            // Back Button
            Positioned(
              top: 51,
              left: 24,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CustomPaint(
                    painter: BackButtonPainter(),
                  ),
                ),
              ),
            ),

            // Progress Bar
            Positioned(
              top: 60,
              left: 68,
              child: SizedBox(
                width: 284,
                height: 6,
                child: CustomPaint(
                  painter: ProgressBarPainter(progress: 0.55), // 75% progress
                ),
              ),
            ),

            // Title
            Positioned(
              top: 106,
              left: 24,
              width: 319,
              child: RichText(
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
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [Color(0xFF6FBE5A), Color(0xFF85C26F)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(const Rect.fromLTWH(0, 0, 100, 50)),
                      ),
                    ),
                    const TextSpan(text: ' meal? 🍏'),
                  ],
                ),
              ),
            ),

            // Input Fields
            Positioned(
              top: 208,
              left: 24,
              child: Column(
                children: [
                  // First Input Field
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFirstInputActive = true;
                      });
                    },
                    child: Container(
                      width: 327,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isFirstInputActive
                              ? const Color(0xFF6FBE5A)
                              : const Color(0xFFE0E3E6),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lowestValue.isEmpty ? 'Lowest value' : lowestValue,
                            style: TextStyle(
                              fontFamily: 'Convergence',
                              fontSize: 16,
                              color: lowestValue.isEmpty
                                  ? const Color(0xFFABAFB3)
                                  : Colors.black,
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
                  ),

                  const SizedBox(height: 19),

                  // Second Input Field
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFirstInputActive = false;
                      });
                    },
                    child: Container(
                      width: 327,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: !isFirstInputActive
                              ? const Color(0xFF6FBE5A)
                              : const Color(0xFFE0E3E6),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            highestValue.isEmpty
                                ? 'Highest value'
                                : highestValue,
                            style: TextStyle(
                              fontFamily: 'Convergence',
                              fontSize: 16,
                              color: highestValue.isEmpty
                                  ? const Color(0xFFABAFB3)
                                  : Colors.black,
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
                  ),
                ],
              ),
            ),

            // Next Button
            Positioned(
              top: 449,
              left: 24,
              child: Container(
                width: 327,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6FBE5A), Color(0xFF85C26F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    // Handle next button press
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
            ),

            // Home Indicator
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 134,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0A0A0A)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0.735, size.height * 0.097);
    path.lineTo(size.width * 0.265, size.height * 0.467);
    path.lineTo(size.width * 0.735, size.height * 0.903);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProgressBarPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0

  ProgressBarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    final backgroundPaint = Paint()
      ..color = const Color(0xFFE7F1FF)
      ..style = PaintingStyle.fill;

    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(3),
    );
    canvas.drawRRect(backgroundRect, backgroundPaint);

    // Progress
    final progressPaint = Paint()
      ..color = const Color(0xFFED6461)
      ..style = PaintingStyle.fill;

    final progressRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width * progress, size.height),
      const Radius.circular(3),
    );
    canvas.drawRRect(progressRect, progressPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressBarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
