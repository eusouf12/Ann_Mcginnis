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
  IconData getVisaIcon(String name) {

    final n = name.toLowerCase();

    if (n.contains("student")) {
      return Icons.school;
    }

    if (n.contains("work") ||
        n.contains("employment") ||
        n.contains("permit") ||
        n.contains("authorization") ||
        n.contains("worker")) {
      return Icons.work;
    }

    if (n.contains("business") ||
        n.contains("entre") ||
        n.contains("tech") ||
        n.contains("talent")) {
      return Icons.business_center;
    }

    if (n.contains("tourist") ||
        n.contains("visit") ||
        n.contains("visitor") ||
        n.contains("schengen")) {
      return Icons.flight;
    }

    if (n.contains("residence")) {
      return Icons.home;
    }

    if (n.contains("golden")) {
      return Icons.workspace_premium;
    }

    if (n.contains("skilled") ||
        n.contains("professional")) {
      return Icons.engineering;
    }

    if (n.contains("digital nomad")) {
      return Icons.laptop_mac;
    }

    if (n.contains("blue card")) {
      return Icons.credit_card;
    }

    return Icons.public; // fallback
  }

  final RecommendedCountriesController controller = Get.put(RecommendedCountriesController());
  final countryName = Get.arguments;

  @override
  Widget build(BuildContext context) {
    debugPrint("Country Name: $countryName");
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
                    CustomNetworkImage(imageUrl: "${ApiUrl.imageUrl}${country.imageUrl}", height: 300, width: double.infinity,),
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
                      // TAB BAR
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(
                              () => Row(
                            children: List.generate(controller.tabs.length, (index) {
                              bool isSelected = controller.selectedTab.value == index;

                              return GestureDetector(
                                onTap: () => controller.changeTab(index),
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom: 8.h,
                                    right: 10.w,
                                    left: 10.w,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: isSelected
                                            ? const Color(0xFF2848D7)
                                            : Colors.transparent,
                                        width: 3.h,
                                      ),
                                    ),
                                  ),
                                  child: CustomText(
                                    text: controller.tabs[index],
                                    fontSize: 14,
                                    fontWeight:
                                    isSelected ? FontWeight.bold : FontWeight.w500,
                                    color: isSelected
                                        ? const Color(0xFF2848D7)
                                        : Colors.grey,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),
                      Obx(() {

                        // TAB 0
                        if (controller.selectedTab.value == 0) {
                          return Column(
                            children: [
                              //why Choose
                              Container(
                                padding: EdgeInsets.all(14.r),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE5E7EB).withOpacity(0.3),
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
                                    SizedBox(height: 16.h),
                                    ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: country.whyChoose?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 8.h),
                                          child: CustomChooseCard(
                                            title: country.whyChoose?[index],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 20.h),

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
                          );
                        }
                        // TAB 1 → VISA
                        else if (controller.selectedTab.value == 1) {
                          return Column(
                            children: List.generate(
                              country.visaTypes?.length ?? 0, (index) {
                                final visa = country.visaTypes![index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 15.h),
                                  child: CustomVisaCard(
                                    icon: getVisaIcon(visa.name ?? ""),
                                    title: visa.name ?? "",
                                    description: visa.description ?? "",
                                    duration: visa.duration ?? "",
                                    type: visa.tag ?? "",
                                    typeColor: Color(0xFFE8EAF6),
                                    typeTextColor: AppColors.primary,
                                    // onTap: () {},
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        // TAB 2 → REQUIREMENTS
                        else if (controller.selectedTab.value == 2) {
                          return Column(
                            children: [

                              ...List.generate(
                                country.requirements?.length ?? 0,
                                    (index) {

                                  final req = country.requirements![index];

                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: CustomRequirementCard(
                                      title: req.name ?? "",
                                      description: req.description ?? "",
                                      isMandatory: req.isMandatory ?? false,
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: 20.h),

                              importantNoticeCard(),

                            ],
                          );
                        }
                        // TAB 3 → PROCESSING
                        else {
                          return Column(
                            children: [
                              //"Processing Time",
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
                                          text: " ${country.processingTime ?? ""}",
                                          fontSize: 20.sp,
                                          color: AppColors.yellow1,
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
                                      text: country.processingInfo ?? "",
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
                                    Column(
                                      children: List.generate(
                                        country.delayFactors?.length ?? 0,
                                            (index) {

                                          final delay = country.delayFactors![index];

                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 10.h),
                                            child: Row(
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
                                                          text: "${delay.title} ",
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            color: AppColors.yellow1,
                                                          ),
                                                        ),

                                                        TextSpan(
                                                          text: "- ${delay.description}",
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
                                          );
                                        },
                                      ),
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
                                    Column(
                                      children: List.generate(
                                        country.timeline?.length ?? 0,
                                            (index) {

                                          final step = country.timeline![index];

                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 10.h),
                                            child: CustomTimelineCard(
                                              color: index == 0
                                                  ? const Color(0xFF2848D7)
                                                  : index == 1
                                                  ? const Color(0xFFFFA000)
                                                  : const Color(0xFFB0BEC5),

                                              title: step.stage ?? "",
                                              subtitle: step.duration ?? "",
                                              isLast: index == (country.timeline!.length - 1),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        }

                       }),
                     SizedBox(height: 20.h),
                    ]
                  ),
                )
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
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
  Widget importantNoticeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border(
          left: BorderSide(
            color: const Color(0xFF2848D7),
            width: 4.w,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            children: [
              Icon(
                Icons.info,
                color: const Color(0xFF2848D7),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),

              CustomText(
                text: "Important Notice",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2848D7),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Description
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF546E7A),
                fontFamily: "Inter",
              ),
              children: [
                const TextSpan(
                  text: "Requirements marked with ",
                ),

                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16.sp,
                    ),
                  ),
                ),

                const TextSpan(
                  text: " mandatory and must be submitted with your application.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}