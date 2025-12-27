import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../controller/auth_controller.dart';
import '../login_screen/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24 , top: 50,  bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                //img
                Center(child: CustomImage(imageSrc: AppImages.logo1)),
                SizedBox(height: 30),
                Obx(() =>
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              // onTap: () => authController.toggleTab(true),
                              onTap: () {
                                authController.toggleTab(true);
                                Get.to(() => LoginScreen());
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: authController.loginLoading.value ? AppColors.primary : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow:authController.loginLoading.value
                                      ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                      : null,
                                ),
                                child: Center(
                                  child: CustomText(
                                    text: "Sign In",
                                    fontWeight: FontWeight.w500,
                                    color: authController.loginLoading.value
                                        ? AppColors.white
                                        : AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // create Account
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                authController.toggleTab(true);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: !authController.loginLoading.value ? AppColors.primary : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: !authController.loginLoading.value
                                      ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                      : null,
                                ),
                                child: Center(
                                  child: CustomText(
                                    text: "Create Account",
                                    fontWeight: FontWeight.w500,
                                    color:  !authController.loginLoading.value
                                        ? AppColors.white
                                        : AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
                const SizedBox(height: 30),
                // middle container
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Full Name",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: authController.nameController.value,
                        hintText: "Enter your name",
                        hintStyle: TextStyle(color: AppColors.grey_1, fontSize: 14),
                        prefixIcon: const Icon(
                          Icons.person_outlined,
                          color: Color(0xFF9CA3AF),
                          size: 20,),
                        fillColor: AppColors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12,
                        keyboardType: TextInputType.emailAddress,

                      ),
                      SizedBox(height: 10),
                      //Email
                      CustomText(
                        text: AppStrings.email,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: authController.emailController.value,
                        hintText: AppStrings.enterYourEmail,
                        hintStyle: TextStyle(color: AppColors.grey_1, fontSize: 14),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Color(0xFF9CA3AF),
                          size: 20,),
                        fillColor: AppColors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12,
                        keyboardType: TextInputType.emailAddress,

                      ),
                       SizedBox(height: 10),
                      // Password Field
                      CustomText(
                        text: AppStrings.password,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: authController.passwordController.value,
                        hintText: "Create a strong password",
                        hintStyle: TextStyle(
                            color: AppColors.grey_1,
                            fontSize: 14
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF9CA3AF),
                          size: 22,
                        ),
                        isPassword: true,
                        fillColor: AppColors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12,
                      ),
                      SizedBox(height: 10),
                      // confirmPassword
                      CustomText(
                        text: AppStrings.changePassword,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController:  authController.confirmPasswordController.value,
                        hintText: "Retype password",
                        hintStyle: TextStyle(
                            color: AppColors.grey_1,
                            fontSize: 14
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF9CA3AF),
                          size: 22,
                        ),
                        isPassword: true,
                        fillColor: AppColors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                //  Create Account Button
                CustomButton(
                  onTap: () {
                    Get.toNamed(AppRoutes.accountReadyScreen);
                  },
                  borderRadius: 12,
                  textColor: AppColors.white,
                  title: "Create Account",
                  fillColor: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 30),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    CustomText(text: "By continuing, you agree to ICEWAIT's",color: Colors.black),
                    GestureDetector(
                        onTap: (){},
                        child: CustomText(text: " Terms ", color: AppColors.primary1)
                    ),
                    CustomText(text: "and ",color: Colors.black),
                    GestureDetector(
                        onTap: (){},
                        child: CustomText(text: "Privacy Policy",color:AppColors.primary1)
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
