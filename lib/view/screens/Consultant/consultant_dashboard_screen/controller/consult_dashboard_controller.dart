import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../view/model/analytics_model.dart';
import '../view/model/appointment_model.dart';
import '../view/model/booking_trend_model.dart';
import '../view/model/eraning_model.dart';

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

  // ============= Earning Trend ============

  RxList<EarningItem> earningsTrendList = <EarningItem>[].obs;
  final isEarningsTrendLoading = false.obs;
  final rxEarningsTrendStatus = Status.loading.obs;
  void setEarningsTrendStatus(Status status) => rxEarningsTrendStatus.value = status;

  Future<void> getEarningsTrend() async {

    isEarningsTrendLoading.value = true;
    setEarningsTrendStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.earningTrend);

      final Map<String, dynamic> jsonResponse =
      response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {

        final EarningsTrendResponse model = EarningsTrendResponse.fromJson(jsonResponse);

        earningsTrendList.value = model.data?.earningsTrend ?? [];
        setEarningsTrendStatus(Status.completed);

      } else {
        setEarningsTrendStatus(Status.error);
        showCustomSnackBar(jsonResponse["message"] ?? "Failed to load earnings trend", isError: true,);
      }
    } catch (e) {
      setEarningsTrendStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);

    } finally {
      isEarningsTrendLoading.value = false;
    }
  }

  // ========== BOOKING TREND ==========
  RxList<BookingTrendItem> bookingTrendList = <BookingTrendItem>[].obs;
  final isBookingTrendLoading = false.obs;
  final rxBookingTrendStatus = Status.loading.obs;
  void setBookingTrendStatus(Status status) => rxBookingTrendStatus.value = status;

  Future<void> getBookingTrend() async {
    isBookingTrendLoading.value = true;
    setBookingTrendStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.bookingTrend);

      final Map<String, dynamic> jsonResponse =
      response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {

        final BookingTrendResponse model = BookingTrendResponse.fromJson(jsonResponse);

        bookingTrendList.value = model.data?.bookingTrend ?? [];
        setBookingTrendStatus(Status.completed);

      } else {
        setBookingTrendStatus(Status.error);
        showCustomSnackBar(jsonResponse["message"] ?? "Failed to load booking trend", isError: true,);
      }

    } catch (e) {
      setBookingTrendStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);

    } finally {
      isBookingTrendLoading.value = false;
    }
  }
 
 // ================== CANCEL APPOINTMENT ==================
  final isCancelAppointmentLoading = false.obs;
  final rxCancelAppointmentStatus = Status.loading.obs;
  void setCancelAppointmentStatus(Status status) => rxCancelAppointmentStatus.value = status;

  Future<void> cancelAppointment({required String appointmentId}) async {
    isCancelAppointmentLoading.value = true;
    setCancelAppointmentStatus(Status.loading);

    try {
      Map<String, String> body = {
        "action": "reject",
      };
      final response = await ApiClient.patchData(ApiUrl.cancelAppointment(id: appointmentId),jsonEncode(body));

      final Map<String, dynamic> jsonResponse =
      response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setCancelAppointmentStatus(Status.completed);
        await getAllAppointments();
        showCustomSnackBar(jsonResponse["message"] ?? "Appointment cancelled successfully");
      } else {
        setCancelAppointmentStatus(Status.error);
        showCustomSnackBar(jsonResponse["message"] ?? "Failed to cancel appointment", isError: true,);
      }

    } catch (e) {
      setCancelAppointmentStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);

    } finally {
      isCancelAppointmentLoading.value = false;
    }
  }
 
 // ================== CONFIRM APPOINTMENT ==================
  final isConfirmAppointmentLoading = false.obs;
  final rxConfirmAppointmentStatus = Status.loading.obs;
  void setConfirmAppointmentStatus(Status status) => rxConfirmAppointmentStatus.value = status;

  Future<void> confirmAppointment({required String appointmentId}) async {
    isConfirmAppointmentLoading.value = true;
    setConfirmAppointmentStatus(Status.loading);

    try {
      Map<String, String> body = {
        "action": "accept",
      };
      final response = await ApiClient.patchData(ApiUrl.confirmAppointment(id: appointmentId), jsonEncode(body));

      final Map<String, dynamic> jsonResponse =response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setConfirmAppointmentStatus(Status.completed);
        await getAllAppointments();
        showCustomSnackBar(jsonResponse["message"] ?? "Appointment confirmed successfully");
      } else {
        setConfirmAppointmentStatus(Status.error);
        showCustomSnackBar(jsonResponse["message"] ?? "Failed to confirm appointment", isError: true,);
      }

    } catch (e) {
      setConfirmAppointmentStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);

    } finally {
      isConfirmAppointmentLoading.value = false;
    }
  }
}