
import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/utils/app_const/app_const.dart';
import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:ann_mcginnis/view/screens/Immigration_Seeker_Screen/Recommended_dashboard_Screen/controller/user_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../Recommended_Countries_Screen/widget/custom_country_progress_card.dart';
import '../widget/book_consultation_card.dart';
import '../widget/custom_payment_card.dart';
import '../../SetUp_Profile_Screen/custom_save_countries.dart';

class UserDashboard extends StatelessWidget {
  UserDashboard({super.key});
  final UserDashboardController controller = Get.put(UserDashboardController());

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
             CustomImage(imageSrc: AppImages.logoApp, height: 28.h, width: 28.w, ),
              SizedBox(width: 8.w),
              CustomText(text: "Global Jump", fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.primary, textAlign: TextAlign.start,),
            ],
          ),
          actions: [
            // 3. Notification
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {
                    },
                    icon: Icon(
                      Icons.notifications_none,
                      color: const Color(0xFF0D1B2A),
                      size: 26.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  // Red Badge
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16.w,
                        minHeight: 16.w,
                      ),
                      child: Center(
                        child: Text(
                          "2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 15.w),
            // 4. Profile Image
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.userProfileScreen);
              },
              child:   ClipOval(
                child: CustomNetworkImage(
                  imageUrl: AppConstants.profileImage2,
                  height: 50.h,
                  width: 50.h,
                  boxShape: BoxShape.circle,
                ),
              ),
            ),

            SizedBox(width: 20.w), // ডান পাশে একটু গ্যাপ
          ],
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text: "Welcome, Sarah!",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary1,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 20.h),
            // toggle tab
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => Container(
                padding: EdgeInsets.only(top: 20.h,left: 10.h,right: 10.h,),
                decoration: BoxDecoration(
                  color: AppColors.primary1,
                ),
                child: Row(
                  children: List.generate(controller.tabs.length, (index) {
                    bool isSelected = controller.selectedDashboardTab.value == index;
                    return GestureDetector(
                      onTap: () => controller.changeTab(index),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 20.h, right: 10.w, left: 10.w),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected ? AppColors.yellow1 : Colors.transparent,
                              width: 4.h,
                            ),
                          ),
                        ),
                        child: CustomText(
                          text: controller.tabs[index],
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color:  Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              )),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Obx(() {
                    // TAB - 00
                    if (controller.selectedDashboardTab.value == 0) {
                      //Eligibility Results
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Eligibility Results",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary1,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 20.h),
                          Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primary1,width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFDBEAFE),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        CustomNetworkImage(imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Flag_of_Australia.svg/2560px-Flag_of_Australia.svg.png", height: 20, width: 40),
                                        SizedBox(width: 20,),
                                        Column(children: [
                                          CustomText(
                                              text: "Canada",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primary1
                                          ),
                                          CustomText(
                                              text: "Top Match",fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black
                                          ),
                                        ]),
                                        Spacer(),
                                        Container(
                                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: AppColors.yellow1,
                                            ),
                                            child: Center(
                                              child: CustomText(
                                                  text: "92%",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.primary1
                                              ),
                                            )
                                        )
                                      ]),
                                      SizedBox(height: 20,),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                               CustomText(
                                                text: "Eligibility Score",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                 color: AppColors.primary1,
                                              ),
                                              CustomText(
                                                text: "${controller.successScoreRate.value.toInt()}/100",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: AppColors.primary1,
                                              ),

                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: LinearProgressIndicator(
                                              value: controller.successScoreRate.value/100,
                                              minHeight: 12,
                                              backgroundColor: AppColors.grey_1,
                                              color: AppColors.primary1,
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      CustomButton(
                                          onTap: (){},
                                          title: "View Details",
                                          textColor: AppColors.primary1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          SizedBox(height: 20.h),
                          CustomText(
                            text: "Other Recommendations",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary1,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 20.h),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: CustomCountryProgressCar(
                                  valueScore: " 85",
                                  title:index==1 ? "Australia" : "Canada",
                                  subTitle: "Top Match",
                                  img: index ==0 ? "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Flag_of_Canada.svg/1280px-Flag_of_Canada.svg.png" : null,
                                ),
                              );
                            },
                          )
                    ],
                      );
                    }
                    // TAB - 01
                    else if (controller.selectedDashboardTab.value == 1) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Booked Consultations",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary1,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 20.h),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: BookConsultationCard(
                                  title:index==1 ? "John Robertson" : null,
                                  subTitle: "Visa Consultant - Australia",
                                  img: AppConstants.profileImage2,
                                  isBooked:index==1? true:false,
                                ),
                              );
                            },
                          )
                        ],
                      );
                    }
                    else if (controller.selectedDashboardTab.value == 2) {
                      return Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Saved Countries",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary1,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 10.h),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CountryVisaCard(
                                      title: index==1 ? "Australia" : "Canada",
                                      img: null,
                                      subTitle: 'Independent',
                                      description: 'Points-based system. Great lifestyle and career opportunities.',
                                      matchPercent: '72',
                                      tagText: index==1 ? 'Fast Track' : "High Demand",
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      );
                    }
                    else {
                      return Column(
                        children: [
                          CustomText(
                            text: "Payments",//PaymentCard
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:  AppColors.primary1,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 20.h),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: PaymentCard(
                                  subTitle: "Visa Consultant - Australia",
                                  title: 'Document Review',
                                  date: 'Dec 24, 2025',
                                  price: '150',
                                  isPaid: index == 1 ? true:false,
                                  onTap: () {  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Color(0xFFF0FDF4),
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
                            child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Total Paid",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                    CustomText(
                                      text: "\$150",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),

                          )
                        ],
                      );
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}