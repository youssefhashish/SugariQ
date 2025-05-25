import 'package:flutter/material.dart';

class PredictionResult {
  static void show(BuildContext context, bool isDiabetic, double percent,
      double glucosePercent, double hba1cPercent) {
    final emoji = isDiabetic ? "😟" : "😄";
    final message = isDiabetic
        ? "Unfortunately, you have a ${percent.toStringAsFixed(0)}% chance of having diabetes.\nStay strong! ❤️"
        : "Congratulations!\nYour chance of having diabetes is only ${percent.toStringAsFixed(0)}% 🎉";
    final color = isDiabetic ? Colors.red[100] : Colors.green[100];
    final textColor = isDiabetic ? Colors.red[800] : Colors.green[800];

    final details =
        "Glucose risk: ${glucosePercent.toStringAsFixed(0)}%\nHbA1c risk: ${hba1cPercent.toStringAsFixed(0)}%";

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
              const SizedBox(height: 12),
              Text(
                details,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
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
                onPressed: () =>
                    Navigator.popAndPushNamed(context, '/goalScreen'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
