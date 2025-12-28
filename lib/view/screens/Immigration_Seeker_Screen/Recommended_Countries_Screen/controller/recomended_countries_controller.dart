import 'package:get/get.dart';

class RecommendedCountriesController extends GetxController {
  // visa type
  var visaTypes = {
    "Work Visa": false,
    "Student Visa": false,
    "Family Visa": false,
    "Tourist Visa": false,
  }.obs;

  // Additional Options
  var additionalOptions = {
    "English speaking countries": false,
    "No interview required": false,
    "Fast track available": false,
  }.obs;

  // Slider State
  var successRate = 75.0.obs;

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
}