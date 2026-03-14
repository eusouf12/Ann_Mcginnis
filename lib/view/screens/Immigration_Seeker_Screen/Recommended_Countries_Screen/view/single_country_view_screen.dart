import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_loader/custom_loader.dart';
import 'package:ann_mcginnis/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../service/api_url.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/recomended_countries_controller.dart';
import '../widget/custom_choose_card.dart';
import '../widget/custom_requirment_card.dart';
import '../widget/custom_timeline_card.dart';
import '../widget/custom_visa_card.dart';

class CountryDetailsScreen extends StatelessWidget {
  CountryDetailsScreen({super.key});

  final RecommendedCountriesController controller = Get.put(RecommendedCountriesController());
  final countryName = Get.arguments;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getSingleCountry(country: countryName);
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          if (controller.isSingleCountryLoading.value) {return  Center(child: CustomLoader(),);}

          final country = controller.singleCountry.value;
          if (country == null) {
            return const Center(child: Text("No Country Data Found"),);
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                //header
                Stack(
                  children: [
                    CustomNetworkImage(imageUrl: "${ApiUrl.baseUrl}${country.imageUrl}", height: 300, width: double.infinity,),
                    Container(
                      height: 280.h,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.3),
                    ),

                    Positioned(
                      top: -30.h,
                      left: 0,
                      right: 20.w,
                      child: CustomRoyelAppbar(
                        leftIcon: true,
                        titleName: "Country Details",
                        leftIconColor: Colors.white,
                        color: Colors.white,
                      ),
                    ),
                   //name and description
                    Positioned(
                      bottom: 40.h,
                      left: 20.w,
                      right: 20.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: country.name ??"",
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            text: country.description ?? "",
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                            textAlign: TextAlign.start,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // body
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // two btn
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(
                                    AppRoutes.recommendedCountriesScreen);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.yellow1,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.r)),
                                padding:
                                EdgeInsets.symmetric(vertical: 12.h),
                              ),
                              child: const CustomText(
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
                                backgroundColor: AppColors.primary1,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.r)),
                                padding:
                                EdgeInsets.symmetric(vertical: 12.h),
                              ),
                              child: const CustomText(
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

                      //why Choose
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
                              text: "Why Choose ${country.name}?",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary1,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 10.h),

                            ListView.builder(
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              itemCount: country.whyChoose?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                  EdgeInsets.only(bottom: 8.h),
                                  child: CustomChooseCard(title: country.whyChoose?[index],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // population + language
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              Icons.groups,
                              country.population ?? "0",
                              "Population",
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: _buildStatCard(
                              Icons.language,
                              country.officialLanguages?.length.toString() ?? "0",
                              "Official Languages",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
    );
  }

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