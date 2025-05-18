import 'package:flutter/material.dart';

class ProfileImageNotifier extends ValueNotifier<String?> {
  ProfileImageNotifier(String? initialImagePath) : super(initialImagePath);

  void updateImage(String newPath) {
    value = newPath;
  }
}
