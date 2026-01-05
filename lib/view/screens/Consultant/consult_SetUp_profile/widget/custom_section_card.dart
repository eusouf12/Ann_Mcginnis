import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors/app_colors.dart';

class CustomSectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final RxBool isChecked;
  final ValueChanged<bool?> onChanged;
  final double padding;
  final double borderRadius;
  final Color cardColor;

  const CustomSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.isChecked,
    required this.onChanged,
    this.padding = 10,
    this.borderRadius = 15,
    this.cardColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(
        width: double.infinity,
        padding: EdgeInsets.all(padding.w),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(borderRadius.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          children: [
            Checkbox(
              value: isChecked.value,
              onChanged: onChanged,
            ),
            Icon(icon, color: AppColors.primary1, size: 20),
            SizedBox(width: 10.w),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
