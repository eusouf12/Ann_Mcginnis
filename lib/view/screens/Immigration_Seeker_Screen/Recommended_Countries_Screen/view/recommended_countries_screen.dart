
import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
import 'package:ann_mcginnis/service/api_url.dart';
import 'package:ann_mcginnis/utils/app_icons/app_icons.dart';
import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:ann_mcginnis/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../controller/recomended_countries_controller.dart';
import '../widget/custom_contries_card.dart';
import 'filter_screen.dart';

class RecommendedCountriesScreen extends StatelessWidget {
  RecommendedCountriesScreen({super.key});
  final RecommendedCountriesController controller = Get.put(RecommendedCountriesController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getRecommendedCountries();
    });
    return CustomGradient(
        child: Scaffold(
          appBar: CustomRoyelAppbar(rightIcon: AppIcons.filter,titleName: "Recommended Countries",centerTitleEnable: false,
            rightOnTap: (){Get.to(FilterScreen());},
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: Column(
              children: [
                // Search bar
                CustomTextField(
                  hintText: 'Search countries...',
                  hintStyle: TextStyle(color: AppColors.grey_1),
                  fieldBorderRadius: 15,
                  fieldBorderColor: AppColors.grey_1,
                  fillColor: AppColors.white,
                  prefixIcon: Icon(Icons.search, color: AppColors.grey_1),
                  textEditingController: TextEditingController(),
                  // textEditingController: searchController,
                  inputTextStyle: TextStyle(color: AppColors.black),
                  onFieldSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                    //   dmHomeController.filterAllNearbyMap(filter: "searchTerm=${value.trim()}");
                    }
                    // searchController.clear();
                  },
                ),
                SizedBox(height: 25.h),
                // gridview countries
                Expanded(
                  child: Obx(() {
                    if (controller.rxRecommendedStatus.value == Status.loading && controller.recommendedCountries.isEmpty) {
                      return const Center(child: CustomLoader());
                    }

                    if (controller.recommendedCountries.isEmpty) {
                      return const Center(child: CustomText(text: "No countries found", fontSize: 16,),);
                    }

                    return NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (!controller.isRecommendedLoadMore.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && controller.recommendedCurrentPage < controller.recommendedTotalPages) {
                          controller.getRecommendedCountries(loadMore: true);
                        }
                        return true;
                      },

                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: controller.recommendedCountries.length + (controller.isRecommendedLoadMore.value ? 1 : 0),

                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.90,
                        ),

                        itemBuilder: (context, index) {
                          if (index == controller.recommendedCountries.length) {
                            return const Center(child: CustomLoader());
                          }

                          final country = controller.recommendedCountries[index];

                          return CustomCountryCard(
                            onTap: () {
                              Get.toNamed(AppRoutes.countryDetailsScreen, arguments: {"country": country.country, "id": country.id});
                            },
                            countryName: country.country ?? "",
                            imagePath: ApiUrl.imageUrl+"${country.imageUrl}",
                            matchPercentage: country.score,
                          );
                        },
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
          //bottom
          // bottomNavigationBar: Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          //   decoration: BoxDecoration(
          //     color: AppColors.white,
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.04),
          //         blurRadius: 10,
          //         offset: const Offset(0, -4),
          //       ),
          //     ],
          //   ),
          //   child: Row(
          //     children: [
          //       CustomText(text: "4 countries found",color: AppColors.black,),
          //       Spacer(),
          //      GestureDetector(
          //        onTap: (){
          //
          //        },
          //        child: Container(
          //        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
          //        decoration: BoxDecoration(
          //         color: AppColors.primary1,
          //         borderRadius: BorderRadius.circular(8),
          //        ),
          //          child: CustomText(text: "Load More",fontWeight: FontWeight.w500,color:AppColors.white),
          //        ),
          //      )
          //     ],
          //   ),
          // ),
        )
    );
  }
}
