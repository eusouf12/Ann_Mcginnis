import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_loader/custom_loader.dart';
import 'package:ann_mcginnis/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../service/api_url.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/recomended_countries_controller.dart';
import '../widget/custom_visa_card.dart';

class CountryDetailsScreen extends StatelessWidget {
  CountryDetailsScreen({super.key});

  IconData getVisaIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains("student")) return Icons.school_rounded;
    if (n.contains("work") ||
        n.contains("employment") ||
        n.contains("permit") ||
        n.contains("authorization") ||
        n.contains("worker")) return Icons.work_rounded;
    if (n.contains("business") ||
        n.contains("entre") ||
        n.contains("tech") ||
        n.contains("talent")) return Icons.business_center_rounded;
    if (n.contains("tourist") ||
        n.contains("visit") ||
        n.contains("visitor") ||
        n.contains("schengen")) return Icons.flight_rounded;
    if (n.contains("residence")) return Icons.home_rounded;
    if (n.contains("golden")) return Icons.workspace_premium_rounded;
    if (n.contains("skilled") || n.contains("professional"))
      return Icons.engineering_rounded;
    if (n.contains("digital nomad")) return Icons.laptop_mac_rounded;
    if (n.contains("blue card")) return Icons.credit_card_rounded;
    return Icons.public_rounded;
  }

  Color getVisaTagColor(String tag) {
    final t = tag.toLowerCase();
    if (t.contains("popular")) return const Color(0xFF4CAF50);
    if (t.contains("premium") || t.contains("gold")) return const Color(0xFFFEB506);
    if (t.contains("fast")) return const Color(0xFF2196F3);
    return AppColors.primary1;
  }

  final RecommendedCountriesController controller = Get.put(
    RecommendedCountriesController(),
  );
  final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final String countryName = args["country"];
    final String id = args["id"];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getSingleCountry(country: countryName);
      controller.getEligibleVisas(countrySlug: countryName);
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FC),
        body: Obx(() {
          if (controller.isSingleCountryLoading.value) {
            return const Center(child: CustomLoader());
          }

          final country = controller.singleCountry.value;
          if (country == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.public_off_rounded,
                      size: 64.sp, color: Colors.grey[300]),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: "No Country Data Found",
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    // ── HERO SECTION ──
                    _buildHero(country, countryName, id),

                    // ── BODY ──
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 100.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Action buttons
                          _buildActionButtons(id),
                          SizedBox(height: 24.h),

                          // Tab bar
                          _buildTabBar(),
                          SizedBox(height: 20.h),

                          // Tab content
                          Obx(() {
                            if (controller.selectedTab.value == 0) {
                              return _buildOverviewTab(country);
                            } else {
                              return _buildVisaTab();
                            }
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Dashboard button pinned at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: CustomButton(
                    onTap: () => Get.toNamed(AppRoutes.userDashboard),
                    title: "Go to Dashboard",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.white,
                    fillColor: AppColors.primary1,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ──────────────────────── HERO ──────────────────────────
  Widget _buildHero(dynamic country, String countryName, String id) {
    return SizedBox(
      height: 320.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          CustomNetworkImage(
            imageUrl: "${ApiUrl.imageUrl}${country.imageUrl}",
            height: 320.h,
            width: double.infinity,
          ),

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.25),
                  Colors.black.withOpacity(0.75),
                ],
              ),
            ),
          ),

          // Back button
          Positioned(
            top: 50.h,
            left: 16.w,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ),

          // Country name & description
          Positioned(
            bottom: 24.h,
            left: 20.w,
            right: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.yellow1,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on_rounded,
                              color: Colors.white, size: 12.sp),
                          SizedBox(width: 4.w),
                          CustomText(
                            text: "Destination",
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: country.name ?? "",
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 6.h),
                CustomText(
                  text: country.description ?? "",
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.85),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────── ACTION BUTTONS ────────────────────────
  Widget _buildActionButtons(String id) {
    return Row(
      children: [
        Expanded(
          child: _actionBtn(
            label: "Explore More",
            icon: Icons.explore_rounded,
            bgColor: const Color(0xFFF0F4FF),
            textColor: AppColors.primary1,
            iconColor: AppColors.primary1,
            onTap: () => Get.toNamed(AppRoutes.recommendedCountriesScreen),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: _actionBtn(
            label: "Save for Later",
            icon: Icons.bookmark_add_rounded,
            bgColor: AppColors.primary1,
            textColor: Colors.white,
            iconColor: Colors.white,
            onTap: () => controller.saveCountry(id: id),
          ),
        ),
      ],
    );
  }

  Widget _actionBtn({
    required String label,
    required IconData icon,
    required Color bgColor,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.r),
          border: bgColor == Colors.white
              ? Border.all(color: Colors.grey.withOpacity(0.2))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 18.sp),
            SizedBox(width: 8.w),
            CustomText(
              text: label,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────── TAB BAR ────────────────────────
  Widget _buildTabBar() {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: List.generate(controller.tabs.length, (index) {
            final bool isSelected = controller.selectedTab.value == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(vertical: 11.h),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              AppColors.primary1,
                              AppColors.primary,
                            ],
                          )
                        : null,
                    color: isSelected ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary1.withOpacity(0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index == 0
                            ? Icons.info_outline_rounded
                            : Icons.credit_card_rounded,
                        size: 16.sp,
                        color: isSelected ? Colors.white : Colors.grey,
                      ),
                      SizedBox(width: 6.w),
                      CustomText(
                        text: controller.tabs[index],
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ──────────────────────── OVERVIEW TAB ────────────────────────
  Widget _buildOverviewTab(dynamic country) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats row
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                Icons.groups_rounded,
                country.population ?? "—",
                "Population",
                const Color(0xFFE8EAF6),
                const Color(0xFF1A237E),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: _buildStatCard(
                Icons.translate_rounded,
                country.officialLanguages?.length.toString() ?? "—",
                "Languages",
                const Color(0xFFFFF3E0),
                const Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),

        // Why Choose section
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EAF6),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.star_rounded,
                        color: AppColors.primary1, size: 18.sp),
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    text: "Why Choose ${country.name}?",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ...(country.whyChoose ?? []).asMap().entries.map((e) {
                return _buildWhyChooseItem(e.value, e.key);
              }),
            ],
          ),
        ),

        // Official Languages chip list
        if ((country.officialLanguages ?? []).isNotEmpty) ...[
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(Icons.translate_rounded,
                          color: const Color(0xFFE65100), size: 18.sp),
                    ),
                    SizedBox(width: 10.w),
                    CustomText(
                      text: "Official Languages",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: (country.officialLanguages as List).map((lang) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 7.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4FF),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                            color: AppColors.primary1.withOpacity(0.2)),
                      ),
                      child: CustomText(
                        text: lang.toString(),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary1,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildWhyChooseItem(dynamic item, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: AppColors.primary1.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomText(
                text: "${index + 1}",
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary1,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: CustomText(
                text: item.toString(),
                fontSize: 14,
                color: const Color(0xFF546E7A),
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      IconData icon, String value, String label, Color bg, Color iconClr) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: bg.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: bg),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconClr, size: 22.sp),
          ),
          SizedBox(height: 10.h),
          CustomText(
            text: value,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: label,
            fontSize: 12,
            color: Colors.grey[500]!,
          ),
        ],
      ),
    );
  }

  // ──────────────────────── VISA TAB ────────────────────────
  Widget _buildVisaTab() {
    if (controller.isLoadingEligibleVisas.value) {
      return const Center(child: CustomLoader());
    }

    final visas =
        controller.eligibleVisasModel.value?.data?.visaTypes;
    if (visas == null || visas.isEmpty) {
      return Center(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Icon(Icons.credit_card_off_rounded,
                size: 64.sp, color: Colors.grey[300]),
            SizedBox(height: 16.h),
            CustomText(
              text: "No Visa Data Available",
              fontSize: 16,
              color: Colors.grey,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary info chip
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary1.withOpacity(0.08),
                AppColors.primary1.withOpacity(0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primary1.withOpacity(0.15)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline_rounded,
                  color: AppColors.primary1, size: 18.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomText(
                  text:
                      "${visas.length} visa type${visas.length > 1 ? 's' : ''} available. Tap to view full requirements.",
                  fontSize: 13,
                  color: AppColors.primary1,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        ...List.generate(visas.length, (index) {
          final visa = visas[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: CustomVisaCard(
              icon: getVisaIcon(visa.name ?? ""),
              title: visa.name ?? "",
              description: visa.description ?? "",
              duration: visa.duration ?? "",
              type: visa.tag ?? "",
              typeColor: const Color(0xFFE8EAF6),
              typeTextColor: AppColors.primary,
              onTap: () {
                Get.toNamed(
                  AppRoutes.visaTypeRequirement,
                  arguments: visa,
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
