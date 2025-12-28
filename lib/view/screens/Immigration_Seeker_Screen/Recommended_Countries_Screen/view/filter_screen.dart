import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/recomended_countries_controller.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});

  final RecommendedCountriesController controller = Get.put(RecommendedCountriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20.h),
              _buildDivider(),
              SizedBox(height: 20.h),
              _buildVisaTypeSection(),
              SizedBox(height: 20.h),
              _buildSuccessRateSection(),
              SizedBox(height: 20.h),
              _buildAdditionalOptionsSection(),
              SizedBox(height: 30.h),
              _buildFooterButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================= Helper Widgets ===================
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Filter Recommendations",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A237E),
          ),
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.close, size: 24.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey.withOpacity(0.2), thickness: 1);
  }

  Widget _buildVisaTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Visa Type", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black87,),),
        SizedBox(height: 10.h),
        Obx(() => Column(
          children: controller.visaTypes.keys.map((key) {
            return _buildCheckboxTile(
              title: key,
              value: controller.visaTypes[key]!,
              onChanged: (val) => controller.toggleVisaType(key),
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildSuccessRateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Success Rate", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black87,),),
        SizedBox(height: 10.h),
        Obx(() => Column(
          children: [
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor:AppColors.primary1,
                inactiveTrackColor: AppColors.grey_1,
                thumbColor: AppColors.primary1,
                overlayColor: AppColors.primary1.withOpacity(0.2),
                trackHeight: 4.h,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
              ),
              child: Slider(
                value: controller.successRate.value,
                min: 50,
                max: 100,
                divisions: 100,
                onChanged: (val) => controller.updateSuccessRate(val),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("50%", style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                  Text(
                    "${controller.successRate.value.toInt()}%",
                    style: TextStyle(
                        color: const Color(0xFF2848D7),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp),
                  ),
                  Text("100%", style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                ],
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildAdditionalOptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Text("Additional Options", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black87,)),
        SizedBox(height: 10.h),
        Obx(() => Column(
          children: controller.additionalOptions.keys.map((key) {
            return _buildCheckboxTile(
              title: key,
              value: controller.additionalOptions[key]!,
              onChanged: (val) => controller.toggleAdditionalOption(key),
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildFooterButtons() {
    return Column(
      children: [
        // Apply Button
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () {
              // Print selected filters
              print("=== Selected Filters ===");

              // Selected Visa Types
              controller.visaTypes.forEach((key, value) {
                if (value) print("Visa Type: $key");
              });

              // Selected Additional Options
              controller.additionalOptions.forEach((key, value) {
                if (value) print("Additional Option: $key");
              });

              // Success Rate
              print("Success Rate: ${controller.successRate.value.toInt()}%");
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber, // Orange/Yellow color from image
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 0,
            ),
            child: Text(
              "Apply Filters",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        // Clear Button
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () => controller.clearFilters(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300], // Grey color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 0,
            ),
            child: Text(
              "Clear Filters",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Reusable Checkbox Tile Widget
  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.h),
      child: Row(
        children: [
          SizedBox(
            height: 24.h,
            width: 24.w,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              side: BorderSide(color: Colors.grey, width: 1.5),
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}