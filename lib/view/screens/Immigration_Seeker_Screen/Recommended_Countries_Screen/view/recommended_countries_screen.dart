
import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
import 'package:ann_mcginnis/utils/app_icons/app_icons.dart';
import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:ann_mcginnis/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../widget/custom_contries_card.dart';
import 'filter_screen.dart';

final List<Map<String, String>> countryList = [
  {
    "name": "USA",
    "image": "https://blog.onevasco.com/wp-content/uploads/Reasons-to-Visit-USA.png",
  },
  {
    "name": "Canada",
    "image": "https://blog.onevasco.com/wp-content/uploads/country-image-Canada.jpg",
  },
  {
    "name": "UK",
    "image": "https://media.timeout.com/images/106178370/750/422/image.jpg",
  },
  {
    "name": "Australia",
    "image": "https://acko-cms.ackoassets.com/Islands_in_Australia_9762824303.png",
  },
];


class RecommendedCountriesScreen extends StatelessWidget {
  const RecommendedCountriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                // gridview countries
                Expanded(
                  child: GridView.builder(
                    itemCount: countryList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final country = countryList[index];
                      return CustomCountryCard(
                        onTap: (){
                          Get.toNamed(AppRoutes.countryDetailsScreen);
                        },
                        countryName: country['name'],
                        imagePath: country['image'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          //bottom
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                CustomText(text: "4 countries found",color: AppColors.black,),
                Spacer(),
               GestureDetector(
                 onTap: (){

                 },
                 child: Container(
                 padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                 decoration: BoxDecoration(
                  color: AppColors.primary1,
                  borderRadius: BorderRadius.circular(8),
                 ),
                   child: CustomText(text: "Load More",fontWeight: FontWeight.w500,color:AppColors.white),
                 ),
               )
              ],
            ),
          ),
        )
    );
  }
}
