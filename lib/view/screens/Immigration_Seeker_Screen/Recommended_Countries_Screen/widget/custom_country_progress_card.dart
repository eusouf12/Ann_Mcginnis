import 'package:ann_mcginnis/service/api_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomCountryProgressCar extends StatelessWidget {
  final String? img;
  final String? valueScore;
  final String? title;
  final String? subTitle;

  const CustomCountryProgressCar({
    super.key,
    this.img,
    required this.valueScore,
    this.title,
    this.subTitle,
  });

  // ── Score color logic ──
  Color _scoreColor(int score) {
    if (score >= 70) return const Color(0xFF2E7D32); // green
    if (score >= 50) return const Color(0xFFE65100); // orange
    return const Color(0xFFC62828); // red
  }

  Color _scoreBgColor(int score) {
    if (score >= 70) return const Color(0xFFE8F5E9);
    if (score >= 50) return const Color(0xFFFFF3E0);
    return const Color(0xFFFFEBEE);
  }

  @override
  Widget build(BuildContext context) {
    final int score = int.tryParse(valueScore ?? "0") ?? 0;
    final Color scoreColor = _scoreColor(score);
    final Color scoreBg = _scoreBgColor(score);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomNetworkImage(
                imageUrl: ApiUrl.imageUrl + "${img ?? ""}",
                height: 20,
                width: 40,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title ?? "Canada",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary1,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      text: subTitle ?? "Top Match",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              // Color-coded checkmark dot badge
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: scoreBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: scoreColor.withOpacity(0.25)),
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: scoreColor,
                  size: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 10,
              backgroundColor: AppColors.grey_1,
              color: scoreColor,
            ),
          ),
        ],
      ),
    );
  }
}
