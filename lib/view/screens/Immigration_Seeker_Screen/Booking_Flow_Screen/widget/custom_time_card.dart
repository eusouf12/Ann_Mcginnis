import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTimeCard extends StatelessWidget {
  final String time;
  final bool isAvailable;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTimeCard({
    super.key,
    required this.time,
    required this.isAvailable,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color borderColor;
    Color textColor;

    if (!isAvailable) {
      bgColor = Colors.white;
      borderColor = Colors.black;
      textColor = Colors.black;
    } else if (isSelected) {
      bgColor = AppColors.primary1;
      borderColor = Colors.blue;
      textColor = Colors.white;
    } else {
      bgColor = const Color(0xFFDCFCE7);
      borderColor = const Color(0xFF86EFAC);
      textColor = Colors.black;
    }

    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
