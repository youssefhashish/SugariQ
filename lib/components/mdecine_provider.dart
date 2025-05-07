import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'medication_model.dart';

class MedicationProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Medication> _medications = [];

  List<Medication> get medications => _medications;

  Future<void> fetchMedications() async {
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('medications')
          .get();

      _medications = snapshot.docs
          .map((doc) => Medication.fromJson(doc.data()))
          .toList();
      notifyListeners();
    }
  }

  Future<void> addMedication(Medication medication) async {
    final user = _auth.currentUser;
    if (user != null) {
      final docRef = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('medications')
          .add(medication.toJson());

      _medications.add(medication.copyWith(id: docRef.id));
      notifyListeners();
    }
  }

  Future<void> removeMedication(String id) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('medications')
          .doc(id)
          .delete();

      _medications.removeWhere((med) => med.id == id);
      notifyListeners();
    }
  }
}
