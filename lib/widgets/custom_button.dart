import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color color;
  final Color splashColor;

  const CustomFlatButton({
    super.key,
    required this.title,
    required this.textColor,
    required this.fontSize,
    required this.fontWeight,
    required this.onPressed,
    required this.color,
    required this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: splashColor,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          title,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            decoration: TextDecoration.none,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: "OpenSans",
          ),
        ),
      ),
    );
  }
}
