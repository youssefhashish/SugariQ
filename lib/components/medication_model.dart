import 'package:flutter/material.dart';

class Medication {
  final String? id;
  final String name;
  final int timesPerDay;
  final List<TimeOfDay> times;

  Medication({
    this.id,
    required this.name,
    required this.timesPerDay,
    required this.times,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'timesPerDay': timesPerDay,
      'times': times.map((time) => {'hour': time.hour, 'minute': time.minute}).toList(),
    };
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      name: json['name'],
      timesPerDay: json['timesPerDay'],
      times: (json['times'] as List)
          .map((time) => TimeOfDay(hour: time['hour'], minute: time['minute']))
          .toList(),
    );
  }

  Medication copyWith({String? id}) {
    return Medication(
      id: id ?? this.id,
      name: name,
      timesPerDay: timesPerDay,
      times: times,
    );
  }
}
