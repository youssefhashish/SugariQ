import 'package:flutter/material.dart';

class Medication {
  final String name;
  final int timesPerDay;
  final List<TimeOfDay> times;

  Medication({
    required this.name,
    required this.timesPerDay,
    required this.times,
  });
}
