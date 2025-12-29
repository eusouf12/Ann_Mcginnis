import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/recomended_countries_controller.dart';
import '../widget/custom_choose_card.dart';
import '../widget/custom_requirment_card.dart';
import '../widget/custom_timeline_card.dart';
import '../widget/custom_visa_card.dart';

class CountryDetailsScreen extends StatelessWidget {
  CountryDetailsScreen({super.key});

  final RecommendedCountriesController controller = Get.put(RecommendedCountriesController());

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // cover Photo
              Stack(
                children: [
                  CustomNetworkImage(imageUrl: "https://blog.onevasco.com/wp-content/uploads/country-image-Canada.jpg", height: 300, width: double.infinity,),
                  // Dark Overlay for better text visibility
                  Container(
                    height: 280.h,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  // Back & Share Icons
                  Positioned(
                    top: -30.h,
                    left: 0.w,
                    right: 20.w,
                    child: CustomRoyelAppbar(leftIcon: true,titleName: "Country Details",leftIconColor: Colors.white,color: Colors.white,),
                  ),
                  // Title & Description
                  Positioned(
                    bottom: 40.h,
                    left: 20.w,
                    right: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Canada",
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: "Discover endless opportunities in Canada, where world-class education, thriving job markets, and exceptional quality of life await.",
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                          textAlign: TextAlign.start,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 20,)
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Explore And Save Btn
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.recommendedCountriesScreen);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.yellow1,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            child: CustomText(
                              text: "Explore More",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary1,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            child: CustomText(
                              text: "Save for Later",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // toggle tab
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(() => Row(
                        children: List.generate(controller.tabs.length, (index) {
                          bool isSelected = controller.selectedTab.value == index;
                          return GestureDetector(
                            onTap: () => controller.changeTab(index),
                            child: Container(
                              padding: EdgeInsets.only(bottom: 8.h, right: 10.w, left: 10.w),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: isSelected ? const Color(0xFF2848D7) : Colors.transparent,
                                    width: 3.h,
                                  ),
                                ),
                              ),
                              child: CustomText(
                                text: controller.tabs[index],
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? const Color(0xFF2848D7) : Colors.grey,
                              ),
                            ),
                          );
                        }),
                      )),
                    ),
                    SizedBox(height: 20.h),
                    Obx(() {
                      // TAB - 00
                      if (controller.selectedTab.value == 0) {
                        //Why Choose
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(14.r),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE5E7EB),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Why Choose Canada?",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary1,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(height: 10.h),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: CustomChooseCard(
                                          title:
                                          "World-renowned education system with top universities",
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            // Population & Language
                            Row(
                              children: [
                                Expanded(child: _buildStatCard(Icons.groups, "38M", "Population")),
                                SizedBox(width: 15.w),
                                Expanded(child: _buildStatCard(Icons.language, "2", "Official Languages")),
                              ],
                            ),
                          ],
                        );
                      }
                      // TAB - 01
                      else if (controller.selectedTab.value == 1) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomVisaCard(
                              icon: Icons.business_center,
                              title: 'Work Visa',
                              description: 'Perfect for professionals seeking employment opportunities abroad. Duration:1-5 years.',
                              onTap: () {  },
                              type: 'Popular',
                              typeColor: Color(0xFFDCFCE7),
                              typeTextColor: Color(0xFF2E7D32),
                            ),
                            SizedBox(height: 10.h),
                            CustomVisaCard(
                              icon: Icons.school,
                              title: 'Student Visa',
                              description: 'Ideal for international students pursuing education. Valid for course duration.',
                              onTap: () {  },
                              type: 'Student',
                              typeColor: Color(0xFFF3E8FF),
                              typeTextColor: Color(0xFF7E22CE),
                            ),
                            SizedBox(height: 10.h),
                            CustomVisaCard(
                              icon: Icons.airplanemode_active,
                              title: 'Tourist Visa',
                              description: 'For leisure and tourism purposes. Short-term stay up to 90 days.',
                              onTap: () {  },
                              type: 'Travel',
                              typeColor: Color(0xFFE8EAF6),
                              typeTextColor: Color(0xFF1A237E),
                            ),
                            SizedBox(height: 10.h),
                            CustomVisaCard(
                              icon: Icons.apartment,
                              title: 'Business Visa',
                              description: 'For business meetings, conferences, and corporate travel. Multiple entry options.',
                              onTap: () {  },
                              type: 'Business',
                              typeColor: Color(0xFFDFFEDD5),
                              typeTextColor: Color(0xFFC2410C),
                            ),
                          ],
                        );
                      }
                      else if (controller.selectedTab.value == 2) {
                        return Column(
                          children: [
                           Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Requirements",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary1,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(height: 10.h),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: 2,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: CustomRequirementCard(
                                          title: index == 1 ? "Valid Passport" : "Education Level",
                                          description: index == 1 ?'Must be valid for at least 6 months from travel date' :"Proof of higher education with recognized institution",
                                          isMandatory: index == 1 ?false :true,
                                          isCompleted: index == 1 ? true :false,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 50.h),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0F5FD),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border(
                                        left: BorderSide(
                                          color:  AppColors.primary1,
                                          width: 4.w,
                                        ),
                                      ),
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
                                          children: [
                                            Icon(
                                              Icons.info,
                                              color:  AppColors.primary1,
                                              size: 20.sp,
                                            ),
                                            SizedBox(width: 8.w),
                                            CustomText(
                                              text: "Important Notice",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color:  AppColors.primary1,
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 8.h),
                                        Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF546E7A),
                                              fontFamily: 'Inter',
                                            ),
                                            children: [
                                              const TextSpan(text: "Requirements marked with "),
                                              WidgetSpan(
                                                alignment: PlaceholderAlignment.middle,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                                                  child: Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 18.sp,
                                                  ),
                                                ),
                                              ),
                                              const TextSpan(
                                                text: " \nmandatory and must be submitted with your application.",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                          ],
                        );
                      }
                      else {
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border:Border.all(color: Colors.grey.withOpacity(0.2)),
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
                                  CustomText(
                                    text: "Processing Time",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:  AppColors.black,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: "Processing Time :",
                                        fontSize: 14.sp,
                                        color:  Color(0xFF546E7A),
                                        textAlign: TextAlign.start,
                                        maxLines: 10,
                                      ),
                                      CustomText(
                                        text: " 4-6 weeks",
                                        fontSize: 20.sp,
                                        color:  AppColors.yellow1,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            //information
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border:Border.all(color: Colors.grey.withOpacity(0.2)),
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
                                    children: [
                                      Icon(
                                        Icons.info,
                                        color:  AppColors.primary1,
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      CustomText(
                                        text: "Important Information",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:  AppColors.black,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomText(
                                    text: "The processing time can vary based on the volume of applications, completeness of your documents, and additional background checks. Some applications may take longer due to country-specific requirements or holidays.",
                                    fontSize: 14.sp,
                                    color:  Color(0xFF546E7A),
                                    textAlign: TextAlign.start,
                                    maxLines: 10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            //Factors That May Cause Delays
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border:Border.all(color: Colors.grey.withOpacity(0.2)),
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
                                    children: [
                                      Icon(
                                        Icons.info,
                                        color:  AppColors.primary1,
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      CustomText(
                                        text: "Factors That May Cause Delays",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:  AppColors.black,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.circle_rounded,
                                        color: AppColors.yellow1,
                                        size: 12.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Document Inconsistencies ",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: AppColors.yellow1,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "- Missing or incorrect information",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.circle_rounded,
                                        color: AppColors.yellow1,
                                        size: 12.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Increased Application Volume ",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: AppColors.yellow1,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "- Peak season applications",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.circle_rounded,
                                        color: AppColors.yellow1,
                                        size: 12.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Holiday Seasons ",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: AppColors.yellow1,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "- Embassy closures and reduced processing",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.circle_rounded,
                                        color: AppColors.yellow1,
                                        size: 12.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Additional Interviews ",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: AppColors.yellow1,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "- Background checks may be required",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            //Typical Timeline
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border:Border.all(color: Colors.grey.withOpacity(0.2)),
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.account_tree_outlined,
                                        color: AppColors.primary1,
                                        size: 24.sp,
                                      ),
                                      SizedBox(width: 10.w),
                                      CustomText(
                                        text: "Typical Timeline",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:  AppColors.black,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20.h),
                                  CustomTimelineCard(
                                    color: const Color(0xFF2848D7),
                                    title: "Application Submission",
                                    subtitle: "Day 1",
                                    isLast: false,
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomTimelineCard(
                                    color: const Color(0xFFFFA000),
                                    title: "Initial Review",
                                    subtitle: "Week 1-2",
                                    isLast: false,
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomTimelineCard(
                                    color: const Color(0xFFB0BEC5),
                                    title: "Decision & Notification",
                                    subtitle: "Week 4-6",
                                    isLast: true,
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      }
                    }),
                    SizedBox(height: 20.h),
                    // back to dashboard
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Expanded(
                child: CustomButton(
                  onTap: () {
                    Get.toNamed(AppRoutes.userDashboard);
                  },
                  title: "Go to Dashboard",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white,
                  fillColor: AppColors.yellow1,
                ),
              ),
        ),
      ),
    );
  }
  // population and language card
  Widget _buildStatCard(IconData icon, String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF1A237E), size: 30.sp),
          SizedBox(height: 8.h),
          CustomText(
            text: value,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: label,
            fontSize: 12,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}