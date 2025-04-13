import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFEBF1FE),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 8.0,
              animation: true,
              percent: 0.7,
              center: Text(
                "70%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Color(0xFF85C26F),
            ),
            SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''Eaten
48 GL of 64 GL''',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 35, 149, 219),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '16 GL left',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )
          ]),
          const SizedBox(height: 14),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 18,
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
