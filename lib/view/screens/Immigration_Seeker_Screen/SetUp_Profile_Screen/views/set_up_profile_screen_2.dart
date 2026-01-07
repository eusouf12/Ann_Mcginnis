import 'package:ann_mcginnis/utils/app_const/app_const.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../controller/setup_profile_controller.dart';
import 'career_info_screen_3.dart';

class SetUpProfileScreen2 extends StatelessWidget {
  SetUpProfileScreen2({super.key});

  final SetupProfileController controller = Get.put(SetupProfileController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomRoyelAppbar(leftIcon: true,titleName: "Education Information"),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              const CustomText(text: "Step 2 of 6", fontSize: 14, color: Color(0xFF1E3A8A), fontWeight: FontWeight.w600),
              SizedBox(height: 8.h),
              LinearProgressIndicator(
                value: 0.33,
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
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormCard(
                      title: "First Name",
                      hintText: "Enter your first name",
                      controller: controller.firstNameController.value,
                      titleColor: Colors.black,
                      fieldBorderColor: Colors.grey.shade300,
                      fillBorderRadius: 12,
                      // validator: (v) => controller.validateRequired(v),
                    ),
                    // Last Name
                    CustomFormCard(
                      title: "Last Name",
                      hintText: "Enter your last name",
                      controller: controller.lastNameController.value,
                      titleColor: Colors.black,
                      fieldBorderColor: Colors.grey.shade300,
                      fillBorderRadius: 12,
                      // validator: (v) => controller.validateRequired(v),
                    ),
                    // Field of Study
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Field of Study ",
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          bottom: 10,
                        ),
                        CustomText(
                          text: '*',
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          bottom: 10,
                        ),
                      ],
                    ),
                    CustomTextField(
                      hintText: "e.g., Computer Science",
                      textEditingController : controller.fieldOfStudyController.value,
                      fieldBorderColor: Colors.grey.shade300,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.grey),
                      fieldBorderRadius: 12,
                    ),
                    // Year of Graduation
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Year of Graduation ",
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          bottom: 10,
                        ),
                        CustomText(
                          text: '*',
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          bottom: 10,
                        ),
                      ],
                    ),
                    CustomTextField(
                      hintText: "2024",
                      textEditingController: controller.graduationYearController.value,
                      keyboardType: TextInputType.number,
                      fieldBorderColor: Colors.grey.shade300,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.grey),
                      fieldBorderRadius: 12,
                      // validator: (v) => controller.validateRequired(v),
                    ),
                    // Additional Certifications (Multiline)
                    SizedBox(height: 10,),
                    CustomText(text: "Additional Certifications (Optional)", color: Colors.black,fontSize: 16, fontWeight: FontWeight.w500, bottom: 8),
                    SizedBox(height: 15.h),
                    Obx(() => _buildDropdown(
                      hint: "Select certificate",
                      value: controller.selectedCertificate.value.isEmpty
                          ? null
                          : controller.selectedCertificate.value,
                      items: [
                        ...controller.certificates,
                        "Add new certificate",
                      ],
                      onChanged: (val) {
                        if (val == "Add new certificate") {
                          _showAddCertificateDialog(context);
                        } else {
                          controller.selectedCertificate.value = val!;
                        }
                      },
                    )),

                    SizedBox(height: 15.h),
                    // Info Box (Blue background)
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F0FE),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info, color: Color(0xFF0D47A1), size: 20),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: "Examples of Certifications:",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0D47A1),
                                  bottom: 8,
                                  textAlign: TextAlign.start,
                                ),
                                _buildBulletPoint("AWS Certified Solutions Architect"),
                                _buildBulletPoint("Google Analytics Certified"),
                                _buildBulletPoint("Dean's List (2022-2024)"),
                                _buildBulletPoint("Magna Cum Laude"),
                                _buildBulletPoint("Project Management Professional (PMP)"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              CustomButton(
                onTap: () {
                     if (_formKey.currentState!.validate()) {
                  }
                     Get.to(() => CareerInfoScreen3());
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

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: "• ",
            color: Color(0xFF1565C0),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          Expanded(
            child: CustomText(
              text: text,
              color: const Color(0xFF1565C0),
              fontSize: 13,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildDropdown({required String hint, required String? value, required List<String> items, required Function(String?) onChanged,}) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: items.map((item) {
        final bool isAddNew = item == "Add new certificate";

        return DropdownMenuItem<String>(
          value: item,
          child: Container(
            padding: isAddNew? EdgeInsets.only(right: 40,left: 10): EdgeInsets.zero,
            decoration: isAddNew
                ? BoxDecoration(
              color: AppColors.primary1,
              borderRadius: BorderRadius.circular(6),
            )
                : null,
            child: Text(
              item,
              style: TextStyle(
                color: isAddNew ? Colors.white : Colors.black,
                fontWeight:
                isAddNew ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

}

void _showAddCertificateDialog(BuildContext context) {
  final controller = Get.find<SetupProfileController>();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Add Certificate"),
      content: TextField(
        controller: controller.certificateController,
        decoration: const InputDecoration(
          hintText: "Enter certificate name",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller.certificateController.clear();
            Get.back();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            controller.addCertificate(
              controller.certificateController.text.trim(),
            );
            controller.certificateController.clear();
            Get.back();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.primary1),
          ),
          child: CustomText(text: "Add"),
        ),
      ],
    ),
  );
}