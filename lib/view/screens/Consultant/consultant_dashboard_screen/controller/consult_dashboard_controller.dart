import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../view/model/analytics_model.dart';
import '../view/model/appointment_model.dart';

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

  // ========== ALL APPOINTMENTS ==========
  RxList<Appointment> appointmentList = <Appointment>[].obs;
  final isAppointmentLoading = false.obs;
  final isAppointmentLoadMore = false.obs;
  final rxAppointmentStatus = Status.loading.obs;
  void setAppointmentStatus(Status status) => rxAppointmentStatus.value = status;

  int appointmentCurrentPage = 1;
  int appointmentTotalPages = 1;

  Future<void> getAllAppointments({bool loadMore = false}) async {
    if (loadMore) {
      if (isAppointmentLoadMore.value ||
          appointmentCurrentPage >= appointmentTotalPages) return;

      isAppointmentLoadMore.value = true;
      appointmentCurrentPage++;

    }
    else {
      isAppointmentLoading.value = true;
      setAppointmentStatus(Status.loading);
      appointmentCurrentPage = 1;
      appointmentList.clear();
    }

    try {
      final response = await ApiClient.getData(ApiUrl.allAppointments(page: appointmentCurrentPage.toString()));

      final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {

        final AppointmentResponse model = AppointmentResponse.fromJson(jsonResponse);
        appointmentTotalPages = model.data?.pagination?.pages ?? 1;
        final List<Appointment> newData = model.data?.bookings ?? [];
        final existingIds = appointmentList.map((e) => e.id).toSet();

        for (final item in newData) {
          if (!existingIds.contains(item.id)) {
            appointmentList.add(item);
          }
        }
        setAppointmentStatus(Status.completed);

      } else {
        setAppointmentStatus(Status.error);
        showCustomSnackBar(jsonResponse["message"] ?? "Failed to load appointments", isError: true,);
      }

    } catch (e) {
      setAppointmentStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);

    } finally {
      isAppointmentLoading.value = false;
      isAppointmentLoadMore.value = false;
    }
  }
}