import 'package:flutter/material.dart';
import 'package:sugar_iq/widgets/app_theme.dart';
import 'text_style.dart';

class SelectionOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 64,
          vertical: 21,
        ),
        decoration: BoxDecoration(
          color:
              isSelected ? AppTheme.optionBgSelected : AppTheme.optionBgDefault,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.optionText,
        ),
      ),
    );
  }
}
