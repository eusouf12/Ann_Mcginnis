import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_text/custom_text.dart';

class CountryVisaCard extends StatelessWidget {
  final String? img;
  final String? title;
  final String? subTitle;
  final String? description;
  final String? matchPercent;
  final String? tagText;

  // Styling Properties
  final Color backgroundColor;
  final Color tagColor;
  final Color tagTextColor;
  final bool hasBorder;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onTap;

  const CountryVisaCard({
    super.key,
    this.img,
    this.title,
    this.subTitle,
    this.description,
    this.matchPercent,
    this.tagText,
    this.backgroundColor = Colors.white,
    this.tagColor = const Color(0xFFFFF9C4),
    this.tagTextColor = const Color(0xFFFBC02D),
    this.hasBorder = false,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onTap,
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
          borderRadius: BorderRadius.circular(12.r),
          border:  Border.all(color: const Color(0xFFC8E6C9), width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Section (Flag, Title, Heart)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomNetworkImage(imageUrl:img?? "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Flag_of_Australia.svg/2560px-Flag_of_Australia.svg.png", height: 20, width: 40),
                SizedBox(width: 20,),
                Column(children: [
                  CustomText(
                      text: title ?? "Canada",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary1
                  ),
                  CustomText(
                      text: subTitle ?? "Top Match",fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black
                  ),
                ]),
                Spacer(),
                // Favorite Heart Icon
                GestureDetector(
                  onTap: onFavoriteTap,
                  child: Icon(
                    isFavorite==false ? Icons.favorite : Icons.favorite_border,
                    color: const Color(0xFF1565C0),
                    size: 24.sp,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // 2. Description
            CustomText(
              text: description ??"",
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.grey[800]!,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 16.h),

            // 3. Tags Row
            Row(
              children: [

                _buildTag(
                    text: "${matchPercent} % Match",
                  bgColor: const Color(0xFFE3F2FD),
                  textColor: const Color(0xFF1565C0),
                ),

                SizedBox(width: 10.w),

                // Dynamic Status Tag (Fast Track, High Demand, etc.)
                tagText == "Fast Track"
                ?
                _buildTag(
                  text: tagText ?? '',
                  bgColor: tagColor,
                  textColor: Color(0xFF7E22CE),
                )
                    :
                _buildTag(
                  text: tagText ?? '',
                  bgColor:  Color(0xFFDCFCE7),
                  textColor: Color(0xFF15803D)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for Tags
  Widget _buildTag({
    required String text,
    required Color bgColor,
    required Color textColor
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}