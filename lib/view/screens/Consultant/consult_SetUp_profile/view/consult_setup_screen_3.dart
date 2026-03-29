import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/consult_setup_controller.dart';
import '../widget/custom_progressbar.dart';
import 'consult_setup_screen_4.dart';

class ConsultSetupScreen3 extends StatefulWidget {
  const ConsultSetupScreen3({super.key});

  @override
  State<ConsultSetupScreen3> createState() => _ConsultSetupScreen3State();
}

class _ConsultSetupScreen3State extends State<ConsultSetupScreen3> {
  final ConsultSetupController controller = Get.put(ConsultSetupController());
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? selectedTimeZone = "GMT-8 (Pacific Time)";
  final List<String> timeZones = [
    "GMT-12 (Baker Island)",
    "GMT-11 (Samoa)",
    "GMT-10 (Hawaii)",
    "GMT-9 (Alaska)",
    "GMT-8 (Pacific Time)",
    "GMT-7 (Mountain Time)",
    "GMT-6 (Central Time)",
    "GMT-5 (Eastern Time)",
    "GMT-4 (Atlantic Time)",
    "GMT-3 (Brazil)",
    "GMT+0 (London/UTC)",
    "GMT+1 (Central Europe)",
    "GMT+2 (Eastern Europe)",
    "GMT+3 (Moscow/East Africa)",
    "GMT+4 (Gulf/UAE)",
    "GMT+5 (Pakistan)",
    "GMT+5:30 (India/IST)",
    "GMT+6 (Bangladesh/BST)",
    "GMT+7 (Indochina)",
    "GMT+8 (China/Singapore)",
    "GMT+9 (Japan/Korea)",
    "GMT+10 (Australian Eastern)",
    "GMT+12 (New Zealand)",
  ];
  bool isWeeklyView = true;

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
              text: "Step 3 of 4",
              fontSize: 14,
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10.h),
            // Progress Bar (Approx 50%)
            CustomProgressBar(factor: 0.75),
            SizedBox(height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CustomText(
                    text: "Set Your Availability",
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10.h),
                const Center(
                  child: CustomText(
                    text: "Configure your consultation hours and\n manage bookings",
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20.h),

                // Time Zone Dropdown
                const CustomText(text: "Time Zone", fontWeight: FontWeight.bold,color: Colors.black,),
                SizedBox(height: 8.h),
                _buildDropdown(),
                SizedBox(height: 20.h),
                // ======== week selected
                _buildWeeklyDaySelector(),
                SizedBox(height: 20.h),
                Obx(() => CustomText(
                  text: controller.selectedDays.isEmpty
                      ? "No days selected"
                      : "Selected: ${controller.selectedDays.join(', ')}",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                )),
                SizedBox(height: 25.h),

                const CustomText(text: "Preferred Time Slots", fontWeight: FontWeight.bold, color: Colors.black),
                SizedBox(height: 15.h),
                _buildTimeSlotList(),
                _buildAddTimeSlotBtn(context),



                SizedBox(height: 30.h),

                // Navigation Buttons
                CustomButton(
                  onTap: () {
                      Get.to(ConsultSetupScreen4());
                  },
                  title: "Save & Continue",
                  fillColor: AppColors.yellow1,
                  textColor: Colors.white,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //=============================== --- UI Helper Widgets ---
//timeZone
  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(() => DropdownButton<String>(
          isExpanded: true,
          value: controller.selectedTimeZone.value, // কন্ট্রোলার থেকে ভ্যালু নিচ্ছে
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.setTimeZone(newValue); // কন্ট্রোলারে আপডেট করছে
            }
          },
          items: timeZones.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(fontSize: 14.sp)),
            );
          }).toList(),
        )),
      ),
    );
  }

  // WeeklyDay
  Widget _buildWeeklyDaySelector() {
    final Map<String, String> dayShortNames = {
      "Monday": "Mon",
      "Tuesday": "Tue",
      "Wednesday": "Wed",
      "Thursday": "Thu",
      "Friday": "Fri",
      "Saturday": "Sat",
      "Sunday": "Sun",
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(text: "Select Available Days", fontWeight: FontWeight.bold, color: Colors.black),
        SizedBox(height: 15.h),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: controller.weekDays.map((String fullDayName) {
            // চেক করছি এই 'fullDayName' (যেমন: "Monday") লিস্টে আছে কি না
            bool isSelected = controller.selectedDays.contains(fullDayName);

            return GestureDetector(
              onTap: () {
                controller.toggleDay(fullDayName); // এখানে "Monday" ই যাবে
              },
              child: Container(
                width: 42.w,
                height: 42.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary1 : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary1 : Colors.grey.shade300,
                  ),
                  boxShadow: isSelected
                      ? [BoxShadow(color: AppColors.primary1.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 3))]
                      : [],
                ),
                child: Text(
                  dayShortNames[fullDayName] ?? fullDayName, // UI তে দেখাবে "Mon"
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildTimeSlotList() {
    return Obx(() => Column(
      children: List.generate(controller.preferredTimeSlots.length, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.preferredTimeSlots[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: () => controller.removeTimeSlot(index),
                ),
              ],
            ),
          ),
        );
      }),
    ));
  }

  Widget _buildAddTimeSlotBtn(BuildContext context) {
    return InkWell(
      onTap: () async {
        TimeOfDay? startTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          helpText: "Select Start Time",
        );

        if (startTime != null) {
          TimeOfDay? endTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute),
            helpText: "Select End Time",
          );

          if (endTime != null) {
            controller.addTimeSlot(startTime, endTime);
          }
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          // এখানে বর্ডারটি দেওয়া হয়েছে
          border: Border.all(
            color: Colors.blue.shade200,
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: Colors.blue, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              "Add Time Slot",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

}