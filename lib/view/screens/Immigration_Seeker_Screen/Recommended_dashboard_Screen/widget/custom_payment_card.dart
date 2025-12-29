import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text/custom_text.dart';

class PaymentCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String date;
  final String price;
  final bool isPaid;
  final VoidCallback onTap;

  const PaymentCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.price,
    this.isPaid = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isPaid ? const Color(0xFFF1F8E9) : const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(12.r),
        border: isPaid
            ? Border.all(color: const Color(0xFFC8E6C9), width: 1.w)
            : Border(left: BorderSide(color: const Color(0xFFFFC107), width: 4.w)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Section: Title, Subtitle, Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: subTitle,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700]!,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: date,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]!,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomText(
                    text: "\$${price}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 6.h),
                  // Status Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: isPaid ? const Color(0xFFA5D6A7) : const Color(0xFFFFF59D),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      text: isPaid ? "Paid" : "Pending",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isPaid ? const Color(0xFF1B5E20) : const Color(0xFF5D4037),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Button Section
          SizedBox(
            width: double.infinity,
            height: 45.h,
            child: isPaid
                ? CustomButton(
              // View Invoice Button (White BG, Border)
              onTap: onTap,
              title: "View Invoice",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fillColor: Colors.white,
              textColor:AppColors.primary1,
              isBorder: true,
              borderColor: Colors.grey.withOpacity(0.3),
              icon: Icon(Icons.description, color: AppColors.primary1, size: 20.sp),
            )
                : CustomButton(
              // Pay Now Button (Yellow BG)
              onTap: onTap,
              title: "Pay Now",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fillColor: const Color(0xFFFFC107), // AppColors.yellow1
              textColor: const Color(0xFF1A237E),
              icon: Icon(Icons.credit_card, color: const Color(0xFF1A237E), size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }
}