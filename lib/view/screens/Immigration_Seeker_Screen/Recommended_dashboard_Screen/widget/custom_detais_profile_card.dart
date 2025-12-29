import 'package:ann_mcginnis/utils/app_const/app_const.dart';
import 'package:ann_mcginnis/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/custom_text/custom_text.dart';

class CustomDetailsProfileCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? title;
  final double? rating;
  final String? experience;
  final String? totalReviews;
  final String? patients;

  const CustomDetailsProfileCard({
    super.key,
    this.imageUrl,
    this.name,
    this.title,
    this.totalReviews,
    this.rating=0,
    this.experience,
    this.patients,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),

        /// Profile Image
        Center(child: CustomNetworkImage(imageUrl:imageUrl ??  AppConstants.profileImage2, height: 150, width: 150,boxShape: BoxShape.circle,)),

        /// Name
        CustomText(
          text: name ?? "",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          top: 15,
        ),

        /// Title
        CustomText(
          text: title ??"",
          fontSize: 14,
          color: Colors.blue,
          top: 5,
        ),

        /// Rating
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Stars
              ...List.generate(5, (index) {
                return Icon(
                  index < rating!.floor()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.orange,
                  size: 20,
                );
              }),

              SizedBox(width: 6.w),

              /// Numeric Rating
              Text(
                rating!.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              SizedBox(width: 4.w),

              /// Reviews Count
              Text(
                "(${totalReviews!} reviews)",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),


        /// Experience & Patients
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 16, color: Colors.black),
            CustomText(
              text: " ${experience}+ years",
              color: Colors.black,
              fontSize: 13,
              right: 15,
            ),
            const Icon(Icons.group_add_outlined, size: 16, color: Colors.black),
            CustomText(
              text: " ${patients}+ patients",
              color: Colors.black,
              fontSize: 13,
            ),
          ],
        ),
      ],
    );
  }
}
