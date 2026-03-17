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
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../Booking_Flow_Screen/view/consult_book_screen.dart';
import '../../Immigration_Profile_screen/controller/user_profile_controller.dart';
import '../../Recommended_Countries_Screen/controller/recomended_countries_controller.dart';
import '../../Recommended_Countries_Screen/widget/custom_country_progress_card.dart';
import '../../SetUp_Profile_Screen/views/financial_info_screen_6.dart';
import '../../SetUp_Profile_Screen/views/set_up_profile_screen_1.dart';
import '../widget/book_consultation_card.dart';
import '../widget/custom_payment_card.dart';
import '../../SetUp_Profile_Screen/model/custom_save_countries.dart';

class UserDashboard extends StatelessWidget {
  UserDashboard({super.key});
  final UserDashboardController userDashboardController = Get.put(UserDashboardController());
  final UserProfileController userProfileController = Get.put(UserProfileController(),);
  final RecommendedCountriesController controller = Get.put(RecommendedCountriesController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProfileController.getUserProfile();
       userDashboardController.getConsultants();
       userDashboardController.getBookedConsultants(loadMore: false);
       userDashboardController.getSaveCountry(loadMore: false);
    });
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              CustomImage(imageSrc: AppImages.logoApp, height: 28.h, width: 28.w,),
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none,
                      color: const Color(0xFF0D1B2A),
                      size: 26.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  // Red Badge
                  // Positioned(
                  //   right: -2,
                  //   top: -2,
                  //   child: Container(
                  //     padding: EdgeInsets.all(3.w),
                  //     decoration: const BoxDecoration(
                  //       color: Colors.red,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     constraints: BoxConstraints(
                  //       minWidth: 16.w,
                  //       minHeight: 16.w,
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         "2",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 10.sp,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            SizedBox(width: 15.w),
            // 4. Profile Image
            Obx(() {
              final user = userProfileController.userData.value;

              String imageUrl = (user?.avatar != null && user!.avatar!.isNotEmpty)? ApiUrl.imageUrl + user.avatar! : AppConstants.profileImage2;

              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.userProfileScreen);
                },
                child: ClipOval(
                  child: CustomNetworkImage(
                    imageUrl: imageUrl,
                    height: 50.h,
                    width: 50.h,
                    boxShape: BoxShape.circle,
                  ),
                ),
              );
            }),
            SizedBox(width: 20.w),
          ],
        ),

        body: Obx(() {
          final user = userProfileController.userData.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  text: "Welcome, ${user?.fullname}",
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
                    padding: EdgeInsets.only(top: 20.h, left: 10.h, right: 10.h),
                    decoration: BoxDecoration(color: AppColors.primary1),
                    child: Row(
                      children: List.generate(userDashboardController.tabs.length, (index) {
                        bool isSelected = userDashboardController.selectedDashboardTab.value == index;
                        return GestureDetector(
                          onTap: () => userDashboardController.changeTab(index),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 20.h, right: 10.w, left: 10.w,),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: isSelected
                                      ? AppColors.yellow1
                                      : Colors.transparent,
                                  width: 4.h,
                                ),
                              ),
                            ),
                            child: CustomText(
                              text: userDashboardController.tabs[index],
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10,),
                  child: Obx(() {
                    // TAB - 00
                    if (userDashboardController.selectedDashboardTab.value == 0)      {
                      //Eligibility Results
                      return Obx(() {
                        if (controller.rxRecommendedStatus.value == Status.loading && controller.recommendedCountries.isEmpty) {
                          return const Center(child: CustomLoader());
                        }

                        if (controller.recommendedCountries.isEmpty) {
                          return const Center(child: CustomText(text: "No countries found", fontSize: 16));
                        }
                        final topCountry = controller.recommendedCountries.first;
                        final otherCountries = controller.recommendedCountries.skip(1).toList();
                        debugPrint("Full Image Path 2222: ${ApiUrl.imageUrl}${topCountry.flagUrl}");

                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (!controller.isRecommendedLoadMore.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && controller.recommendedCurrentPage < controller.recommendedTotalPages) {
                              controller.getRecommendedCountries(loadMore: true);
                            }
                            return true;
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: "Eligibility Results", fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary1),
                                SizedBox(height: 20.h),

                                // --- TOP MATCH CARD ---
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primary1, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFFDBEAFE),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            //flag
                                            CustomNetworkImage(imageUrl: "${ApiUrl.imageUrl}${topCountry.flagUrl}", height: 20, width: 40),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(text: topCountry.country ?? "Unknown", fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primary1),
                                                  CustomText(text:  "Top Match", fontSize: 14, color: AppColors.black),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: AppColors.yellow1,
                                              ),
                                              child: CustomText(text: "${topCountry.score}%", fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        // Progress Bar for Top Country text
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const CustomText(text: "Eligibility Score", fontSize: 14,color: AppColors.black,fontWeight: FontWeight.w600),
                                            CustomText(text: "${topCountry.score}/100", fontSize: 14,color: AppColors.black,fontWeight: FontWeight.w600),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        // Progress Bar
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: LinearProgressIndicator(value: (topCountry.score ?? 0) / 100,
                                            minHeight: 12, backgroundColor: AppColors.grey_1, color: AppColors.primary1,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        CustomButton(
                                            onTap: () {
                                              Get.toNamed(AppRoutes.countryDetailsScreen, arguments: {"country": topCountry.country, "id": topCountry.id});
                                            },
                                            title: "View Details"
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                CustomText(text: "Other Recommendations", fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary1),
                                const SizedBox(height: 20),

                                // --- OTHER RECOMMENDATIONS LIST ---
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: otherCountries.length,
                                  itemBuilder: (context, index) {
                                    final country = otherCountries[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: CustomCountryProgressCar(
                                        valueScore: "${country.score}",
                                        title: country.country ?? "",
                                        subTitle: country.label ?? "Recommendation",
                                        img: country.flagUrl ?? "",
                                      ),
                                    );
                                  },
                                ),


                                if (controller.isRecommendedLoadMore.value)
                                  const Padding(padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(child: CustomLoader()),
                                  ),
                              ],
                            ),
                          ),
                        );
                      });
                    }
                    // TAB - 01
                    else if (userDashboardController.selectedDashboardTab.value == 1) {
                      return Obx(() {

                        if (userDashboardController.isConsultantLoading.value &&
                            userDashboardController.consultantList.isEmpty) {
                          return const Center(child: CustomLoader());
                        }

                        if (userDashboardController.consultantList.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: CustomText(
                                text: "No consultants found",
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {

                            if (!userDashboardController.isConsultantLoadMore.value &&
                                scrollInfo.metrics.pixels >=
                                    scrollInfo.metrics.maxScrollExtent - 200 &&
                                userDashboardController.consultantCurrentPage <
                                    userDashboardController.consultantTotalPages) {

                              userDashboardController.getConsultants(loadMore: true);
                            }

                            return false;
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                CustomText(
                                  text: "Booked Consultations",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary1,
                                ),

                                SizedBox(height: 20.h),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: userDashboardController.consultantList.length,
                                  itemBuilder: (context, index) {

                                    final consultant =
                                    userDashboardController.consultantList[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: BookConsultationCard(
                                        title: consultant.userId?.fullname ?? "",
                                        subTitle: consultant.businessName ?? "",
                                        img: (consultant.userId?.avatar != null &&
                                            consultant.userId!.avatar!.isNotEmpty)
                                            ? "${ApiUrl.imageUrl}${consultant.userId?.avatar}"
                                            : AppConstants.profileImage,

                                        isBooked: false,

                                        onTapViewDetails: () {
                                          Get.toNamed(
                                            AppRoutes.consultProfileViewDetails,
                                            arguments: consultant.id,
                                          );
                                        },

                                        onTapBookNow: () {
                                          Get.to(ConsultBookScreen());
                                        },
                                      ),
                                    );
                                  },
                                ),

                                if (userDashboardController.isConsultantLoadMore.value)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(child: CustomLoader()),
                                  ),

                                SizedBox(height: 20.h),

                              ],
                            ),
                          ),
                        );
                      });
                    }
                    // TAB - 02
                    else if (userDashboardController.selectedDashboardTab.value == 2) {
                      return Obx(() {

                        if (userDashboardController.rxBookedStatus.value == Status.loading && userDashboardController.bookedConsultants.isEmpty) {
                          return const Center(child: CustomLoader());
                        }

                        if (userDashboardController.bookedConsultants.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: CustomText(
                                text: "No bookings found",
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {

                            if (!userDashboardController.isBookedLoadMore.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && userDashboardController.bookedCurrentPage < userDashboardController.bookedTotalPages) {
                              userDashboardController.getBookedConsultants(loadMore: true);
                            }

                            return true;
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: "Booked Consultations", fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary1,),
                                SizedBox(height: 20.h),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: userDashboardController.bookedConsultants.length,
                                  itemBuilder: (context, index) {
                                    final booking = userDashboardController.bookedConsultants[index];
                                    final consultant = booking.consultantId;
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: BookConsultationCard(
                                        title: consultant?.userId?.fullname ?? "",
                                        subTitle: consultant?.businessName ?? "",
                                        img: (consultant?.userId?.avatar != null && consultant!.userId!.avatar!.isNotEmpty) ? "${ApiUrl.imageUrl}${consultant.userId?.avatar}" : AppConstants.profileImage,
                                        isBooked: true,
                                        onTapViewDetails: () {
                                          Get.toNamed(
                                            AppRoutes.consultProfileViewDetails,
                                            arguments: consultant?.id,
                                          );
                                        },
                                        onTapBookNow: () {
                                          Get.to(ConsultBookScreen());
                                        },
                                      ),
                                    );
                                  },
                                ),

                                if (userDashboardController.isBookedLoadMore.value)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(child: CustomLoader()),
                                  ),

                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        );
                      });
                    }
                    // TAB - 03
                    else if (userDashboardController.selectedDashboardTab.value == 3) {
                      return Obx(() {

                        if (userDashboardController.rxSavedCountryStatus.value == Status.loading && userDashboardController.savedCountryList.isEmpty) {
                          return const Center(child: CustomLoader());
                        }

                        if (userDashboardController.savedCountryList.isEmpty) {
                          return const Center(
                            child: Padding(padding: EdgeInsets.only(top: 50),
                              child: CustomText(text: "No saved countries found", fontSize: 16,),
                            ),
                          );
                        }

                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {

                            if (!userDashboardController.isSavedCountryLoadMore.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && userDashboardController.savedCountryCurrentPage < userDashboardController.savedCountryTotalPages) {
                              userDashboardController.getSaveCountry(loadMore: true);
                            }

                            return true;
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: "Saved Countries", fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary1,),
                                SizedBox(height: 10.h),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: userDashboardController.savedCountryList.length,
                                  itemBuilder: (context, index) {
                                    final country = userDashboardController.savedCountryList[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: CountryVisaCard(
                                        title: country.country ?? "",
                                        img: country.imageUrl != null ? "${ApiUrl.imageUrl}${country.flagUrl}" : "",
                                        subTitle: country.label ?? "",
                                        description: "${country.visaTypes?.length ?? 0} visa options available",
                                        matchPercent: "${country.score ?? 0}",
                                        tagText: country.fastTrack == true ? "Fast Track" : (country.englishSpeaking == true ? "English Friendly" : "Standard"),

                                        onFavoriteTap: () {
                                          userDashboardController.deleteSaveCountry(id: country.id ?? "",);
                                        },
                                      ),
                                    );
                                  },
                                ),

                                if (userDashboardController.isSavedCountryLoadMore.value)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(child: CustomLoader()),
                                  ),

                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        );
                      });
                    }
                    //TAB-04
                    else {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() =>  SetUpProfileScreen1());
                            },
                            child: const Icon(Icons.add),
                          ),

                          CustomText(
                            text: "Payments", //PaymentCard
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
                                child: PaymentCard(
                                  subTitle: "Visa Consultant - Australia",
                                  title: 'Document Review',
                                  date: 'Dec 24, 2025',
                                  price: '150',
                                  isPaid: index == 1 ? true : false,
                                  onTap: () {},
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
                              border: Border.all(
                                color: const Color(0xFFC8E6C9),
                                width: 1.w,
                              ),
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
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ),
            ],
          );
          }),
    ));
  }
}
