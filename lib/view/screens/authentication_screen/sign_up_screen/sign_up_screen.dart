import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final authController = Get.put(AuthController());
  final role = Get.arguments;
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
                SizedBox(height: 10),
                //img
                Center(child: CustomImage(imageSrc: AppImages.logo1)),
                SizedBox(height: 30),
                CustomButton(onTap: (){},
                  title: "Sing Up",
                  fillColor: AppColors.primary,
                  textColor: Colors.white,
                  fontSize: 18,
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
                      //1st name
                      CustomText(
                        text: "First Name",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: authController.nameController.value,
                        hintText: "Enter your first name",
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
                      //last name
                      CustomText(
                        text: "Last Name",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: authController.lastNameController.value,
                        hintText: "Enter your last name",
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
                      //Country
                      CustomText(
                        text: "Country",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: authController.countryController.value,
                        hintText: "Enter your country name",
                        hintStyle: TextStyle(color: AppColors.grey_1, fontSize: 14),
                        prefixIcon: const Icon(Icons.public, color: Color(0xFF9CA3AF), size: 20,),
                        fillColor: AppColors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12,
                        keyboardType: TextInputType.emailAddress,

                      ),
                      SizedBox(height: 10),
                      //mobile
                      CustomText(
                        text: "Number",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: authController.phoneNumberController.value,
                        hintText: "Enter your phone number",
                        hintStyle: TextStyle(color: AppColors.grey_1, fontSize: 14),
                        prefixIcon: const Icon(Icons.phone_outlined, color: Color(0xFF9CA3AF), size: 20,),
                        fillColor: AppColors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12,
                        keyboardType: TextInputType.emailAddress,

                      ),
                      SizedBox(height: 10),
                      // DoB
                      CustomText(
                        text: "Date of Birth",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: authController.dateOfBirthController.value,
                        hintText:"YYYY/MM/DD",
                        hintStyle: TextStyle(color: AppColors.grey_1, fontSize: 14),
                        prefixIcon: const Icon(Icons.calendar_today_outlined, color: Color(0xFF9CA3AF), size: 20,),
                        fillColor: AppColors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12,
                        keyboardType: TextInputType.emailAddress,

                      ),
                      SizedBox(height: 10),
                      // password
                      CustomText(
                        text: "Password",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: authController.passwordController.value,
                        hintText: AppStrings.password,
                        hintStyle: TextStyle(color: AppColors.grey_1, fontSize: 14),
                        prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9CA3AF), size: 22,),
                        isPassword: true,
                        fillColor: AppColors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12,
                        onChanged: (value) {
                          authController.validatePasswordLive(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Your Password';
                          }

                          // if (authController.passwordError.value.isNotEmpty) {
                          //   return authController.passwordError.value;
                          // }

                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      // confirmPassword
                      CustomText(
                        text: AppStrings.confirmPassword,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController:  authController.confirmPasswordController.value,
                        hintText: "Retype password",
                        hintStyle: TextStyle(color: AppColors.grey_1, fontSize: 14),
                        prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9CA3AF), size: 22,),
                        isPassword: true,
                        fillColor: AppColors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password';
                          } else if (value !=
                              authController.passwordController.value.text) {
                            return 'Password not Match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                //  Create Account Button
                Obx((){
                  return authController.signUpLoading.value
                  ? CustomLoader()
                  : CustomButton(
                    onTap: () {
                     // Get.toNamed(AppRoutes.otpScreen, arguments: SignUpAuthModel("vakopi1016@daerdy.com", AppStrings.signUp));
                      authController.signUp(role: role);
                    },
                    borderRadius: 12,
                    textColor: AppColors.white,
                    title: "Create Account",
                    fillColor: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  );

                }),
                SizedBox(height: 30),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      CustomText(
                        text: "Already have an account? ",
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.loginOnlyScreen);
                        },
                        child: CustomText(
                          text: " Sign In",
                          color: AppColors.primary1,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
                // Wrap(
                //   alignment: WrapAlignment.center,
                //   crossAxisAlignment: WrapCrossAlignment.center,
                //   children: [
                //     CustomText(text: "By continuing, you agree to ICEWAIT's",color: Colors.black),
                //     GestureDetector(
                //         onTap: (){},
                //         child: CustomText(text: " Terms ", color: AppColors.primary1)
                //     ),
                //     CustomText(text: "and ",color: Colors.black),
                //     GestureDetector(
                //         onTap: (){},
                //         child: CustomText(text: "Privacy Policy",color:AppColors.primary1)
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
