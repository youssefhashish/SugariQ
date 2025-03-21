import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';

class SelectionRow extends StatelessWidget {
  final String title;
  final String value;
  final Color iconBackgroundColor;
  final bool isSelectable;

  const SelectionRow({
    super.key,
    required this.title,
    required this.value,
    required this.iconBackgroundColor,
    this.isSelectable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppTheme.rowTextStyle,
                ),
              ],
            ),
            Text(
              value,
              style: isSelectable
                  ? AppTheme.selectTextStyle
                  : AppTheme.rowTextStyle.copyWith(
                      fontFamily: 'Convergence',
                    ),
            ),
          ],
        ),
        const SizedBox(height: 19),
        Container(
          height: 1,
          color: AppTheme.borderGrey,
        ),
      ],
    );
  }
}
