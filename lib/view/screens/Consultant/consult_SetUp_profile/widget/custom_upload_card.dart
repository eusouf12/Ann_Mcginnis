import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/view/components/custom_text/custom_text.dart';

class CustomUploadCard extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData icon;
  final VoidCallback onChooseFile;

  const CustomUploadCard({
    super.key,
    required this.title,
    required this.hintText,
    required this.icon,
    required this.onChooseFile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          children: [
            Icon(icon, color: AppColors.primary1, size: 20.sp),
            SizedBox(width: 8.w),
            CustomText(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ],
        ),

        SizedBox(height: 10.h),

        /// Upload Box
        DottedBorder(
          color: Colors.grey.shade400,
          strokeWidth: 1,
          dashPattern: const [6, 3],
          borderType: BorderType.RRect,
          radius: Radius.circular(10.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Icon(Icons.cloud_upload_outlined, size: 40.sp, color: Colors.grey),
                SizedBox(height: 8.h),
                Text(
                  hintText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: onChooseFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  ),
                  child: const Text("Choose File", style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 8.h),
                Text(
                  "PDF, JPG, PNG up to 10MB",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}