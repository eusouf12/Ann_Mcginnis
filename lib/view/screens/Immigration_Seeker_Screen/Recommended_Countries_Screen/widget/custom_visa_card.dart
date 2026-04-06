import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class CustomVisaCard extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final IconData icon;
  final String type;
  final Color? typeColor;
  final Color? typeTextColor;
  final VoidCallback? onTap;

  const CustomVisaCard({
    super.key,
    required this.title,
    required this.duration,
    required this.description,
    this.icon = Icons.work_rounded,
    this.onTap,
    required this.type,
    this.typeColor,
    this.typeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row 1: Icon + tag + arrow
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon box
                Container(
                  height: 46.w,
                  width: 46.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary1.withOpacity(0.12),
                        AppColors.primary1.withOpacity(0.06),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primary1,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        textAlign: TextAlign.start,
                      ),
                      if (duration.isNotEmpty) ...[
                        SizedBox(height: 3.h),
                        Row(
                          children: [
                            Icon(Icons.schedule_rounded,
                                color: Colors.grey[400], size: 13.sp),
                            SizedBox(width: 4.w),
                            CustomText(
                              text: duration,
                              fontSize: 12,
                              color: Colors.grey[500]!,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                // Arrow
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FF),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.primary1,
                    size: 14.sp,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Description
            CustomText(
              text: description,
              fontSize: 13,
              color: const Color(0xFF6B7280),
              textAlign: TextAlign.start,
              maxLines: 3,
              fontWeight: FontWeight.w400,
            ),

            SizedBox(height: 12.h),

            // Bottom: tag chip
            if (type.isNotEmpty)
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: typeColor ?? const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomText(
                  text: type,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: typeTextColor ?? AppColors.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}