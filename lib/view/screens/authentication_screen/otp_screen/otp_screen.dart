import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/ToastMsg/toast_message.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_pin_code/custom_pin_code.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text/custom_text.dart';
import '../controller/auth_controller.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final AuthController authController = Get.find<AuthController>();
  // final SignUpAuthModel userModel = Get.arguments as SignUpAuthModel;

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24,right: 24, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                //img
                Center(child: CustomImage(imageSrc: AppImages.logo1)),
                SizedBox(height: 50),
                // Title
                Center(
                  child: CustomText(
                    text: "VERIFY OTP",
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
                      text: "Enter the 4-digit code sent to your email or phone number.",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey_1,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Custom OTP
                CustomPinCode(
                  controller: authController.otpController.value,
                  // controller: otpController,
                ),
                 SizedBox(height: 15),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Resend code in 00:24",
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey_1,
                      ),
                    ],
                  ),
                ),
                 SizedBox(height: 30),
                // Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.setNewPassword);
                    },
                    borderRadius: 12,
                    textColor: AppColors.white,
                    fillColor: AppColors.primary,
                    title: "Verify",
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 15),
                //Resend
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Didn't receive the code? ",
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: CustomText(
                          text: " Resend",
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary1,
                          bottom: 30,
                        ),
                      ),
                    ],
                  ),
                ),
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

