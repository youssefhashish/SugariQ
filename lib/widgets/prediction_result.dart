import 'package:flutter/material.dart';
import 'package:sugar_iq/widgets/app_theme.dart';

class PredictionResult {
  static void show(BuildContext context, bool isDiabetic, double percent,
      double glucosePercent, double hba1cPercent) {
    final image = isDiabetic
        ? Image.asset(
            'assets/Is_Diabetic.png',
            width: 500,
            height: 300,
            fit: BoxFit.contain,
          )
        : Image.asset(
            'assets/Not_Diabetic.png',
            width: 500,
            height: 300,
            fit: BoxFit.contain,
          );
    final message = isDiabetic
        ? "Unfortunately, you have a ${percent.toStringAsFixed(0)}% chance of having diabetes.\nStay strong! ❤️"
        : "Your chance of having diabetes is only ${percent.toStringAsFixed(0)}% 🎉";
    /* final color = isDiabetic ? Colors.red[100] : Colors.green[100];
    final textColor = isDiabetic ? Colors.red[800] : Colors.green[800];*/

    /*final details =
        "Glucose risk: ${glucosePercent.toStringAsFixed(0)}%\nHbA1c risk: ${hba1cPercent.toStringAsFixed(0)}%";*/

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                image,
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.popAndPushNamed(context, '/goalScreen'),
                  child: const Text('OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
