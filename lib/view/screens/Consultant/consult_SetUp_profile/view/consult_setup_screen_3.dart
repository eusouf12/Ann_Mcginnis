import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart'; // table_calendar প্যাকেজটি ব্যবহার করুন

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
  final ConsultSetupController controller = Get.find<ConsultSetupController>();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
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
                _buildDropdown("GMT-8 (Pacific Time)"),
                SizedBox(height: 20.h),

                // Calendar Card
                _buildCalendarCard(),
                SizedBox(height: 20.h),

                // Legend (Available, Blocked, Selected)
                _buildLegend(),
                SizedBox(height: 25.h),

                // Selected Day Detail
                CustomText(
                  text: "Monday, January 15",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                SizedBox(height: 15.h),

                // Time Slots
                _buildTimeSlot("09:00 AM - 12:00 PM", "Morning Session"),
                SizedBox(height: 10.h),
                _buildTimeSlot("01:00 PM - 04:00 PM", "Afternoon Session"),

                SizedBox(height: 15.h),
                _buildAddTimeSlotBtn(),

                SizedBox(height: 30.h),
                const CustomText(text: "Quick Actions", fontWeight: FontWeight.bold,color: Colors.black,),
                SizedBox(height: 15.h),

                // Quick Action Cards
                Row(
                  children: [
                    Expanded(child: _buildQuickActionCard(Icons.calendar_month, "Set Weekly", "Mon-Fri pattern")),
                    SizedBox(width: 12.w),
                    Expanded(child: _buildQuickActionCard(Icons.block, "Block Dates", "Holidays & time off", iconColor: Colors.red)),
                  ],
                ),

                SizedBox(height: 25.h),
                _buildRecurringSwitch(),
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

  // --- UI Helper Widgets ---

  Widget _buildDropdown(String hint) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: TextStyle(fontSize: 14.sp)),
          items: const [],
          onChanged: (v) {},
        ),
      ),
    );
  }

  Widget _toggleItem(String label, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            label,
            style: TextStyle(color: isActive ? Colors.white : Colors.black54, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: CalendarFormat.month,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.rectangle),
          todayDecoration: BoxDecoration(color: Colors.blue.withOpacity(0.2), shape: BoxShape.rectangle),
          defaultTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(Colors.green.shade100, "Available", isBorder: true),
        SizedBox(width: 15.w),
        _legendItem(Colors.grey.shade300, "Blocked"),
        SizedBox(width: 15.w),
        _legendItem(Colors.blue, "Selected"),
      ],
    );
  }

  Widget _legendItem(Color color, String label, {bool isBorder = false}) {
    return Row(
      children: [
        Container(
          width: 16.w, height: 16.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
            border: isBorder ? Border.all(color: Colors.green) : null,
          ),
        ),
        SizedBox(width: 6.w),
        Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700)),
      ],
    );
  }

  Widget _buildTimeSlot(String time, String session) {
    return Container(
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
              Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(session, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
            ],
          ),
          const Icon(Icons.delete_outline, color: Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildAddTimeSlotBtn() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.blue.shade200, style: BorderStyle.solid),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.add, color: Colors.blue, size: 18),
          SizedBox(width: 5),
          Text("Add Time Slot", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(IconData icon, String title, String sub, {Color iconColor = Colors.blue}) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor),
          SizedBox(height: 8.h),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(sub, style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildRecurringSwitch() {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Recurring Availability", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Apply this schedule to all upcoming weeks", style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
            ],
          ),
          Switch(value: true, onChanged: (v) {}, activeColor: Colors.blue),
        ],
      ),
    );
  }
}