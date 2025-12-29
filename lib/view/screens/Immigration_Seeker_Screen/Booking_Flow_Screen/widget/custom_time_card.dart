import 'package:flutter/material.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomTimeCard extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTimeCard({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFDCFCE7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.black : Color(0xFF86EFAC),
            width: 1.5,
          ),
        ),
        child: CustomText(
          text: time,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
