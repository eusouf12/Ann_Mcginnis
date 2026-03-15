import 'dart:convert';
import 'package:get/get.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../model/all_consultation.dart';
import '../model/booking_consultaion.dart' hide Consultant;
import '../model/save_country_model.dart';

class UserDashboardController extends GetxController {
  //tab Bar
  var selectedDashboardTab = 0.obs;
  final List<String> tabs = [
    "Profile",
    "Consultations",
    "My Booked\n Consultants",
    "Saved \nCountries",
    "Payments",
  ];
  void changeTab(int index) {
    selectedDashboardTab.value = index;
  }
  //progress bar
// Slider State
  var successScoreRate = 50.0.obs;



  // // =========== Consultant ==========
  RxList<Consultant> consultantList = <Consultant>[].obs;

  final isConsultantLoading = false.obs;
  final isConsultantLoadMore = false.obs;
  final rxConsultantStatus = Status.loading.obs;
  void setConsultantStatus(Status status) => rxConsultantStatus.value = status;
  int consultantCurrentPage = 1;
  int consultantTotalPages = 1;
  Future<void> getConsultants({bool loadMore = false}) async {

    if (loadMore) {
      if (isConsultantLoadMore.value || consultantCurrentPage >= consultantTotalPages) return;

      isConsultantLoadMore.value = true;
      consultantCurrentPage++;

    }
    else {

      isConsultantLoading.value = true;
      setConsultantStatus(Status.loading);

      consultantCurrentPage = 1;
      consultantList.clear();
    }
    try {
      final response = await ApiClient.getData(ApiUrl.getConsultants(page: consultantCurrentPage.toString()),);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse =
        response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final ConsultantResponse model = ConsultantResponse.fromJson(jsonResponse);
        consultantTotalPages = model.data?.pagination?.pages ?? 1;
        final List<Consultant> newConsultants = model.data?.consultants ?? [];
        final existingIds = consultantList.map((e) => e.id).toSet();
        for (final item in newConsultants) {
          if (!existingIds.contains(item.id)) {
            consultantList.add(item);
          }
        }
        setConsultantStatus(Status.completed);
      } else {
        setConsultantStatus(Status.error);
        showCustomSnackBar("Failed to load consultants", isError: true,);
      }

    } catch (e) {
      setConsultantStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);

    } finally {

      isConsultantLoading.value = false;
      isConsultantLoadMore.value = false;

    }
  }

//===== ===========Booked Consultant ==============
  RxList<Booking> bookedConsultants = <Booking>[].obs;
  final isBookedLoading = false.obs;
  final isBookedLoadMore = false.obs;
  final rxBookedStatus = Status.loading.obs;
  void setBookedStatus(Status status) => rxBookedStatus.value = status;
  int bookedCurrentPage = 1;
  int bookedTotalPages = 1;

  Future<void> getBookedConsultants({bool loadMore = false}) async {

    if (loadMore) {
      if (isBookedLoadMore.value || bookedCurrentPage >= bookedTotalPages) return;

      isBookedLoadMore.value = true;
      bookedCurrentPage++;

    }
    else {
      isBookedLoading.value = true;
      setBookedStatus(Status.loading);

      bookedCurrentPage = 1;
      bookedConsultants.clear();
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getBookedConsultants(page: bookedCurrentPage.toString()),);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final BookingResponse model =
        BookingResponse.fromJson(jsonResponse);

        bookedTotalPages = model.data?.pagination?.pages ?? 1;

        final List<Booking> newBookings = model.data?.bookings ?? [];

        final existingIds = bookedConsultants.map((e) => e.id).toSet();
        for (final item in newBookings) {
          if (!existingIds.contains(item.id)) {
            bookedConsultants.add(item);
          }
        }
        setBookedStatus(Status.completed);

      } else {
        setBookedStatus(Status.error);
        showCustomSnackBar("Failed to load bookings", isError: true,);
      }

    } catch (e) {
      setBookedStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);
    } finally {
      isBookedLoading.value = false;
      isBookedLoadMore.value = false;

    }
  }

  // ========== save country =============

  RxList<SavedCountry> savedCountryList = <SavedCountry>[].obs;
  final isSavedCountryLoading = false.obs;
  final isSavedCountryLoadMore = false.obs;
  final rxSavedCountryStatus = Status.loading.obs;
  void setSavedCountryStatus(Status status) => rxSavedCountryStatus.value = status;
  int savedCountryCurrentPage = 1;
  int savedCountryTotalPages = 1;

  Future<void> getSaveCountry({bool loadMore = false}) async {

    if (loadMore) {
      if (isSavedCountryLoadMore.value || savedCountryCurrentPage >= savedCountryTotalPages) return;
      isSavedCountryLoadMore.value = true;
      savedCountryCurrentPage++;

    }
    else {

      isSavedCountryLoading.value = true;
      setSavedCountryStatus(Status.loading);

      savedCountryCurrentPage = 1;
      savedCountryList.clear();
    }
    try {
      final response = await ApiClient.getData(ApiUrl.getSaveCountry(page: savedCountryCurrentPage.toString()),);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);
        final SavedCountriesResponse model = SavedCountriesResponse.fromJson(jsonResponse);
        savedCountryTotalPages = model.data?.pagination?.totalPages ?? 1;
        final List<SavedCountry> newCountries = model.data?.savedCountries ?? [];
        final existingIds = savedCountryList.map((e) => e.id).toSet();

        for (final item in newCountries) {
          if (!existingIds.contains(item.id)) {
            savedCountryList.add(item);
          }
        }

        setSavedCountryStatus(Status.completed);

      } else {
        setSavedCountryStatus(Status.error);
        showCustomSnackBar("Failed to load saved countries", isError: true,);
      }

    } catch (e) {
      setSavedCountryStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);

    } finally {
      isSavedCountryLoading.value = false;
      isSavedCountryLoadMore.value = false;

    }
  }

  // =========== saved country deleted ==========
  final isDeleteSaveCountryLoading = false.obs;
  Future<void> deleteSaveCountry({required String id}) async {
    isDeleteSaveCountryLoading.value = true;
    try {
      final response = await ApiClient.deleteData(ApiUrl.deleteCountry(id: id),);

      final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        savedCountryList.removeWhere((item) => item.id == id);
        showCustomSnackBar(jsonResponse["message"] ?? "Removed successfully", isError: false,);

      } else {
        showCustomSnackBar(jsonResponse["message"] ?? "Failed to remove", isError: true,);
      }

    } catch (e) {
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);

    } finally {
      isDeleteSaveCountryLoading.value = false;

    }
  }


}