import 'package:ann_mcginnis/view/screens/authentication_screen/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';

class LegalAdviceScreen extends StatelessWidget {
  LegalAdviceScreen({super.key});
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        authController.loginLoading.value = true;
        Get.offNamed(AppRoutes.recommendedCountriesScreen);
      });
    });
    return CustomGradient(
        child: Scaffold(
          backgroundColor: Color(0xffEFF6FF),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      AppImages.advice,
                      height: 250.h,
                      width: 320.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
