import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../utils/ToastMsg/toast_message.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../controller/auth_controller.dart';

class SetNewPassword extends StatelessWidget {
  SetNewPassword({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {

    // final size = MediaQuery.sizeOf(context);
    return CustomGradient(
      child: Scaffold(
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24,right: 24, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                //img
                Center(child: CustomImage(imageSrc: AppImages.logo1)),
                SizedBox(height: 60),

                // Title
                Center(
                  child: CustomText(
                    text: "SET A NEW PASSWORD",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    bottom: 10,
                    color: AppColors.black,
                  ),
                ),

                // Description
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    child: CustomText(
                      text: "Password  must have 6-8 characters.",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey_1,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                ),
                SizedBox(height: 30),


                // New Password
                CustomText(
                  text: "New Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  textEditingController: authController.updatePasswordController.value,
                  hintText: "Enter password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF9CA3AF), size: 22),
                  isPassword: true,
                  fillColor: AppColors.white,
                  fieldBorderColor: const Color(0xFFE5E7EB),
                  fieldBorderRadius: 12,
                ),

                SizedBox(height: 20),
                // Confirm New Password
                CustomText(
                  text:"Confirm New Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                 SizedBox(height: 8),
                CustomTextField(
                  textEditingController: authController.updateConfirmPasswordController.value,
                  hintText: "Enter Confirm password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF9CA3AF), size: 22),
                  isPassword: true,
                  fillColor: AppColors.white,
                  fieldBorderColor: const Color(0xFFE5E7EB),
                  fieldBorderRadius: 12,
                ),
                SizedBox(height: 25),

                // Update Password Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    borderRadius: 12,
                    textColor: AppColors.white,
                    title: "Update Password",
                    fillColor: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(height: 15),

                // Back to Login
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: const CustomText(
                        text: "Back to Login",
                        fontWeight: FontWeight.w500,
                      color: AppColors.primary1,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

      ),
    );
  }
}
