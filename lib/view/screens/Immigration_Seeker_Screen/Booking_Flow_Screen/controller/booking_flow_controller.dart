import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/app_routes/app_routes.dart';
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
    selectedTimes.clear();
    selectedTimes.add(time);
    debugPrint("Selected times: $selectedTimes");
  }

  void clearSelection() {
    selectedDate.value = DateTime.now();
    selectedTimes.clear();
    selectedConsultationType.value = "";
    selectedPrice.value = "";
  }

  //======================= payment car selected type

  var selectedConsultationType = "".obs;
  var selectedPrice = "".obs;

  void selectConsultation(String type, String price) {
    selectedConsultationType.value = type;
    selectedPrice.value = price;
  }
  String getBackendConsultationType(String selectedType) {
    String type = selectedType.toLowerCase();
    if (type.contains("video")) {
      return "video-call";
    }
    else if (type.contains("phone")) {
      return "phone-call";
    }
    else if (type.contains("person")) {
      return "in-person";
    }
    return type.trim().replaceAll(" ", "-");
  }

  // ============== book consultant ===========
  final isBookingLoading = false.obs;
  final rxBookingStatus = Status.loading.obs;

  void setBookingStatus(Status status) => rxBookingStatus.value = status;

  Future<void> bookConsultation({required String id, required String name, required String img, required String jobTitle,required String currency,required String discount,required String experience}) async {
    isBookingLoading.value = true;
    setBookingStatus(Status.loading);
    if (selectedDate.value == null) {
      showCustomSnackBar("Please select a consultation date", isError: true);
      return;
    }

    if (selectedTimes.isEmpty) {
      showCustomSnackBar("Please select a time slot", isError: true);
      return;
    }

    if (selectedConsultationType.value.isEmpty) {
      showCustomSnackBar("Please select a consultation type", isError: true);
      return;
    }

    try {

      final body = {
        "consultationDate": formattedSelectedDate,
        "consultationTime":selectedTimes.first,
        "consultationType": getBackendConsultationType(selectedConsultationType.value),
      };

      final response = await ApiClient.postData(ApiUrl.bookedConsultant(id: id), jsonEncode(body),);

      final jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {

        setBookingStatus(Status.completed);

        Get.offAllNamed(
          AppRoutes.bookingConfirmedScreen,
          arguments: {
            "consultantId": id,
            "consultantName": name,
            "consultantPhoto": img,
            "jobTitle": jobTitle,
            "consultationDate": formattedSelectedDate,
            "consultationTime": selectedTimes.first,
            "consultationType": getBackendConsultationType(selectedConsultationType.value),
            "consultationPrice": selectedPrice.value,
            "currency": currency,
            "discount": discount,
            "experience": experience,
          },
        );

        showCustomSnackBar(
          jsonResponse["message"] ?? "Consultation booked successfully",
          isError: false,
        );

      } else {
        setBookingStatus(Status.error);

        showCustomSnackBar(
          jsonResponse["message"] ?? "Failed to book consultation",
          isError: true,
        );
      }

    } catch (e) {

      setBookingStatus(Status.error);

      showCustomSnackBar(
        "Error: ${e.toString()}",
        isError: true,
      );

    } finally {
      isBookingLoading.value = false;
    }
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
