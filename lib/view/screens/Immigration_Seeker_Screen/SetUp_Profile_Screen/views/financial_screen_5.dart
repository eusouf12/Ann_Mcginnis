import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../controller/setup_profile_controller.dart';
import 'financial_info_screen_6.dart';

class SetUpProfileScreen5 extends StatelessWidget {
  SetUpProfileScreen5({super.key});

  final SetupProfileController controller = Get.put(SetupProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Financial Information",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            // Step Indicator
            const CustomText(
              text: "Step 5 of 5",
              fontSize: 14,
              color: Color(0xFF1E3A8A), // Navy Blue
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 8.h),
            // Progress Bar (Almost full since it's step 5/5)
            _buildProgressBar(0.9),
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
                  // 1. Blue Info Box
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0FE), // Light Blue
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: const Color(0xFFBBDEFB)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info, color: Color(0xFF1565C0), size: 20),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomText(
                            text: "Please provide your financial information and current status to help us better assess your profile.",
                            fontSize: 13,
                            color: Colors.black87,
                            textAlign: TextAlign.start,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 2. Net Worth Field
                  const CustomText(
                    text: "Net Worth",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    bottom: 10,
                  ),
                  CustomTextField(
                    hintText: "\$0",
                    textEditingController: controller.netWorthController,
                    keyboardType: TextInputType.number,
                    fieldBorderColor: Colors.grey.shade300,
                    fillColor: Colors.white,
                    hintStyle: const TextStyle(color: Colors.grey),
                    fieldBorderRadius: 8,
                  ),
                  SizedBox(height: 20.h),

                  // 3. Length of Stay Dropdown
                  const CustomText(
                    text: "Length of Stay",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    bottom: 10,
                  ),
                  Obx(() => _buildDropdown(
                    hint: "Select duration",
                    value: controller.selectedDuration.value,
                    items: controller.durationList,
                    onChanged: (val) {
                      controller.selectedDuration.value = val;
                    },
                  )),
                  SizedBox(height: 20.h),

                  // 4. Retirement Status Switch Card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Retirement Status",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            SizedBox(height: 4.h),
                            CustomText(
                              text: "Are you currently retired?",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                        Obx(() => Switch(
                          value: controller.isRetired.value,
                          activeColor: AppColors.primary1,
                          onChanged: (val) {
                            controller.isRetired.value = val;
                          },
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 5. Business Experience Checkbox Card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "Business Experience",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          text: "Do you own or intend to start a business?",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                          bottom: 12,
                        ),
                        Obx(() => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 24.h,
                              width: 24.w,
                              child: Checkbox(
                                value: controller.hasBusinessExperience.value,
                                activeColor: AppColors.primary1,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                onChanged: (val) {
                                  controller.hasBusinessExperience.value = val!;
                                },
                              ),
                            ),
                            SizedBox(width: 10.w),
                            const Expanded(
                              child: CustomText(
                                text: "Yes, I have business ownership/intentions",
                                fontSize: 13,
                                color: Colors.black87,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 6. International Achievements Section
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "International Achievements",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          text: "Select any applicable achievements",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                          bottom: 12,
                        ),
                        Obx(() => Column(
                          children: controller.achievementList.map((item) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 24.h,
                                    width: 24.w,
                                    child: Checkbox(
                                      value: controller.selectedAchievements.contains(item),
                                      activeColor: AppColors.primary1,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      onChanged: (val) {
                                        controller.toggleAchievement(item);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: CustomText(
                                      text: item,
                                      fontSize: 13,
                                      color: Colors.black87,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),

            // Continue Button
            CustomButton(
              onTap: () {
                // Print all data to console for testing
                print("=========== Financial Info ===========");
                print("Net Worth: ${controller.netWorthController.text}");
                print("Duration: ${controller.selectedDuration.value}");
                print("Retired: ${controller.isRetired.value}");
                print("Business Exp: ${controller.hasBusinessExperience.value}");
                print("Achievements: ${controller.selectedAchievements}");

                 Get.to(() => SetUpProfileScreen6());
              },
              title: "Continue",
              fillColor: const Color(0xFFFBB03B),
              textColor: Colors.white,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // ================= Helper Widgets =================

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

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      hint: Text(hint, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      icon: const Icon(Icons.keyboard_arrow_down),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary1),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: const TextStyle(color: Colors.black, fontSize: 14)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}