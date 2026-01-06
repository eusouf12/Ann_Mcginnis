import 'package:ann_mcginnis/view/components/custom_from_card/custom_from_card.dart';
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
  final ConsultSetupController consultSetupController = Get.put(ConsultSetupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: "Global Jump"),
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
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                    ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8.r)),
                              child: Icon( Icons.attach_money, color: AppColors.primary1, size: 20),
                            ),
                            SizedBox(width: 12.w),
                            CustomText(text: "Consultation Pricing", fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black,),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        const CustomText(text: "Hourly Rate", fontWeight: FontWeight.bold,color: Colors.black,),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Expanded(child: _buildTextField(hint: "0.00", prefixIcon: Icons.attach_money)),
                            SizedBox(width: 10.w),
                            _buildCurrencyDropdown(),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        const CustomText(text: "Set your standard hourly consultation rate", fontSize: 12, color: Colors.grey),
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
                          textEditingController: TextEditingController(),
                          hintText: "% DisCount percentage",
                          hintStyle: TextStyle(
                              color: AppColors.grey_1,
                              fontSize: 14
                          ),
                          fillColor: AppColors.white,
                          fieldBorderColor: const Color(0xFFE5E7EB),
                          fieldBorderRadius: 12,
                        ),
                        SizedBox(height: 10),
                        // describe
                        CustomText(
                          text: 'Describe',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          textEditingController: TextEditingController(),
                          hintText: "Describe special offers (e.g., 10% off for 5+ sessions)",
                          hintStyle: TextStyle(
                              color: AppColors.grey_1,
                              fontSize: 14
                          ),
                          fillColor: AppColors.white,
                          fieldBorderColor: const Color(0xFFE5E7EB),
                          fieldBorderRadius: 12,
                        ),
                        SizedBox(height: 10),
                        //Payment Methods
                        CustomText(text: "Payment Methods", fontWeight: FontWeight.bold,color: Colors.black,),
                        SizedBox(height: 8.h),
                        _buildDropdownField("Select accepted payment methods"),
                      ],
                    )
                ),

                SizedBox(height: 16.h),
                // 2. Additional Details Card
                Container(
                  padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                    ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(8.r)),
                            child: Icon(Icons.settings, color: Colors.amber, size: 20),
                          ),
                          SizedBox(width: 12.w),
                          CustomText(text: "Additional Details", fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black,),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      CustomText(text: "Consultation Format", fontWeight: FontWeight.bold,color: Colors.black,),
                      SizedBox(height: 16.h),
                      CustomSectionCard(
                        icon: Icons.videocam,
                        title: "Video Call",
                        isChecked: consultSetupController.isCallChecked,
                        onChanged: consultSetupController.callToggle,
                      ),
                      //"Phone Call"
                      CustomSectionCard(
                        icon: Icons.phone,
                        title: "Phone Call",
                        isChecked: consultSetupController.isCallChecked,
                        onChanged: consultSetupController.callToggle,
                      ),
                      //"In-Person"
                      CustomSectionCard(
                        icon: Icons.person,
                        title: "In-Person",
                        isChecked: consultSetupController.isCallChecked,
                        onChanged: consultSetupController.callToggle,
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        text: 'Additional Notes',
                        fontWeight: FontWeight.bold,color: Colors.black,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 10),
                      CustomTextField(
                        textEditingController: TextEditingController(),
                        hintText: "Add any additional details about your consultation services, availability, or requirements...",
                        hintStyle: TextStyle(color: AppColors.grey_1, fontSize: 14),
                        fillColor: AppColors.white,
                        fieldBorderColor: const Color(0xFFE5E7EB),
                        fieldBorderRadius: 12,
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
                      const Icon(Icons.info_outline, color: Colors.blue, size: 20),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(text: "Pricing Guidelines", fontWeight: FontWeight.bold, color: Colors.blue),
                            CustomText(
                              text: "Your pricing will be visible to clients. Make sure to set competitive rates based on your expertise.",
                              fontSize: 11, color: Colors.blue.shade800,
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
  Widget _buildTextField({required String hint, IconData? prefixIcon, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey.shade400),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey, size: 20) : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Colors.grey.shade300)),
      ),
    );
  }

  Widget _buildCurrencyDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: "USD",
          items: ["USD", "BDT", "EUR"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (v) {},
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
          items: const [],
          onChanged: (v) {},
        ),
      ),
    );
  }

}