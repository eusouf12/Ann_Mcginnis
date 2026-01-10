import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:ann_mcginnis/view/screens/Immigration_Seeker_Screen/SetUp_Profile_Screen/views/set_up_profile_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/consult_setup_controller.dart';
import '../widget/custom_progressbar.dart';
import 'consult_setup_screen_2.dart';

class SetUpProfileScreen1 extends StatelessWidget {
  SetUpProfileScreen1({super.key});

  final ConsultSetupController setupProfileController= Get.put(ConsultSetupController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:CustomRoyelAppbar(leftIcon: true,titleName: "Personal Information",),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                const CustomText(text: "Step 1 of 4", fontSize: 14, color: Color(0xFF1E3A8A), fontWeight: FontWeight.w600),
                SizedBox(height: 8.h),
                CustomProgressBar(factor: 0.25),
                SizedBox(height: 40.h),
                // white card
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      CustomFormCard(
                        title: "First Name",
                        titleColor: Colors.black,
                        hintText: "Enter your first name",
                        controller: setupProfileController.firstNameController.value,
                        fieldBorderColor: Colors.grey.shade300,
                        inputTextColor: Colors.black,
                        curserColor: AppColors.primary,
                        fillBorderRadius: 12,
                        validator: (value) => setupProfileController.validateName(setupProfileController.firstNameController.value.text),
                      ),
                      //last name
                      CustomFormCard(
                        title: "Last Name",
                        titleColor: Colors.black,
                        hintText: "Enter your last name",
                        controller: setupProfileController.lastNameController.value,
                        fieldBorderColor: Colors.grey.shade300,
                        inputTextColor: Colors.black,
                        curserColor: AppColors.primary,
                        fillBorderRadius: 12,
                        validator: (value) => setupProfileController.validateName(setupProfileController.lastNameController.value.text),
                      ),
                      //job title
                      CustomFormCard(
                        title: "Job Title / Specialization",
                        titleColor: Colors.black,
                        hintText: "Enter your first job title",
                        controller: setupProfileController.jobTitleController.value,
                        fieldBorderColor: Colors.grey.shade300,
                        inputTextColor: Colors.black,
                        curserColor: AppColors.primary,
                        fillBorderRadius: 12,
                        validator: (value) => setupProfileController.validateName(setupProfileController.jobTitleController.value.text),
                      ),
                      //Profile Description
                      CustomFormCard(
                        title: "Profile Description",
                        titleColor: Colors.black,
                        hintText: "Describe your experience in immigration consultation, your expertise, and the services you offer to clients. Highlight what makes you unique and how you can help people with their",
                        controller: setupProfileController.jobTitleController.value,
                        fieldBorderColor: Colors.grey.shade300,
                        inputTextColor: Colors.black,
                        curserColor: AppColors.primary,
                        fillBorderRadius: 12,
                        maxLine: 5,
                        validator: (value) => setupProfileController.validateName(setupProfileController.jobTitleController.value.text),
                      ),
                      SizedBox(height: 24.h),

                      // Container(
                      //   padding: EdgeInsets.all(16.w),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     border: Border.all(color: Colors.grey.shade300),
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       const CustomText(
                      //         text: "International Achievements",
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w600,
                      //         color: Colors.black,
                      //       ),
                      //       SizedBox(height: 4.h),
                      //       CustomText(
                      //         text: "Select any applicable achievements",
                      //         fontSize: 13,
                      //         color: Colors.grey.shade600,
                      //       ),
                      //       SizedBox(height: 12.h),
                      //
                      //       Obx(() => Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: setupProfileController.achievements.map((item) {
                      //           final isChecked =
                      //           setupProfileController.selectedAchievements.contains(item);
                      //
                      //           return Padding(
                      //             padding: EdgeInsets.symmetric(vertical: 6.h),
                      //             child: Row(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               children: [
                      //                 SizedBox(
                      //                   height: 20,
                      //                   width: 20,
                      //                   child: Checkbox(
                      //                     value: isChecked,
                      //                     activeColor: AppColors.primary,
                      //                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      //                     visualDensity: VisualDensity.compact,
                      //                     onChanged: (_) {
                      //                       setupProfileController.toggleAchievement(item);
                      //                     },
                      //                   ),
                      //                 ),
                      //                 const SizedBox(width: 10,),
                      //                 CustomText(
                      //                   text: item,
                      //                   fontSize: 14,
                      //                   color: Colors.black,
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         }).toList(),
                      //       )),
                      //
                      //     ],
                      //   ),
                      // ),

                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                // Continue Button
                CustomButton(
                  onTap: () {
                    // if (formKey.currentState!.validate()) {
                    //   showCustomSnackBar("Error, Please select age and country",isError: true);
                    // }
                    if (formKey.currentState!.validate()) {
                      debugPrint("Name: ${setupProfileController.firstNameController.value.text}");
                      Get.to(ConsultSetupScreen2());
                    }
                  },

                  title: "Continue",
                  fillColor: const Color(0xFFFBB03B),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}