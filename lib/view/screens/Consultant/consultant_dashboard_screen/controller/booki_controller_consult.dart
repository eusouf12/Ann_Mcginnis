import 'dart:convert';

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../view/model/book_calender_model.dart';

class BookingController extends GetxController {
  var selectedDates = <DateTime>{}.obs;

  var availableDays = <DateTime>[].obs;
  var scheduledDays = <DateTime>[].obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    DateTime day = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);

    if (selectedDates.contains(day)) {
      selectedDates.remove(day);
    } else {
      selectedDates.add(day);
    }
  }


  void addTimeToSelectedDates() {
    if (selectedDates.isNotEmpty) {
      scheduledDays.removeWhere((date) => selectedDates.contains(date));
      availableDays.addAll(selectedDates);
      selectedDates.clear();
      Get.snackbar("Success", "Time added to selected dates.",
          backgroundColor: Colors.green.withOpacity(0.7), colorText: Colors.white);
    } else {
      Get.snackbar("Alert", "Please select dates first.");
    }
  }


  void blockOutSelectedDates() {
    if (selectedDates.isNotEmpty) {
      availableDays.removeWhere((date) => selectedDates.contains(date));
      scheduledDays.addAll(selectedDates);
      selectedDates.clear();
      Get.snackbar("Blocked", "Selected dates have been blocked.",
          backgroundColor: Colors.orangeAccent, colorText: Colors.white);
    }
  }

  // ================= show calender data ================
// ========== BOOKED DATES ==========

  RxList<BookedDate> bookedDatesList = <BookedDate>[].obs;

  final isBookedDatesLoading = false.obs;
  final rxBookedDatesStatus = Status.loading.obs;

  void setBookedDatesStatus(Status status) => rxBookedDatesStatus.value = status;

  Future<void> getBookedDates({required int year, required int month,}) async {

    isBookedDatesLoading.value = true;
    setBookedDatesStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.myBookingCalender(year: year.toString(), month: month.toString(),),
      );

      final Map<String, dynamic> jsonResponse =
      response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {

        final BookedDatesResponse model = BookedDatesResponse.fromJson(jsonResponse);

        bookedDatesList.value = model.data?.bookedDates ?? [];
        setBookedDatesStatus(Status.completed);

      } else {
        setBookedDatesStatus(Status.error);
        showCustomSnackBar(jsonResponse["message"] ?? "Failed to load booked dates", isError: true,);
      }

    } catch (e) {
      setBookedDatesStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);
    } finally {
      isBookedDatesLoading.value = false;
    }
  }

}