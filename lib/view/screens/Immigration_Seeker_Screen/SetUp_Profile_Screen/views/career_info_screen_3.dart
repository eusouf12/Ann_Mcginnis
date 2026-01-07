import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:ann_mcginnis/view/screens/Immigration_Seeker_Screen/SetUp_Profile_Screen/views/criminal_screen_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../controller/setup_profile_controller.dart';

class CareerInfoScreen3 extends StatelessWidget {
  CareerInfoScreen3({super.key});

  final SetupProfileController controller = Get.put(SetupProfileController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Career Information",),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              // Step Indicator
               CustomText(
                text: "Step 3 of 6",
                fontSize: 14,
                color: Color(0xFF1E3A8A),
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 8.h),
              // Progress Bar (Approx 50%)
              LinearProgressIndicator(
                value: 0.50,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary,
                backgroundColor: Colors.grey.shade300,
              ),
              SizedBox(height: 30.h),

              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Current Occupation Dropdown
                    CustomText(
                      text: "Current Occupation",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      bottom: 10,
                    ),
                    Obx(() => _buildDropdown(
                      hint: "Select your occupation",
                      value: controller.currentOccupation.value,
                      items: controller.occupationList,
                      onChanged: (val) {
                        controller.currentOccupation.value = val;
                      },
                    )),
                    SizedBox(height: 20.h),

                    // 2. Remote Work Status Radio
                    CustomText(
                      text: "Remote Work Status",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      bottom: 10,
                    ),
                    Obx(() => Row(
                      children: [
                        _buildRadioButton("Yes", controller.remoteWorkStatus.value, (val) {
                          controller.remoteWorkStatus.value = val!;
                        }),
                        SizedBox(width: 20.w),
                        _buildRadioButton("No", controller.remoteWorkStatus.value, (val) {
                          controller.remoteWorkStatus.value = val!;
                        }),
                      ],
                    )),
                    SizedBox(height: 20.h),

                    // 3. Career Field(s) Checkboxes
                    CustomText(
                      text: "Career Field(s)",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      bottom: 5,
                    ),
                    CustomText(
                      text: "Select all that apply",
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      bottom: 15,
                    ),

                    // Generating Checkboxes from List
                    Obx(() => Column(
                      children: controller.careerFieldsList.map((field) {
                        return _buildCheckboxTile(
                          title: field,
                          isSelected: controller.selectedCareerFields.contains(field),
                          onChanged: (val) {
                            controller.toggleCareerField(field);
                          },
                        );
                      }).toList(),
                    )),
                    SizedBox(height: 20.h),

                    // 4. Management Experience Checkbox
                    CustomText(
                      text: "Management Experience",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      bottom: 10,
                    ),
                    Obx(() => _buildCheckboxTile(
                      title: "I have management experience in my field",
                      isSelected: controller.hasManagementExperience.value,
                      onChanged: (val) {
                        controller.hasManagementExperience.value = val!;
                      },
                    )),
                    SizedBox(height: 20.h),

                    // 5. Work History Notes (Text Area)
                    CustomText(
                      text: "Work History Notes",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      bottom: 5,
                    ),
                    CustomText(
                      text: "Optional - describe notable achievements or specific roles",
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      bottom: 20,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                    CustomTextField(
                      hintText: "Tell us about your notable work achievements, specific roles, or any other relevant work history...",
                      textEditingController: controller.workHistoryController,
                      maxLines: 4,
                      fieldBorderColor: Colors.grey.shade300,
                      fillColor: Colors.white,
                      hintStyle: const TextStyle(color: Colors.grey),
                      fieldBorderRadius: 12,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              // Continue Button
              CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint("Selected Career Fields: ${controller.selectedCareerFields}");
                    String? occupation = controller.currentOccupation.value;
                    String remoteStatus = controller.remoteWorkStatus.value;
                    List<String> careerFields = controller.selectedCareerFields;
                    bool isManager = controller.hasManagementExperience.value;
                    String notes = controller.workHistoryController.text;

                    debugPrint("=========== User Selection Data ===========");
                    debugPrint("Current Occupation   : $occupation");
                    debugPrint("Remote Work Status   : $remoteStatus");
                    debugPrint("Selected Career Fields: ${careerFields.join(', ')}"); // লিস্টকে স্ট্রিং এ কনভার্ট করে প্রিন্ট
                    debugPrint("Management Experience: ${isManager ? 'Yes' : 'No'}");
                    debugPrint("Work History Notes   : $notes");
                    debugPrint("===========================================");
                     Get.to(() => SetUpProfileScreen4());
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
    );
  }

  // ================= Helper Widgets =================

  // Progress Bar Widget
  Widget _buildProgressBar(double factor) {
    return Container(
      height: 6.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: factor,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E3A8A),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // Dropdown Widget
  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      hint: Text(hint, style: const TextStyle(color: Colors.grey)),
      icon: const Icon(Icons.keyboard_arrow_down),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary1),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: const TextStyle(color: Colors.black)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // Radio Button Helper
  Widget _buildRadioButton(String title, String groupValue, Function(String?) onChanged) {
    return Row(
      children: [
        SizedBox(
          height: 24.h,
          width: 24.w,
          child: Radio<String>(
            value: title,
            groupValue: groupValue,
            activeColor: AppColors.primary1,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 8.w),
        CustomText(
          text: title,
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }

  // Checkbox Helper
  Widget _buildCheckboxTile({
    required String title,
    required bool isSelected,
    required Function(bool?) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24.h,
            width: 24.w,
            child: Checkbox(
              value: isSelected,
              activeColor: AppColors.primary1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              onChanged: onChanged,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomText(
              text: title,
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}