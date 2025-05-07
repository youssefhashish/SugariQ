import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GlucoseProgressScreen extends StatefulWidget {
  const GlucoseProgressScreen({super.key});

  @override
  State<GlucoseProgressScreen> createState() => _GlucoseProgressScreenState();
}

class _GlucoseProgressScreenState extends State<GlucoseProgressScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<double> glucoseLevels = [];

  @override
  void initState() {
    super.initState();
    _loadGlucoseDataFromFirestore();
  }

  Future<void> _loadGlucoseDataFromFirestore() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('glucoseLevels')
            .orderBy('timestamp')
            .get();

        setState(() {
          glucoseLevels = snapshot.docs
              .map((doc) => (doc['level'] as num).toDouble())
              .toList();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load glucose data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Glucose Progress')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Glucose Level Over Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            glucoseLevels.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
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
                                if (value >= 0 && value < glucoseLevels.length) {
                                  return Text('Day ${value.toInt() + 1}');
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                if (value >= 0 && value <= 200) {
                                  return Text('${value.toInt()} mg/dL');
                                }
                                return const Text('');
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
