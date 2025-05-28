import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // <- مهم
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
        title:
            Text("Add Glucose Measurement", style: TextStyle(fontSize: 18.sp)),
        content: TextField(
          controller: _glucoseController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Glucose level (mg/dl)',
            border: OutlineInputBorder(),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          ),
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(216, 39, 148, 148),
              ),
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
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              )),
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("You Report🩺",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12.h),
                  WeeklyMedicalReport(measurements: measurements),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(216, 39, 148, 148),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text("Close",
                        style: TextStyle(fontSize: 18.sp, color: Colors.white)),
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
        toolbarHeight: 80.h,
        title: Text("My Report", style: TextStyle(fontSize: 22.sp)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 24.sp),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.event_note, size: 26.sp),
            onPressed: () {
              _showWeeklyReportDialog();
            },
          ),
        ],
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$selectedFilter Report",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.h),
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
            SizedBox(height: 20.h),
            Card(
              margin: EdgeInsets.all(5.w),
              elevation: 4.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Text("AVG BLOOD GLUCOSE",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2)),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (avgGlucose == 0) ...[
                        Text('No measurements added yet',
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.grey)),
                      ] else if (avgGlucose > 100) ...[
                        Text('👍', style: TextStyle(fontSize: 23.sp)),
                        SizedBox(width: 8.w),
                        Text('${avgGlucose.toStringAsFixed(1)} mg/dl',
                            style: TextStyle(
                                fontSize: 23.sp, color: Colors.green)),
                      ] else ...[
                        Column(children: [
                          Text('👎 ${avgGlucose.toStringAsFixed(1)} mg/dl',
                              style: TextStyle(
                                  fontSize: 23.sp, color: Colors.red)),
                          Text('you need to visit doctor',
                              style:
                                  TextStyle(fontSize: 20.sp, color: Colors.red))
                        ]),
                      ],
                    ],
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            _buildGlucoseChart(),
            SizedBox(height: 20.h),
            Center(
              child: FloatingActionButton(
                onPressed: _showAddMeasurementDialog,
                backgroundColor: const Color.fromARGB(216, 39, 148, 148),
                child: Icon(Icons.add, color: Colors.white, size: 25.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlucoseChart() {
    if (measurements.isEmpty) {
      return Center(
        child: Text(
          "No measurements to show",
          style: TextStyle(fontSize: 18.sp, color: Colors.grey),
        ),
      );
    }

    List<FlSpot> spots = [];
    List<String> labels = [];

    if (selectedFilter == 'TODAY') {
      final today = DateTime.now();
      final todayMeasurements = measurements
          .where((m) =>
              m.dateTime.year == today.year &&
              m.dateTime.month == today.month &&
              m.dateTime.day == today.day)
          .toList();

      for (var i = 0; i < todayMeasurements.length; i++) {
        spots.add(FlSpot(i.toDouble(), todayMeasurements[i].value));
        labels.add(DateFormat.Hm().format(todayMeasurements[i].dateTime));
      }
    } else if (selectedFilter == 'WEEKLY') {
      DateTime now = DateTime.now();
      DateTime weekAgo = now.subtract(Duration(days: 6));

      // مجموعة قياسات الأيام السبعة الأخيرة
      List<double> dailyAverages = List.filled(7, 0);
      List<int> dailyCounts = List.filled(7, 0);

      for (var m in measurements) {
        if (!m.dateTime.isBefore(weekAgo)) {
          int diff = m.dateTime.difference(weekAgo).inDays;
          dailyAverages[diff] += m.value;
          dailyCounts[diff]++;
        }
      }

      for (int i = 0; i < 7; i++) {
        if (dailyCounts[i] > 0) {
          dailyAverages[i] /= dailyCounts[i];
        }
        spots.add(FlSpot(i.toDouble(), dailyAverages[i]));
        labels.add(days[i]);
      }
    } else {
      // Monthly - average by week or days (simplify: average by week number)
      DateTime now = DateTime.now();
      DateTime monthAgo = now.subtract(Duration(days: 29));

      List<double> weeklyAverages = List.filled(5, 0);
      List<int> weeklyCounts = List.filled(5, 0);

      for (var m in measurements) {
        if (!m.dateTime.isBefore(monthAgo)) {
          int weekNum = ((m.dateTime.difference(monthAgo).inDays) / 7).floor();
          if (weekNum >= 0 && weekNum < 5) {
            weeklyAverages[weekNum] += m.value;
            weeklyCounts[weekNum]++;
          }
        }
      }

      for (int i = 0; i < 5; i++) {
        if (weeklyCounts[i] > 0) {
          weeklyAverages[i] /= weeklyCounts[i];
        }
        spots.add(FlSpot(i.toDouble(), weeklyAverages[i]));
        labels.add('W${i + 1}');
      }
    }

    return SizedBox(
      height: 220.h,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35.h,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index < 0 || index >= labels.length) return Container();
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      labels[index],
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40.w,
                  interval: 20,
                  getTitlesWidget: (value, meta) {
                    return Text(value.toInt().toString(),
                        style: TextStyle(fontSize: 12.sp));
                  }),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 3,
              dotData: FlDotData(show: true),
              belowBarData:
                  BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
              color: Colors.blue,
            ),
          ],
          minY: 0,
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton(
      {required this.text,
      required this.isSelected,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
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
