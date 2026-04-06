import 'package:ann_mcginnis/utils/app_const/app_const.dart';
import 'package:ann_mcginnis/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCountryCard extends StatelessWidget {
  final String? imagePath;
  final String? countryName;
  final String? cityName;
  final int? matchPercentage;
  final double? rating;
  final VoidCallback? onTap;

  const CustomCountryCard({
    super.key,
    this.imagePath,
    this.countryName,
    this.cityName,
    this.matchPercentage,
    this.rating,
    this.onTap,
  });

  // ── Score color logic ──
  Color _scoreColor(int score) {
    if (score >= 70) return const Color(0xFF2E7D32); // green
    if (score >= 50) return const Color(0xFFE65100); // orange
    return const Color(0xFFC62828); // red
  }



  @override
  Widget build(BuildContext context) {
    final int score = matchPercentage ?? 0;
    final Color scoreColor = _scoreColor(score);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170.w,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Country image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CustomNetworkImage(
                imageUrl: imagePath ?? AppConstants.countryPoliticalMove,
                height: 100,
                width: double.infinity,
              ),
            ),

            SizedBox(height: 10.h),

            // Country name + checkmark beside it
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    countryName ?? "Japan",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 6.w),
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        scoreColor,
                        scoreColor.withOpacity(0.75),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                    boxShadow: [
                      BoxShadow(
                        color: scoreColor.withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 15.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}