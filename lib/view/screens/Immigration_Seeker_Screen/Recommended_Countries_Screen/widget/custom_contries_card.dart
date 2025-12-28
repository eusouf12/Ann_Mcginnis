import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
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

            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CustomNetworkImage(imageUrl: imagePath ?? AppConstants.countryPoliticalMove, height: 100, width: double.infinity)
            ),

            SizedBox(height: 12.h),

            Text(
              countryName ?? "Japan",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 4.h),

            Text(
              cityName ?? "Tokyo",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$matchPercentage% Match",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary1,
                  ),
                ),

                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}