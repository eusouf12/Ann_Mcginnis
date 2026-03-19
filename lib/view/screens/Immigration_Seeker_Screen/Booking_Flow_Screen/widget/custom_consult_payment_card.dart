import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/view/screens/Consultant/profile_screen/consult_profile_setup_screen.dart' hide AppColors;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsultationTypeCard extends StatelessWidget {
  final String title;
  final String price;
  final String currency;
  final bool isSelected;
  final VoidCallback onTap;

  const ConsultationTypeCard({
    super.key,
    required this.title,
    required this.price,
    required this.currency,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F1FF) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary1 : Colors.grey.withOpacity(0.3),
            width: isSelected ? 1.5.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            // 1. Radio Button Icon
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.primary1 : Colors.grey,
              size: 24.sp,
            ),

            SizedBox(width: 12.w),

            // 2. Texts (Title & Subtitle)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0D1B2A),
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),

            // 3. Price
            Column(
              children: [
                CustomText(text: price,fontWeight: FontWeight.bold,fontSize: 16.sp,color: const Color(0xFF1A237E),),
                CustomText(text: currency,fontWeight: FontWeight.bold,fontSize: 10.sp,color:  Colors.black,)
              ],
            )
          ],
        ),
      ),
    );
  }
}