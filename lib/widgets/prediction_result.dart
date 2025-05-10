import 'package:flutter/material.dart';

class PredictionResult {
  static void show(BuildContext context, bool isDiabetic) {
    final emoji = isDiabetic ? "😟" : "😄";
    final message = isDiabetic
        ? "Unfortunately, you might have diabetes.\nStay strong! ❤️"
        : "Congratulations!\nYou are healthy! 🎉";
    final color = isDiabetic ? Colors.red[100] : Colors.green[100];
    final textColor = isDiabetic ? Colors.red[800] : Colors.green[800];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 50)),
              const SizedBox(height: 15),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
