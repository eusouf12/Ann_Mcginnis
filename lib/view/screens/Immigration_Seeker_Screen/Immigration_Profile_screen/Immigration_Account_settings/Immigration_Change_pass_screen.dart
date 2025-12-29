import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class ImmigrationChangePassScreen extends StatelessWidget {
  const ImmigrationChangePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Change Password'.tr,
          color: AppColors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              CustomFormCard(
                title: 'Current Password',
                hintText: '******',
                curserColor: AppColors.black,
                titleColor: AppColors.black,
                isPassword: true,
                fillBorderRadius: 12,
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: 'New Password',
                hintText: '******',
                isPassword: true,
                curserColor: AppColors.black,
                titleColor: AppColors.black,
                fillBorderRadius: 12,
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: 'Confirm Password',
                hintText: '******',
                curserColor: AppColors.black,
                titleColor: AppColors.black,
                isPassword: true,
                fillBorderRadius: 12,
                controller: TextEditingController(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24,vertical: 30),
          child: CustomButton(
            onTap: () {},
            title: 'Update Password',
            fillColor: AppColors.primary1,
            textColor: AppColors.white,
            fontSize: 16,
            borderRadius: 10,
          ),
        ),
      ),
    );
  }
}
