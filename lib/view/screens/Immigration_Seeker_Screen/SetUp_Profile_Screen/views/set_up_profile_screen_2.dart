import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../controller/setup_profile_controller.dart';

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
              _buildProgressBar(0.33),
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
                    CustomFormCard(
                      title: "Field of Study *",
                      hintText: "e.g., Computer Science",
                      controller: controller.fieldOfStudyController.value,
                      titleColor: Colors.black,
                      fieldBorderColor: Colors.grey.shade300,
                      fillBorderRadius: 12,
                      // validator: (v) => controller.validateRequired(v),
                    ),
                    // Year of Graduation
                    CustomFormCard(
                      title: "Year of Graduation *",
                      hintText: "2024",
                      controller: controller.graduationYearController.value,
                      keyboardType: TextInputType.number,
                      titleColor: Colors.black,
                      fieldBorderColor: Colors.grey.shade300,
                      fillBorderRadius: 12,
                      // validator: (v) => controller.validateRequired(v),
                    ),
                    // Additional Certifications (Multiline)
                    CustomText(text: "Additional Certifications (Optional)", color: Colors.black, fontWeight: FontWeight.w500, bottom: 8),
                    SizedBox(height: 15.h),
                    GestureDetector(
                      onTap: () => controller.pickImageFromGallery(),
                      child: Obx(() => Container(
                        height: 150.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey.shade300, width: 1),
                          image: controller.selectedImage.value != null
                              ? DecorationImage(
                            image: FileImage(controller.selectedImage.value!),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                        child: controller.selectedImage.value == null
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate_outlined,
                                size: 40.sp,
                                color: Colors.grey),
                            SizedBox(height: 8.h),
                            const CustomText(
                              text: "Tap to select an image",
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ],
                        )
                            : const SizedBox.shrink(),
                      )),
                    ),
                    SizedBox(height: 15.h),
                    // Info Box (Blue background)
                    Container(
                      padding: EdgeInsets.all(16.w), // একটু বেশি প্যাডিং দেওয়া হয়েছে স্পেসিং এর জন্য
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F0FE), // স্ক্রিনশট অনুযায়ী হালকা নীল ব্যাকগ্রাউন্ড
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info, color: Color(0xFF0D47A1), size: 20), // গাঢ় নীল আইকন
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
                                // প্রতিটি সার্টিফিকেশন আইটেম বুলেট পয়েন্ট সহ
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

  Widget _buildProgressBar(double factor) {
    return Container(
      height: 6.h, width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: factor,
        child: Container(decoration: BoxDecoration(color: const Color(0xFF1E3A8A), borderRadius: BorderRadius.circular(10))),
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
}