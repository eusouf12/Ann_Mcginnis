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
import '../controller/setup_profile_controller.dart';
import 'package:country_picker/country_picker.dart';

class SetUpProfileScreen1 extends StatelessWidget {
  SetUpProfileScreen1({super.key});

  final SetupProfileController setupProfileController= Get.put(SetupProfileController());
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
                const CustomText(text: "Step 1 of 6", fontSize: 14, color: Color(0xFF1E3A8A), fontWeight: FontWeight.w600),
                SizedBox(height: 8.h),
                LinearProgressIndicator(
                  value: 0.16,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary,
                  backgroundColor: Colors.grey.shade300,
                ),
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
                      //Nationality
                      CustomFormCard(
                        title: "Nationality",
                        titleColor: Colors.black,
                        hintText: "Enter your nationality",
                        controller: setupProfileController.nationalityController.value,
                        fieldBorderColor: Colors.grey.shade300,
                        inputTextColor: Colors.black,
                        curserColor: AppColors.primary,
                        fillBorderRadius: 12,
                        validator: (value) => setupProfileController.validateName(setupProfileController.nationalityController.value.text),                      ),
                      //
                      CustomText(text: "EnglishProficiency", color: Colors.black, fontWeight: FontWeight.w500, bottom: 10,top: 20,),
                      Obx(() => _buildDropdown(
                        hint: "Select your englishProficiency",
                        value: setupProfileController.selectedEnglishProficiency.value.isEmpty ? null : setupProfileController.selectedEnglishProficiency.value,
                        items: setupProfileController.englishProficiencyRanges,
                        onChanged: (val) => setupProfileController.selectedEnglishProficiency.value = val!,
                      )),
                      SizedBox(height: 15.h),
                      //IeltsScore
                      CustomFormCard(
                        title: "Ielts Score",
                        titleColor: Colors.black,
                        hintText: "Enter your ieltsScore(0-9)",
                        controller: setupProfileController.selectedIeltsScore.value,
                        fieldBorderColor: Colors.grey.shade300,
                        inputTextColor: Colors.black,
                        curserColor: AppColors.primary,
                        fillBorderRadius: 12,
                        validator: (value) =>setupProfileController.validateIeltsScore(value ?? ""),                      ),
                      //toeflScore
                      CustomFormCard(
                        title: "Toefl Score",
                        titleColor: Colors.black,
                        hintText: "Enter your toeflScore(0-120)",
                        controller: setupProfileController.selectedToeflScore.value,
                        fieldBorderColor: Colors.grey.shade300,
                        inputTextColor: Colors.black,
                        curserColor: AppColors.primary,
                        fillBorderRadius: 12,
                        validator: (value) => setupProfileController.validateToeflScore(value ?? ""
                        ),                        ),

                    ],
                  ),
                ),
                SizedBox(height: 40.h),

                // Continue Button
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      debugPrint("Name: ${setupProfileController.nationalityController.value.text}, englishProficiency: ${setupProfileController.selectedEnglishProficiency.value}");
                      Get.to(SetUpProfileScreen2());
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

  Widget _buildDropdown({required String hint, String? value, required List<String> items, required Function(String?) onChanged}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: CustomText(text: hint, color: Colors.grey, fontSize: 14),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}