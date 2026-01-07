import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/setup_profile_controller.dart';
import 'financial_screen_5.dart';

class SetUpProfileScreen4 extends StatelessWidget {
  SetUpProfileScreen4({super.key});

  final SetupProfileController controller = Get.put(SetupProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Criminal History",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            // Step Indicator
            const CustomText(
              text: "Step 4 of 6",
              fontSize: 14,
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 8.h),
            LinearProgressIndicator(
              value: 0.66,
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
                  // 1. Blue Info Box
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0FE),
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
                            text: "Please provide accurate information regarding your criminal history. This information is kept confidential and secure.",
                            fontSize: 13,
                            color: Colors.black87,
                            textAlign: TextAlign.start,
                            maxLines: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 2. Question Text
                  Row(
                    children: [
                      const CustomText(
                        text: "Do you have a criminal history? ",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      const CustomText(
                        text: "*",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),

                  // 3. Yes/No Selection Cards
                  Obx(() => Row(
                    children: [
                      Expanded(
                        child: _buildSelectionCard(
                          title: "Yes",
                          value: "Yes",
                          groupValue: controller.hasCriminalHistory.value,
                          onChanged: (val) => controller.hasCriminalHistory.value = val,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: _buildSelectionCard(
                          title: "No",
                          value: "No",
                          groupValue: controller.hasCriminalHistory.value,
                          onChanged: (val) => controller.hasCriminalHistory.value = val,
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: 20.h),

                  // 4. Grey Lock/Security Box
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lock, color: Colors.grey.shade600, size: 20),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomText(
                            text: "Please provide accurate information regarding your criminal history. This information is kept confidential and secure.",
                            fontSize: 13,
                            color: Colors.grey.shade800,
                            textAlign: TextAlign.start,
                            maxLines: 4,
                          ),
                        ),
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
                if (controller.hasCriminalHistory.value.isNotEmpty) {
                  // Print Selection
                  debugPrint("Criminal History: ${controller.hasCriminalHistory.value}");
                   Get.to(() => SetUpProfileScreen5());
                } else {
                  Get.snackbar(
                    "Required",
                    "Please select Yes or No",
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
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
    );
  }

  // ================= Helper Widgets =================
  Widget _buildSelectionCard({
    required String title,
    required String value,
    required String groupValue,
    required Function(String) onChanged,
  }) {
    bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary1 : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
              width: 20.w,
              child: Radio<String>(
                value: value,
                groupValue: groupValue,
                activeColor: AppColors.primary1,
                onChanged: (val) => onChanged(val!),
              ),
            ),
            SizedBox(width: 8.w),
            CustomText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}