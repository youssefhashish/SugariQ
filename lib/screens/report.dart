import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/weekly_report.dart';

class MyReportPage extends StatefulWidget {
  const MyReportPage({super.key});

  @override
  _MyReportPageState createState() => _MyReportPageState();
}

class _MyReportPageState extends State<MyReportPage> {
  String selectedFilter = 'WEEKLY';
  List<GlucoseMeasurement> measurements = [];
  double avgGlucose = 0;
  final List<String> days = ['M', 'T', 'W', 'TH', 'F', 'S', 'SU'];
  TextEditingController _glucoseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMeasurements();
  }

  Future<void> _loadMeasurements() async {
    final prefs = await SharedPreferences.getInstance();
    final String? measurementsString = prefs.getString('glucose_measurements');

    if (measurementsString != null) {
      setState(() {
        measurements = (json.decode(measurementsString) as List)
            .map((item) => GlucoseMeasurement.fromJson(item))
            .toList();
        _calculateAverages();
      });
    }
  }

  Future<void> _saveMeasurement(double value) async {
    final newMeasurement = GlucoseMeasurement(
      value: value,
      dateTime: DateTime.now(),
    );

    setState(() {
      measurements.add(newMeasurement);
      _calculateAverages();
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'glucose_measurements',
      json.encode(measurements.map((m) => m.toJson()).toList()),
    );
  }

  void _calculateAverages() {
    if (measurements.isEmpty) {
      setState(() => avgGlucose = 0);
      return;
    }

    final now = DateTime.now();
    List<GlucoseMeasurement> filteredMeasurements = [];

    if (selectedFilter == 'TODAY') {
      filteredMeasurements = measurements
          .where((m) =>
              m.dateTime.year == now.year &&
              m.dateTime.month == now.month &&
              m.dateTime.day == now.day)
          .toList();
    } else if (selectedFilter == 'WEEKLY') {
      final weekAgo = now.subtract(Duration(days: 7));
      filteredMeasurements =
          measurements.where((m) => m.dateTime.isAfter(weekAgo)).toList();
    } else {
      // MONTHLY
      final monthAgo = now.subtract(Duration(days: 30));
      filteredMeasurements =
          measurements.where((m) => m.dateTime.isAfter(monthAgo)).toList();
    }

    if (filteredMeasurements.isEmpty) {
      setState(() => avgGlucose = 0);
      return;
    }

    final sum = filteredMeasurements.fold(0.0, (total, m) => total + m.value);
    setState(() => avgGlucose = sum / filteredMeasurements.length);
  }

  void _showAddMeasurementDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Glucose Measurement"),
        content: TextField(
          controller: _glucoseController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Glucose level (mg/dl)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_glucoseController.text.isNotEmpty) {
                final value = double.tryParse(_glucoseController.text);
                if (value != null) {
                  _saveMeasurement(value);
                  _glucoseController.clear();
                  Navigator.pop(context);
                }
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showWeeklyReportDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("You Report🩺",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  WeeklyMedicalReport(measurements: measurements),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF85C26F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text("close",
                        style: TextStyle(fontSize: 17, color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void onFilterChange(String filter) {
    setState(() {
      selectedFilter = filter;
      _calculateAverages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Report"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.event_note),
            onPressed: () {
              _showWeeklyReportDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$selectedFilter Report",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilterButton(
                    text: 'TODAY',
                    isSelected: selectedFilter == 'TODAY',
                    onTap: () => onFilterChange('TODAY')),
                FilterButton(
                    text: 'WEEKLY',
                    isSelected: selectedFilter == 'WEEKLY',
                    onTap: () => onFilterChange('WEEKLY')),
                FilterButton(
                    text: 'MONTHLY',
                    isSelected: selectedFilter == 'MONTHLY',
                    onTap: () => onFilterChange('MONTHLY')),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              margin: EdgeInsets.all(5),
              elevation: 4.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text("AVG BLOOD GLUCOSE",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (avgGlucose > 100) ...[
                        Text('👍', style: TextStyle(fontSize: 23)),
                        SizedBox(width: 8),
                        Text('${avgGlucose.toStringAsFixed(1)} mg/dl',
                            style:
                                TextStyle(fontSize: 23, color: Colors.green)),
                      ] else ...[
                        Column(children: [
                          Text('👎 ${avgGlucose.toStringAsFixed(1)} mg/dl',
                              style:
                                  TextStyle(fontSize: 23, color: Colors.red)),
                          Text('you need to visit doctor',
                              style: TextStyle(fontSize: 20, color: Colors.red))
                        ]),
                      ],
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildGlucoseChart(),
            const SizedBox(height: 20),
            Center(
              child: FloatingActionButton(
                onPressed: _showAddMeasurementDialog,
                backgroundColor: Color(0xFF85C26F),
                child: Icon(Icons.add, color: Colors.black, size: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlucoseChart() {
    final now = DateTime.now();
    List<GlucoseMeasurement> filteredMeasurements = [];
    bool isDaily = selectedFilter == 'TODAY';

    if (selectedFilter == 'TODAY') {
      filteredMeasurements = measurements
          .where((m) =>
              m.dateTime.year == now.year &&
              m.dateTime.month == now.month &&
              m.dateTime.day == now.day)
          .toList();
    } else if (selectedFilter == 'WEEKLY') {
      final weekAgo = now.subtract(Duration(days: 7));
      filteredMeasurements =
          measurements.where((m) => m.dateTime.isAfter(weekAgo)).toList();
    } else {
      // MONTHLY
      final monthAgo = now.subtract(Duration(days: 30));
      filteredMeasurements =
          measurements.where((m) => m.dateTime.isAfter(monthAgo)).toList();
    }

    if (filteredMeasurements.isEmpty) {
      return Center(child: Text("No measurements available"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("GLUCOSE, $selectedFilter AVG",
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: isDaily
              ? _buildLineChart(filteredMeasurements)
              : _buildBarChart(filteredMeasurements),
        ),
      ],
    );
  }

  Widget _buildLineChart(List<GlucoseMeasurement> measurements) {
    // Sort by time
    measurements.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: measurements.map((m) {
              return FlSpot(
                m.dateTime.hour + m.dateTime.minute / 60.0,
                m.value,
              );
            }).toList(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            belowBarData: BarAreaData(show: false),
            dotData: FlDotData(show: true),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}:00');
              },
              interval: 4,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString());
              },
              interval: 20,
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        gridData: FlGridData(show: true),
        minX: 0,
        maxX: 24,
      ),
    );
  }

  Widget _buildBarChart(List<GlucoseMeasurement> measurements) {
    Map<String, List<double>> groupedData = {};
    final dateFormat =
        selectedFilter == 'WEEKLY' ? DateFormat('E') : DateFormat('d');

    for (var m in measurements) {
      final key = dateFormat.format(m.dateTime);
      groupedData.putIfAbsent(key, () => []).add(m.value);
    }

    final List<MapEntry<String, double>> averagedData = groupedData.entries
        .map((e) =>
            MapEntry(e.key, e.value.reduce((a, b) => a + b) / e.value.length))
        .toList();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY:
            (averagedData.fold(0.0, (max, e) => e.value > max ? e.value : max) +
                20),
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value >= 0 && value < averagedData.length) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(averagedData[value.toInt()].key),
                  );
                }
                return SizedBox();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString());
              },
              interval: 20,
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        barGroups: averagedData.asMap().entries.map((e) {
          return BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: e.value.value,
                color: Colors.blue,
                width: 16,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class GlucoseMeasurement {
  final double value;
  final DateTime dateTime;

  GlucoseMeasurement({required this.value, required this.dateTime});

  factory GlucoseMeasurement.fromJson(Map<String, dynamic> json) {
    return GlucoseMeasurement(
      value: json['value'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const FilterButton({required this.text, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
