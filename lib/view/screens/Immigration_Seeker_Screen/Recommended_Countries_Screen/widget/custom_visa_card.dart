import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomVisaCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String type;
  final Color typeColor;
  final Color typeTextColor;
  final VoidCallback onTap;

  const CustomVisaCard({
    super.key,
    required this.title,
    required this.description,
    this.icon = Icons.work,
    required this.onTap, required this.type, required this.typeColor,
    required this.typeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Icon & Popular Tag Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Box
              Container(
                height: 45.h,
                width: 45.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF1A237E),
                  size: 24.sp,
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: typeColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomText(
                  text: type,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: typeTextColor,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // 2. Title
          CustomText(
            text: title,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            textAlign: TextAlign.start,
          ),

          SizedBox(height: 8.h),

          // 3. Description
          CustomText(
            text: description,
            fontSize: 14,
            color: Colors.grey[600]!,
            textAlign: TextAlign.start,
            maxLines: 3,
            fontWeight: FontWeight.w400,
          ),

          SizedBox(height: 20.h),

          // 4. Button
          CustomButton(
            onTap: () {

            },
            title: "Learn More",
            fontSize: 14,
             height: 48,
            fontWeight: FontWeight.bold,
            textColor: Colors.white,
            fillColor: AppColors.yellow1,
          ),
        ],
      ),
    );
  }
}