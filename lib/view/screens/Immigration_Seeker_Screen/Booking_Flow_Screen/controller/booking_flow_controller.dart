import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../Recommended_dashboard_Screen/model/single_consultation.dart';

class BookingFlowController extends GetxController {
  Rx<DateTime?> selectedDate = Rx<DateTime?>(DateTime.now());
  RxList<String> selectedTimes = <String>[].obs;

  void changeDate(DateTime? date) {
    if (date != null) {
      selectedDate.value = date;
      selectedTimes.clear();
      debugPrint("Date changed to: ${formattedSelectedDate}, Selection cleared.");
    }
  }

  bool isAvailableOnSelectedDay(List<String>? recurringDays) {
    if (selectedDate.value == null || recurringDays == null) return false;
    String currentDayName = DateFormat('EEEE').format(selectedDate.value!);
    return recurringDays.contains(currentDayName);
  }

  String get formattedSelectedDate {
    if (selectedDate.value == null) return 'No date selected';
    return DateFormat('yyyy-MM-dd').format(selectedDate.value!.toLocal());
  }


  void toggleTime(String time) {
    if (selectedTimes.contains(time)) {
      selectedTimes.remove(time);
    } else {
      // selectedTimes.clear();
      selectedTimes.add(time);
    }
    debugPrint("Selected times: $selectedTimes");
  }

  void clearSelection() {
    selectedDate.value = DateTime.now();
    selectedTimes.clear();
  }

  //======================= payment car selected type

  var selectedConsultationType = "".obs;
  var selectedPrice = "".obs;

  void selectConsultation(String type, String price) {
    selectedConsultationType.value = type;
    selectedPrice.value = price;
  }

  // ============== Single Consultant==================
  Rx<ConsultantDetails?> singleConsultant = Rx<ConsultantDetails?>(null);
  final isSingleConsultantLoading = false.obs;
  final rxSingleConsultantStatus = Status.loading.obs;
  void setSingleConsultantStatus(Status status) => rxSingleConsultantStatus.value = status;

  Future<void> getSingleConsultant({required String id}) async {

    isSingleConsultantLoading.value = true;
    setSingleConsultantStatus(Status.loading);

    try {

      final response = await ApiClient.getData(ApiUrl.getSingleConsultant(id: id));

      if (response.statusCode == 200 || response.statusCode == 201) {

        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final ConsultantDetailsResponse model = ConsultantDetailsResponse.fromJson(jsonResponse);
        singleConsultant.value = model.data;
        setSingleConsultantStatus(Status.completed);

      } else {
        setSingleConsultantStatus(Status.error);
        showCustomSnackBar("Failed to load consultant details", isError: true,);
      }

    } catch (e) {
      setSingleConsultantStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);

    } finally {
      isSingleConsultantLoading.value = false;

    }
  }
}
