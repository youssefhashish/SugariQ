import 'package:flutter/material.dart';
import 'medication_model.dart';

class MedicationProvider with ChangeNotifier {
  final List<Medication> _medications = [];

  List<Medication> get medications => _medications;

  void addMedication(Medication med) {
    _medications.add(med);
    notifyListeners();
  }

  void clearMedications() {
    _medications.clear();
    notifyListeners();
  }
}
