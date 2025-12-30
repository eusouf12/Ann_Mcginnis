import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/app_routes/app_routes.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/local_storage/local_storage.dart';
import '../../components/custom_text/custom_text.dart';
import '../authentication_screen/controller/auth_controller.dart';
import 'custom_card_role.dart';

class ChooseRole extends StatelessWidget {
  final authController = Get.put(AuthController());
  ChooseRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              Center(child: CustomText(
                  text: "Choose Your Role",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary1,
                ),),
              SizedBox(height: 12),
              Center(
                child: CustomText(
                  text: "Select your role to get started with tailored services.",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 150),
              Expanded(
                child: ListView(
                  children: [
                    RoleCard(
                      icon: Icons.language,
                      title: "Join as Immigration Seeker",
                      description: "Icon of a person with a suitcase or globe.",
                      onTap: () {
                         StorageService().write("role", "Immigration Seeker");
                         final role = StorageService().read<String>("role");
                         debugPrint("Chose Role Immigration Seeker========================================${role}");
                         Get.toNamed(AppRoutes.setUpProfileScreen);
                         // Get.toNamed(AppRoutes.signUpScreen);
                      },
                    ),
                    const SizedBox(height: 16),
                    RoleCard(
                      icon: Icons.business_center,
                      title: "Join as Consultant",
                      description: "Icon of a briefcase or business attire.",
                      onTap: () {
                        StorageService().write("role", "Consultant");
                        final role = StorageService().read<String>("role");
                        debugPrint("Chose Role Immigration Seeker========================================${role}");
                        Get.toNamed(AppRoutes.consultantDashboard);
                        // Get.toNamed(AppRoutes.signUpScreen);
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Already have an account ?  ',

                    fontSize: 16.w,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black_02,
                  ),
                  GestureDetector(
                    onTap: () {
                      authController.loginLoading.value = true;
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: CustomText(
                      text: 'Log in',
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}