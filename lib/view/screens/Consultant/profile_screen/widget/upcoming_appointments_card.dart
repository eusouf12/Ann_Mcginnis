import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class UpcomingAppointmentsCard extends StatelessWidget {
  final String? img;
  final String? title;
  final String? subTitle;
  final String? date;
  final String? time;
  final bool isConfirm;
  final VoidCallback? onTapJoin;
  final VoidCallback? onTapReschedule;
  final VoidCallback? onTapViewDetails;
  final VoidCallback? onTapConfirm;

  const UpcomingAppointmentsCard({
    super.key,
    this.img,
    this.title,
    this.subTitle,
    this.date,
    this.time,
    this.isConfirm = false,
    this.onTapJoin,
    this.onTapReschedule,
    this.onTapViewDetails,
    this.onTapConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isConfirm ? const Color(0xFFF0F8FF) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: isConfirm
            ? Border(left: BorderSide(color: AppColors.primary1, width: 4.w))
            : Border.all(color: Colors.grey.withOpacity(0.2)),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isConfirm
                      ? Border.all(color: Colors.blue, width: 2)
                      : null,
                ),
                padding: EdgeInsets.all(2.w),
                child: ClipOval(
                  child: CustomNetworkImage(
                    imageUrl: img ?? "",
                    height: 50.h,
                    width: 50.h,
                    boxShape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Text Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title ?? "Dr. Sarah Mitchell",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary1,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: subTitle ?? "Immigration Specialist - Canada",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]!,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, size: 14.sp, color: Colors.grey[700]),
                        SizedBox(width: 6.w),
                        CustomText(
                          text: "${date ?? 'Dec 12, 2024'} - ${time ?? '10:00 AM'}",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.grey[800]!,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: isConfirm
                          ? AppColors.primary1.withOpacity(0.15)
                          : Colors.orange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      text: isConfirm ? "Confirmed" : "Pending",
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isConfirm ? AppColors.primary1 : Colors.orange,
                    ),
                  ),
                ],
              ),

            ],
          ),
          SizedBox(height: 16.h),

          // Button Section
          Row(
            children: [
              // ================= BUTTON 1 =================
              Expanded(
                child: SizedBox(
                  height: 40.h,
                  child:isConfirm? CustomButton(
                    onTap:  onTapJoin ,
                    title: "Join Call" ,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fillColor: AppColors.yellow1 ,
                    textColor: AppColors.primary1,
                    icon: Icon( Icons.videocam , color: AppColors.primary1, size: 18.sp,),
                  )
                      :CustomButton(
                    onTap: onTapViewDetails,
                    title:  "Confirm",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fillColor:AppColors.primary1 ,
                    textColor:AppColors.white,

                  )
                ),
              ),

              SizedBox(width: 12.w),

              // ================= BUTTON 2 =================
              Expanded(
                child: SizedBox(
                  height: 40.h,
                  child: isConfirm
                      ? CustomButton(
                    onTap: onTapConfirm,
                    title: "View Details",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fillColor: AppColors.white,
                    textColor: Colors.black,
                    isBorder: true,
                    borderColor: Colors.grey,
                    icon: Icon(Icons.schedule, color: Colors.black87, size: 18.sp),
                  )
                      : CustomButton(
                    onTap: onTapConfirm,
                    title: "Reschedule",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fillColor: AppColors.grey_1,
                    textColor: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}