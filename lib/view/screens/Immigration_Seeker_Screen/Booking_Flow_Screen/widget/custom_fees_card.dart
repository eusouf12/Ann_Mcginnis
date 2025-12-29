import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomConsultationCard extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? price;
  final Color? bgColor;
  final Color? priceColor;

  const CustomConsultationCard({
    super.key,
    this.title,
    this.subTitle,
    this.price,
    this.bgColor,
    this.priceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title ?? "Video Consultation",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              SizedBox(height: 4.h),
              CustomText(
                text: "${subTitle} minutes session",
                fontSize: 12,
                color: Colors.grey,
              ),
            ],
          ),
          CustomText(
            text: "\$ $price",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: priceColor ?? Colors.blue,
          ),
        ],
      ),
    );
  }
}
