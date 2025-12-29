import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';

class ImmigrationAboutScreen extends StatelessWidget {
  const ImmigrationAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'About Us'.tr,
          color: AppColors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: CustomText(
            text: 'About Us Screen',
            fontSize: 16.w,
            fontWeight: FontWeight.w400,
            maxLines: 10,
            textAlign: TextAlign.justify,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
