import 'package:ann_mcginnis/view/components/custom_text_field/custom_text_field.dart';
import 'package:ann_mcginnis/view/screens/Consultant/consult_SetUp_profile/view/review_profile_screen_consult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/consult_setup_controller.dart';
import '../widget/custom_progressbar.dart';
import '../widget/custom_section_card.dart';

class ConsultSetupScreen4 extends StatelessWidget {
  ConsultSetupScreen4({super.key});
  final ConsultSetupController consultSetupController = Get.put(
    ConsultSetupController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Global Jump"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // Step Indicator
            CustomText(
              text: "Step 4 of 4",
              fontSize: 14,
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10.h),
            // Progress Bar (Approx 100%)
            CustomProgressBar(factor: 1.0),
            SizedBox(height: 20.h),
            const Center(
              child: CustomText(
                text: "Set Your Consultation Fees \nand Settings",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.start,
              ),
            ),
            const Center(
              child: CustomText(
                text: "Configure your pricing and consultation preferences",
                fontSize: 12,
                top: 10,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20.h),
            //================= Pricing ============
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.attach_money,
                              color: AppColors.primary1,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          CustomText(
                            text: "Consultation Pricing",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildCurrencyDropdown(),
                      SizedBox(height: 16.h),
                      Obx(() => Column(
                        children: [
                          // 1. Video Call
                          CustomSectionCard(
                            icon: Icons.videocam,
                            title: "Video Call",
                            isChecked: consultSetupController.isVideoSelected,
                            onChanged: (val) => consultSetupController.isVideoSelected.value = val!,
                          ),
                          if (consultSetupController.isVideoSelected.value)
                            _buildFeeInputField(consultSetupController.videoFeeController, "Set Video Consultation Fee (\$)"),

                          SizedBox(height: 12.h),

                          // 2. Phone Call
                          CustomSectionCard(
                            icon: Icons.phone,
                            title: "Phone Call",
                            isChecked: consultSetupController.isPhoneSelected,
                            onChanged: (val) => consultSetupController.isPhoneSelected.value = val!,
                          ),
                          if (consultSetupController.isPhoneSelected.value)
                            _buildFeeInputField(consultSetupController.phoneFeeController, "Set Phone Call Fee (\$)"),

                          SizedBox(height: 12.h),

                          // 3. In-Person
                          CustomSectionCard(
                            icon: Icons.person,
                            title: "In-Person",
                            isChecked: consultSetupController.isInPersonSelected,
                            onChanged: (val) => consultSetupController.isInPersonSelected.value = val!,
                          ),
                          if (consultSetupController.isInPersonSelected.value)
                            _buildFeeInputField(consultSetupController.inPersonFeeController, "Set In-Person Visit Fee (\$)"),
                        ],
                      )),
                      SizedBox(height: 16.h),


                      SizedBox(height: 10.h),
                      const CustomText(
                        text: "Set your standard consultation rate",
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20.h),
                      //Discount or Package Rates',
                      CustomText(
                        text: 'Discount or Package Rates',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: consultSetupController.discountPercentageController,
                        hintText: "% DisCount percentage",
                        hintStyle: TextStyle(
                          color: AppColors.grey_1,
                          fontSize: 14,
                        ),
                        fillColor: AppColors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12,
                      ),
                      SizedBox(height: 10),

                    ],
                  ),
                ),

                SizedBox(height: 16.h),
                // 2. Additional Details Card
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // --- Additional Notes Section ---
                      const CustomText(
                        text: 'Additional Notes',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        textEditingController: consultSetupController.notesController,
                        hintText: "Add any additional details about your consultation services, availability, or requirements...",
                        hintStyle: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 14,
                        ),
                        fillColor: Colors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12.r,
                        maxLines: 4,
                      ),
                      SizedBox(height: 16.h),
                    ],
                  )
                ),
                SizedBox(height: 25.h),
                // 3. Pricing Guidelines Info Box
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                        size: 20,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Pricing Guidelines",
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            CustomText(
                              text:
                                  "Your pricing will be visible to clients. Make sure to set competitive rates based on your expertise.",
                              fontSize: 11,
                              color: Colors.blue.shade800,
                              maxLines: 3,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // Bottom Buttons
                CustomButton(
                  onTap: () {
                    // ডাটা কনসোলে প্রিন্ট করার জন্য debugPrint
                    debugPrint("========== STEP 4 FORM DATA ==========");
                    debugPrint("Selected Currency: ${consultSetupController.selectedCurrency.value}");

                    debugPrint("--- Consultation Formats & Fees ---");
                    if (consultSetupController.isVideoSelected.value) {
                      debugPrint("Video Call: Enabled | Fee: ${consultSetupController.videoFeeController.text}");
                    }
                    if (consultSetupController.isPhoneSelected.value) {
                      debugPrint("Phone Call: Enabled | Fee: ${consultSetupController.phoneFeeController.text}");
                    }
                    if (consultSetupController.isInPersonSelected.value) {
                      debugPrint("In-Person: Enabled | Fee: ${consultSetupController.inPersonFeeController.text}");
                    }

                    debugPrint("--- Discounts ---");

                    debugPrint("--- Additional Notes ---");
                    debugPrint("Notes: ${consultSetupController.notesController.text}");
                    debugPrint("======================================");

                    Get.to(ConsultReviewProfileScreen());
                  },
                  title: "Save Settings",
                  textColor: Colors.white,
                  icon: const Icon(Icons.check, color: Colors.white, size: 18),
                  fillColor: AppColors.yellow1,
                  fontSize: 16,
                ),
                // SizedBox(height: 12.h),
                // CustomButton(
                //   onTap: () {},
                //   title: "Update Profile",
                //   fillColor: Colors.grey.shade200,
                //   textColor: Colors.black87,
                //   fontSize: 16,
                // ),
                SizedBox(height: 20.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Components ---
  Widget _buildCurrencyDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(() => DropdownButton<String>(
          value: consultSetupController.selectedCurrency.value,
          isExpanded: true, // এটি বাটনটিকে কন্টেইনারের পুরো জায়গা জুড়ে ছড়িয়ে দিবে
          icon: const Icon(Icons.arrow_drop_down),
          items: ["USD", "BDT", "EUR"].map((e) =>
              DropdownMenuItem(value: e, child: Text(e))
          ).toList(),
          onChanged: (v) {
            if (v != null) consultSetupController.selectedCurrency.value = v;
          },
        )),
      ),
    );
  }

  Widget _buildFeeInputField(TextEditingController controller, String hint) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, left: 15.w, right: 5.w),
      child: CustomTextField(
        textEditingController: controller,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 14.sp,
        ),
        keyboardType: TextInputType.number,
        fillColor: const Color(0xFFF3F4F6),
        fieldBorderColor: Colors.blue.withOpacity(0.3),
        prefixIcon: const Icon(Icons.monetization_on_outlined, color: Colors.blue, size: 20),
      ),
    );
  }
}
