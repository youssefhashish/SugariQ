import 'package:flutter/material.dart';

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
      ..color = const Color(0xFF00BF39).withOpacity(0.2)
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
