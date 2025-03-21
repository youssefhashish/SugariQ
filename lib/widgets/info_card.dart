import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 13.0,
            animation: true,
            percent: 0.7,
            center: Text(
              "70.0%",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            footer: Text(
              "Glycemic Load",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Color(0xFF85C26F),
          ),
          const SizedBox(height: 14),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: 'The ',
                  style: TextStyle(fontFamily: 'Airbnb Cereal App'),
                ),
                TextSpan(
                  text: 'glycemic load ',
                  style: TextStyle(fontFamily: 'Convergence'),
                ),
                TextSpan(
                  text:
                      '(GL) is a measure of the type and quantity of the carbs you eat.',
                  style: TextStyle(fontFamily: 'Airbnb Cereal App'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
