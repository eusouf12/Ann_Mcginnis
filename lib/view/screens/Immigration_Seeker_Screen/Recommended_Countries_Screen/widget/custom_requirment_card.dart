import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/custom_text/custom_text.dart';


class CustomRequirementCard extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final Color? borderColor;
  final Color iconColor;
  final Color? iconBackgroundColor;
  final bool isMandatory;
  final bool isCompleted;
  final bool hasSideAccent;

  const CustomRequirementCard({
    super.key,
    required this.title,
    required this.description,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.iconColor = Colors.blue,
    this.iconBackgroundColor,
    this.isMandatory = false,
    this.isCompleted = false,
    this.hasSideAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 4.h),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                      fontFamily: 'Inter',
                    ),
                    children: [
                      TextSpan(text: description),
                      // Important Notice
                      if (hasSideAccent)
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Icon(Icons.star, color: Colors.amber, size: 14.sp),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (isMandatory)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Icon(Icons.star, color: Colors.amber, size: 20.sp),
            ),

          if (isCompleted)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.white, size: 12.sp),
              ),
            ),
        ],
      ),
    );
  }
}