import 'package:ann_mcginnis/view/components/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../controller/user_profile_controller.dart';

class ImmigrationChangePassScreen extends StatelessWidget {
  ImmigrationChangePassScreen({super.key});
  final UserProfileController profileController = Get.put(
    UserProfileController(),
  );

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Change Password',
          color: AppColors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              CustomFormCard(
                title: 'Current Password',
                hintText: '******',
                curserColor: AppColors.black,
                titleColor: AppColors.black,
                isPassword: true,
                fillBorderRadius: 12,
                controller: profileController.oldPasswordController.value,
              ),
              CustomFormCard(
                title: 'New Password',
                hintText: '******',
                isPassword: true,
                curserColor: AppColors.black,
                titleColor: AppColors.black,
                fillBorderRadius: 12,
                controller: profileController.newPasswordController.value,
              ),
              CustomFormCard(
                title: 'Confirm Password',
                hintText: '******',
                curserColor: AppColors.black,
                titleColor: AppColors.black,
                isPassword: true,
                fillBorderRadius: 12,
                controller: profileController.confirmPasswordController.value,
              ),
              Spacer(),
              Obx(() {
                if (profileController.changePassLoading.value) {
                  return CustomLoader();
                }
                return CustomButton(
                  onTap: () {
                    profileController.changePassword();
                  },
                  title: "UPDATE PASSWORD",
                  textColor: AppColors.white,
                  fillColor: AppColors.primary,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
