import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class MyBookinConsultant extends StatelessWidget {
  final String? img;
  final String? title;
  final String? subTitle;
  final String? date;
  final String? time;
  final String? status;
  final String? currency;
  final num? originalAmount;
  final num? amount;
  final num? discountAmount;
  final num? discountRate;
  final String? consultationType;
  final bool show;
  final VoidCallback? onTapJoin;
  final VoidCallback? onTapReschedule;
  final VoidCallback? onTapViewDetails;

  const MyBookinConsultant({
    super.key,
    this.img,
    this.title,
    this.subTitle,
    this.date,
    this.time,
    this.status,
    this.currency,
    this.originalAmount,
    this.amount,
    this.discountAmount,
    this.discountRate,
    this.consultationType,
    required this.show,
    this.onTapJoin,
    this.onTapReschedule,
    this.onTapViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F8FF) ,
        borderRadius: BorderRadius.circular(12.r),
        border: Border(left: BorderSide(color: AppColors.primary1, width: 4.w)),
            // ? Border(left: BorderSide(color: AppColors.primary1, width: 4.w))
            // : Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2)
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
                      text: title ?? "",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary1,
                      textAlign: TextAlign.start,
                      maxLines: 5,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: subTitle ?? "",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]!,
                      textAlign: TextAlign.start,
                    ),

                  ],
                ),
              ),
              //status
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: status == "cancelled" ? AppColors.red.withOpacity(0.2) : status == "completed" ?AppColors.primary1.withOpacity(0.2) :status == "pending" ? Colors.green.withOpacity(0.1) :status== "ongoing" ?Colors.deepOrange.withOpacity(0.1) : Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomText(
                  text: "$status",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color:status == "cancelled" ? AppColors.red : status == "completed" ?AppColors.primary1 :status == "pending" ? Colors.green : status== "ongoing" ?Colors.deepOrange : Colors.deepPurple,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // date and time
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month, size: 20.sp, color: Colors.grey[700]),
                  SizedBox(width: 6.w),
                  CustomText(
                    text: "${date ?? ''} ",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.grey[800]!,
                  ),
                ],
              ),
              SizedBox(width: 10.h),
              //time
              Row(
                children: [
                  Icon(Icons.access_time_rounded, size: 20.sp, color: Colors.grey[700]),
                  SizedBox(width: 6.w),
                  CustomText(
                    text: " ${time ?? ''}",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.grey[800]!,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height:10.h),
          //consultation type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                        children: [
                          Icon(consultationType?.toLowerCase().contains("video") == true ? Icons.videocam : Icons.phone, size: 16.sp, color: AppColors.primary1),
                          SizedBox(width: 6.w),
                          CustomText(
                              text: consultationType?.replaceAll("-", " ") ?? "",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color:  AppColors.primary1
                          ),
                        ],
                      ),
                  SizedBox(height:10.h),
                  if ((discountRate ?? 0) > 0)
                    CustomText(
                      text: "Saved ${currency ?? "\$"} $discountAmount",
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                      textAlign: TextAlign.start,
                    ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "${currency ?? "\$"} $originalAmount",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  CustomText(
                    text: "${currency ?? "\$"} $amount",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary1,
                  ),
                ],
              ),
            ],
          ),




          SizedBox(height: 16.h),

          //====== Price Section


          SizedBox(height: 16.h),

          // Button Section
          show==true?
          status =="cancelled"|| status =="completed" || status =="ongoing"?
          CustomButton(
            onTap: (){} ,
            title:status =="cancelled" ? "Cancelled" : status =="completed" ? "Completed" : "Ongoing" ,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            height: 40,
            fillColor:status =="cancelled" ? AppColors.red : status =="completed" ? AppColors.primary1 : Colors.deepOrange,
            textColor: AppColors.white,
          ) : SizedBox.shrink() :
          // show==false?SizedBox.shrink():
          Row(
            children: [
              // ================= BUTTON 1 =================
              status == "pending" || status =="cancelled"|| status =="completed" || status =="ongoing"?
              SizedBox.shrink():
              Expanded(
                child: SizedBox(
                  height: 40.h,
                  child: CustomButton(
                    onTap: onTapJoin ,
                    title: "Join" ,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fillColor: AppColors.yellow1,
                    textColor: AppColors.primary1,
                    icon: Icon(Icons.videocam, color: AppColors.primary1, size: 18.sp,),
                  ),
                ),
              ),



              SizedBox(width: 12.w),

              // ================= BUTTON 2 =================
              Expanded(
                child: SizedBox(
                  height: 40.h,
                  child: status =="cancelled"|| status =="completed" || status =="ongoing"?
                  SizedBox.shrink():
                  CustomButton(
                    onTap: onTapReschedule,
                    title: "Reschedule",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fillColor: AppColors.white,
                    textColor: Colors.black,
                    isBorder: true,
                    borderColor: Colors.grey,
                    icon: Icon(Icons.schedule, color: Colors.black87, size: 18.sp),
                  )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}