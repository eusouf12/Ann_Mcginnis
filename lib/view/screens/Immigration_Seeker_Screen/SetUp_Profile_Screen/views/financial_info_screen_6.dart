import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:ann_mcginnis/view/screens/Immigration_Seeker_Screen/SetUp_Profile_Screen/views/legal_advice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../controller/setup_profile_controller.dart';

class SetUpProfileScreen6 extends StatelessWidget {
  SetUpProfileScreen6({super.key});

  final SetupProfileController controller = Get.put(SetupProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Pet Information",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            // Step Indicator
            const CustomText(
              text: "Step 6 of 6",
              fontSize: 14,
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 8.h),
            // Progress Bar (Full 100%)
            LinearProgressIndicator(
              value: 1.0,
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary,
              backgroundColor: Colors.grey.shade300,
            ),
            SizedBox(height: 30.h),

            // Main Card
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
                  // 1. Header with Paw Icon
                  Row(
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFF3E0),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.pets, color: Color(0xFFEF6C00), size: 28),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Traveling with Pets?",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 4.h),
                            CustomText(
                              text: "Let us know if you'll be bringing any furry friends",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // 2. Switch Tile
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: "I'm traveling with pets",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        Obx(() => Switch(
                          value: controller.isTravelingWithPets.value,
                          activeColor: AppColors.primary1,
                          onChanged: (val) {
                            controller.isTravelingWithPets.value = val;
                          },
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),

                  // 3. Pet Details Section (Title)
                  const CustomText(
                    text: "Pet Details",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    bottom: 15,
                  ),

                  // 4. Type of Pets Dropdown
                  const CustomText(
                    text: "Type of Pets",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    bottom: 8,
                  ),
                  Obx(() => _buildDropdown(
                    hint: "Select pet type",
                    value: controller.selectedPetType.value,
                    items: controller.petTypes,
                    onChanged: (val) {
                      controller.selectedPetType.value = val;
                    },
                  )),
                  SizedBox(height: 20.h),

                  // 5. Number of Pets Counter
                  const CustomText(
                    text: "Number of Pets",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    bottom: 10,
                  ),
                  Row(
                    children: [
                      _buildCounterButton(
                        icon: Icons.remove,
                        onTap: controller.decrementPets,
                        color: Colors.grey.shade200,
                        iconColor: Colors.black,
                      ),
                      SizedBox(width: 20.w),
                      Obx(() => CustomText(
                        text: "${controller.numberOfPets.value}",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                      SizedBox(width: 20.w),
                      _buildCounterButton(
                        icon: Icons.add,
                        onTap: controller.incrementPets,
                        color: AppColors.yellow1,
                        iconColor: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // 6. Additional Details
                  const CustomText(
                    text: "Additional Details",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    bottom: 8,
                  ),
                  CustomTextField(
                    hintText: "Tell us about your pets (breed, age, size, etc.)...",
                    textEditingController: controller.petDetailsController,
                    maxLines: 4,
                    fieldBorderColor: Colors.grey.shade300,
                    fillColor: Colors.white,
                    hintStyle: const TextStyle(color: Colors.grey),
                    fieldBorderRadius: 12,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            // Continue Button
            CustomButton(
              onTap: () {
                // Print Data
                print("Traveling with Pets: ${controller.isTravelingWithPets.value}");
                print("Pet Type: ${controller.selectedPetType.value}");
                print("Number of Pets: ${controller.numberOfPets.value}");
                print("Details: ${controller.petDetailsController.text}");

               Get.to(LegalAdviceScreen());
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

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
    );
  }
}