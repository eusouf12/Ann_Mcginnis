import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/ToastMsg/toast_message.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../controller/auth_controller.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final SignUpAuthModel? userModel = Get.arguments as SignUpAuthModel?;

  @override
  Widget build(BuildContext context) {

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24,right: 24,top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  //img
                  Center(child: CustomImage(imageSrc: AppImages.logo1)),
                  const SizedBox(height: 50),
      
                  // Title
                  Center(
                    child: CustomText(
                      text: "Forget Password",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      bottom: 10,
                      color: AppColors.black
                    ),
                  ),
      
                  // Description
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 45),
                      child: CustomText(
                        text: "Enter your registered email we'll send you a link to reset your password.",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey_1,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
      
                  // Email
                   CustomText(
                    text: "Email",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                   SizedBox(height: 8),
                  CustomTextField(
                    textEditingController: authController.nameController.value,
                    hintText: AppStrings.enterYourEmail,
                    hintStyle: TextStyle(color: AppColors.grey_1, fontSize: 14),
                    prefixIcon: const Icon(Icons.email, color: Colors.grey, size: 20),
                    fillColor: AppColors.white,
                    fieldBorderColor: AppColors.grey_1,
                    fieldBorderRadius: 12,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 25),
                  // Send Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(AppRoutes.otpScreen);
                      },
                      borderRadius: 12,
                      textColor: AppColors.white,
                      fillColor: AppColors.primary,
                      title: "Request OTP",
                      fontSize: 16,
                    ),
                  ),
      
                  const SizedBox(height: 30),
      
                  // Back to Login
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const CustomText(
                        text: "Back to Login",
                        fontWeight: FontWeight.w500,
                          color: AppColors.primary1
                      ),
                    ),
                  ),
      
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


