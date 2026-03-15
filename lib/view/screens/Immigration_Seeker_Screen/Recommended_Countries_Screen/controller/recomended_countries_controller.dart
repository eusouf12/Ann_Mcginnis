import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../model/recommended_countries_model.dart';
import '../model/singel_country.dart';

class RecommendedCountriesController extends GetxController {
  // visa type
  var visaTypes = {
    "Work Visa": false,
    "Student Visa": false,
    "Family Visa": false,
    "Tourist Visa": false,
    "Entrepreneur Visa": false,
    "Retirement Visa": false,
    "Citizenship with descent": false,
    "Extraordinary talent.": false,
  }.obs;

  // Additional Options
  var additionalOptions = {
    "English speaking countries": false,
    "No interview required": false,
    "Fast track available": false,
  }.obs;

  // Slider State
  var successRate = 50.0.obs;

  // Toggle Visa Checkbox
  void toggleVisaType(String key) {
    visaTypes[key] = !visaTypes[key]!;
  }

  // Toggle Additional Option Checkbox
  void toggleAdditionalOption(String key) {
    additionalOptions[key] = !additionalOptions[key]!;
  }

  // Update Slider
  void updateSuccessRate(double value) {
    successRate.value = value;
  }

  // Clear Filters
  void clearFilters() {
    visaTypes.updateAll((key, value) => false);
    additionalOptions.updateAll((key, value) => false);
    successRate.value = 50.0;
  }

  var selectedTab = 0.obs;

  final List<String> tabs = [
    "Overview",
    "Visa Types",
    "Requirements",
    "Process",
  ];

  void changeTab(int index) {
    selectedTab.value = index;
  }

  //=========== Get Recommended Countries ===========
  RxList<CountryRecommendation> recommendedCountries = <CountryRecommendation>[].obs;

  final isRecommendedLoading = false.obs;
  final isRecommendedLoadMore = false.obs;
  final rxRecommendedStatus = Status.loading.obs;
  void setRecommendedStatus(Status status) => rxRecommendedStatus.value = status;
  int recommendedCurrentPage = 1;
  int recommendedTotalPages = 1;

  Future<void> getRecommendedCountries({bool loadMore = false}) async {

    if (loadMore) {
      if (isRecommendedLoadMore.value || recommendedCurrentPage >= recommendedTotalPages) {
        return;
      }
      isRecommendedLoadMore.value = true;
      recommendedCurrentPage++;
    }
    else {
      isRecommendedLoading.value = true;
      setRecommendedStatus(Status.loading);
      recommendedCurrentPage = 1;
      recommendedCountries.clear();
    }

    try {
      final response = await ApiClient.getData(ApiUrl.getRecommendedCountries(page: recommendedCurrentPage.toString()),);

      if (response.statusCode == 200 || response.statusCode == 201) {

        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final RecommendationResponse model =
        RecommendationResponse.fromJson(jsonResponse);
        recommendedTotalPages = model.data?.pagination?.totalPages ?? 1;
        final List<CountryRecommendation> newCountries =model.data?.recommendations?.first.results?.countries ?? [];
        final existingIds = recommendedCountries.map((e) => e.id).toSet();

        for (final item in newCountries) {
          if (!existingIds.contains(item.id)) {
            recommendedCountries.add(item);
          }
        }
        setRecommendedStatus(Status.completed);
      }
      else {
        setRecommendedStatus(Status.error);
        showCustomSnackBar("Failed to load recommended countries", isError: true,);
      }
    }
    catch (e) {
      setRecommendedStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);
    }
    finally {
      isRecommendedLoading.value = false;
      isRecommendedLoadMore.value = false;
    }
  }

  // ============ Single Country  ===========
  Rx<CountryDetails?> singleCountry = Rx<CountryDetails?>(null);
  final isSingleCountryLoading = false.obs;
  final rxSingleCountryStatus = Status.loading.obs;
  void setSingleCountryStatus(Status status) => rxSingleCountryStatus.value = status;

  Future<void> getSingleCountry({required String country}) async {
    isSingleCountryLoading.value = true;
    setSingleCountryStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.getSingleCountry( country: country));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final CountryDetailsResponse model = CountryDetailsResponse.fromJson(jsonResponse);

        singleCountry.value = model.data;

        setSingleCountryStatus(Status.completed);
      } else {
        setSingleCountryStatus(Status.error);
        showCustomSnackBar("Failed to load country details", isError: true,);
      }
    } catch (e) {
      setSingleCountryStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);
    } finally {
      isSingleCountryLoading.value = false;
    }
  }
// ============ Single Country  ===========
  final isSaveCountryLoading = false.obs;
  Future<void> saveCountry({required String id}) async {
    isSaveCountryLoading.value = true;

    try {

      final response = await ApiClient.postData(ApiUrl.saveCountry(id: id), null,);
      final Map<String, dynamic>  jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
          showCustomSnackBar(jsonResponse["message"] ?? "Saved successfully",isError: false);
      }
      else{
        showCustomSnackBar(jsonResponse["message"] ??"Failed to save country", isError: true,);
      }

    } catch (e) {
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);
    } finally {
      isSaveCountryLoading.value = false;

    }
  }

}