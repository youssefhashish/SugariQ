import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GlucoseProgressScreen extends StatelessWidget {
  // Sample glucose data (replace with real data)
  final List<double> glucoseLevels = [100, 120, 110, 130, 140, 150, 160];

  GlucoseProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Glucose Progress')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Glucose Level Over Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitlesWidget: (value, meta) {
                          // Ensure value is within the range of the data
                          if (value >= 0 && value < glucoseLevels.length) {
                            return Text('Day ${value.toInt() + 1}');
                          }
                          return Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          // Ensure value is within the range of the data
                          if (value >= 0 && value <= 200) {
                            return Text('${value.toInt()} mg/dL');
                          }
                          return Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: glucoseLevels.length.toDouble() - 1,
                  minY: 0,
                  maxY: 200,
                  lineBarsData: [
                    LineChartBarData(
                      spots: glucoseLevels.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value);
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
