import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class BookingController extends GetxController {
  // বর্তমানে সিলেক্ট করা ডেটগুলো রাখার জন্য
  var selectedDates = <DateTime>{}.obs;

  // কনসালট্যান্টের অ্যাভেইলএবল এবং শিডিউলড/ব্লকড ডেট
  var availableDays = <DateTime>[].obs;
  var scheduledDays = <DateTime>[].obs;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    DateTime day = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);

    if (selectedDates.contains(day)) {
      selectedDates.remove(day);
    } else {
      selectedDates.add(day);
    }
  }

  // সিলেক্ট করা ডেটগুলোকে 'Available' (সবুজ) করা
  void addTimeToSelectedDates() {
    if (selectedDates.isNotEmpty) {
      // যদি আগে থেকেই শিডিউলড লিস্টে থাকে তবে তা সরিয়ে ফেলা
      scheduledDays.removeWhere((date) => selectedDates.contains(date));
      availableDays.addAll(selectedDates);
      selectedDates.clear();
      Get.snackbar("Success", "Time added to selected dates.",
          backgroundColor: Colors.green.withOpacity(0.7), colorText: Colors.white);
    } else {
      Get.snackbar("Alert", "Please select dates first.");
    }
  }

  // সিলেক্ট করা ডেটগুলোকে 'Blocked/Scheduled' (হলুদ) করা
  void blockOutSelectedDates() {
    if (selectedDates.isNotEmpty) {
      // যদি আগে থেকেই অ্যাভেইলএবল লিস্টে থাকে তবে তা সরিয়ে ফেলা
      availableDays.removeWhere((date) => selectedDates.contains(date));
      scheduledDays.addAll(selectedDates);
      selectedDates.clear();
      Get.snackbar("Blocked", "Selected dates have been blocked.",
          backgroundColor: Colors.orangeAccent, colorText: Colors.white);
    }
  }
}