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
                SizedBox(height: 10.h),
                const CustomText(text: "Step 1 of 6", fontSize: 14, color: Color(0xFF1E3A8A), fontWeight: FontWeight.w600),
                SizedBox(height: 8.h),
                _buildProgressBar(),

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
                        hintText: "Enter your Full name",
                        controller: setupProfileController.fullNameController.value,
                        fieldBorderColor: Colors.grey.shade300,
                        inputTextColor: Colors.black,
                        curserColor: AppColors.primary,
                        fillBorderRadius: 12,
                        validator: (value) => setupProfileController.validateName(setupProfileController.fullNameController.value.text),                      ),
                      CustomText(text: "Age Range", color: Colors.black, fontWeight: FontWeight.w500, bottom: 10,top: 20,),
                      Obx(() => _buildDropdown(
                        hint: "Select your age range",
                        value: setupProfileController.selectedAgeRange.value.isEmpty ? null : setupProfileController.selectedAgeRange.value,
                        items: setupProfileController.ageRanges,
                        onChanged: (val) => setupProfileController.selectedAgeRange.value = val!,
                      )),
                      SizedBox(height: 15.h),
                      CustomText(text: "Country of Origin", color: Colors.black, fontWeight: FontWeight.w500, bottom: 10,top: 20,),
                      Obx(() => InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: false,
                            onSelect: (Country country) {
                              setupProfileController.selectedCountry.value = country.name;
                            },
                            countryListTheme: CountryListThemeData(
                              borderRadius: BorderRadius.circular(20),
                              inputDecoration: InputDecoration(
                                hintText: 'Search country',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: setupProfileController.selectedCountry.value.isEmpty
                                    ? "Select your country"
                                    : setupProfileController.selectedCountry.value,
                                color: setupProfileController.selectedCountry.value.isEmpty ? Colors.grey : Colors.black,
                                fontSize: 14,
                              ),
                              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                            ],
                          ),
                        ),
                      )),
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
                      debugPrint("Name: ${setupProfileController.fullNameController.value.text}, Age: ${setupProfileController.selectedAgeRange.value}, country: ${setupProfileController.selectedCountry.value}");
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
  Widget _buildProgressBar() {
    return Container(
      height: 6.h,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: 0.16,
        child: Container(decoration: BoxDecoration(color: const Color(0xFF1E3A8A), borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}