import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key, required double progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightBlue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Container(
        width: 82,
        height: 6,
        decoration: BoxDecoration(
          color: AppTheme.primaryRed,
          borderRadius: BorderRadius.circular(31),
        ),
      ),
    );
  }
}
