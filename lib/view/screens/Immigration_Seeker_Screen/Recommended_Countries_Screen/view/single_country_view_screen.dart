import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/recomended_countries_controller.dart';
import '../widget/custom_choose_card.dart';

class CountryDetailsScreen extends StatelessWidget {
  CountryDetailsScreen({super.key});

  final RecommendedCountriesController controller = Get.put(RecommendedCountriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            // Get.to(BookFollow());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFA000),
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A237E), // Navy Blue
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
                            padding: EdgeInsets.only(bottom: 8.h, right: 20.w, left: 20.w),
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
                    if (controller.selectedTab.value == 0) {
                      /// Overview Tab
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

                          /// Population & Language
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
                    else if (controller.selectedTab.value == 1) {
                      return Center(child: Text("Visa Types Content"));
                    }
                    else if (controller.selectedTab.value == 2) {
                      return Center(child: Text("Requirements Content"));
                    }
                    else {
                      return Center(child: Text("Process Content"));
                    }
                  }),

                  SizedBox(height: 20,)
                ],
              ),
            ),
          ],
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