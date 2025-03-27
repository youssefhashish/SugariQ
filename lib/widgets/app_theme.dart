import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF6FBE5A);
  static const Color primaryBlue = Color(0xFF397ED0);
  static const Color lightBlue = Color(0xFFE7F1FF);
  static const Color primaryRed = Color(0xFFED6461);
  static const Color lightPurple = Color(0xFFEDDFFF);
  static const Color lightRed = Color(0xFFFFDEDD);
  static const Color borderGrey = Color(0xFFF0F0F0);
  static const Color textGrey = Color(0xFFABAFB3);
  static const Color textBlack = Color(0xFF0A0A0A);
  static const Color background = Colors.white;
  static const Color progressTrackBg = Color(0xFFE7F1FF);
  static const Color progressIndicator = Color(0xFFED6461);
  static const Color textPrimary = Color(0xFF0A0A0A);
  static const Color optionBgDefault = Color(0xFFF8F8FB);
  static const Color optionBgSelected = Color(0xFFEDDFFF);
  static const Color buttonGradientStart = Color(0xFF6FBE5A);
  static const Color buttonGradientEnd = Color(0xFF85C26F);

  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: 'Cera Pro',
    color: Colors.black,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Airbnb Cereal App',
    color: textGrey,
  );

  static const TextStyle rowTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Airbnb Cereal App',
    color: textBlack,
  );

  static const TextStyle selectTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontFamily: 'Convergence',
    color: primaryBlue,
  );
}
