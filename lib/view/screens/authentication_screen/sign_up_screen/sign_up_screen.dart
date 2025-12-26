import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../controller/auth_controller.dart';

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
                              // onTap: () => authController.toggleTab(true),
                              onTap: () {
                                authController.toggleTab(true);
                                Get.find<AuthController>().toggleTab(true);
                                Get.back();
                              },
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
                const SizedBox(height: 32),
                // middle container
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

                      CustomText(
                        text: "Full Name",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: authController.nameController.value,
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
                      //Email
                      CustomText(
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
                      CustomText(
                        text: AppStrings.password,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
                      // confirmPassword
                      CustomText(
                        text: AppStrings.changePassword,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 20),
                     //toggle btn verification
                     Row(
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             CustomText(
                               text: "Enable 2-Step Verification",
                               fontWeight: FontWeight.w500,
                               color: Colors.black,
                             ),
                             CustomText(
                               text: "Adds extra security to your account",
                               fontWeight: FontWeight.w400,
                               fontSize: 12,
                               color: Colors.grey,
                               top: 5,
                             ),

                           ],
                         ),
                         Spacer(),
                         Obx(() => Switch(
                             activeColor: Colors.white,
                             activeTrackColor: AppColors.primary,
                             inactiveThumbColor: Colors.white,
                             inactiveTrackColor: Colors.grey.shade300,
                           trackOutlineColor: MaterialStateProperty.resolveWith<Color>((states) {
                             return Colors.white;
                           }),
                           value: authController.isVerificationEnabled.value,
                           onChanged: (value) {
                             authController.toggleVerification(value);
                           },
                         )),
                       ],
                     )
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
                  fillColor: AppColors.primary1,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 30),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
