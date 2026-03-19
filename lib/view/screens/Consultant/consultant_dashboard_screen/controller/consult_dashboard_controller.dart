import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../view/model/analytics_model.dart';

class ConsultDashboardController extends GetxController {
  //tab Bar
  var selectedConsultantDashboardTab = 0.obs;
  final List<String> tabs = [
    "Dashboard",
    "Appoinments",
    "Earnings",
    "Calendar",
  ];
  void changeTab(int index) {
    selectedConsultantDashboardTab.value = index;
  }
  var successConsultantScoreRate = 50.0.obs;

  // =========== dashboard analytics ==========
  final isBookingSummaryLoading = false.obs;
  final rxBookingSummaryStatus = Status.loading.obs;

  void setBookingSummaryStatus(Status status) => rxBookingSummaryStatus.value = status;

  Rx<BookingSummary?> bookingSummary = Rx<BookingSummary?>(null);

  Future<void> getBookingSummary() async {
    isBookingSummaryLoading.value = true;
    setBookingSummaryStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.consultantAnalytics,);

      final Map<String, dynamic> jsonResponse =
      response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        bookingSummary.value = BookingSummary.fromJson(jsonResponse['data']);
        setBookingSummaryStatus(Status.completed);

      } else {
        setBookingSummaryStatus(Status.error);
        showCustomSnackBar(jsonResponse["message"] ?? "Failed to load booking summary", isError: true,);
      }

    } catch (e) {
      setBookingSummaryStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);

    } finally {
      isBookingSummaryLoading.value = false;
    }
  }
}