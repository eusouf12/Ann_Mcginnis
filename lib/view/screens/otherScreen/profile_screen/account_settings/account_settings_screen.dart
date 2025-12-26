import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Account Settings',
          color: AppColors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.changePassScreen);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomText(
                        text: 'Change Password'.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_right, color: AppColors.white,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.termsServicesScreen);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomText(
                        text: 'Terms Of Services'.tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_right, color: AppColors.white,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.privacyScreen);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomText(
                        text: 'Privacy Policy',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_right, color: AppColors.white,),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.aboutScreen);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      CustomText(
                        text: 'About Us',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_right, color: AppColors.white,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
