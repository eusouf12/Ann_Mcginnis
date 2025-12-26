
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24,top:50,  bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //upper text
                 Center(
                  child: Column(
                    children: [
                      CustomText(
                        text: "ICE VERIFY",
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                      CustomText(
                        text: "DIGITAL ID WALLET",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white_1,
                        bottom: 30,
                      ),
                    ],
                  ),
                ),
                // toggle btn
                 Obx(() =>
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => authController.toggleTab(true),
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: authController.loginLoading.value ? AppColors.primary : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
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
                                authController.toggleTab(false);
                                 Get.toNamed(AppRoutes.signUpScreen);
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
                const SizedBox(height: 32),
                //  Email &  Password Field
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Email
                      const CustomText(
                        text: AppStrings.email,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 20),
                      // Password Field
                      const CustomText(
                        text: AppStrings.password,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: authController.passwordController.value,
                        hintText: AppStrings.enterYourPassword,
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
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                //  Login Button
                CustomButton(
                  onTap: () {
                    Get.toNamed(AppRoutes.subscribeScreen);
                  },
                  borderRadius: 12,
                  textColor: AppColors.white,
                  title: "Continue",
                  fillColor: AppColors.primary1,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 50),
                // Forgot Password
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.forgotScreen);
                    },
                    child:  CustomText(
                      text: AppStrings.forgetPassword,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFDD835),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Social Buttons
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                 children: [
                   CustomText(text: "By continuing, you agree to ICEWAIT's"),
                   GestureDetector(
                     onTap: (){},
                       child: CustomText(text: " Terms ", color: Color(0xFFFDD835),)
                   ),
                   CustomText(text: "and "),
                   GestureDetector(
                       onTap: (){},
                       child: CustomText(text: "Privacy Policy",color: Color(0xFFFDD835),)
                   ),
                 ],
               )
              ],
            ),
          ),
        ),
      )

    );
  }
}
