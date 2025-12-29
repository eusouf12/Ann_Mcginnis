import 'package:get/get.dart';

class UserDashboardController extends GetxController {
  //tab Bar
  var selectedDashboardTab = 0.obs;
  final List<String> tabs = [
    "Profile",
    "Consultations",
    "Saved Countries",
    "Payments",
  ];
  void changeTab(int index) {
    selectedDashboardTab.value = index;
  }

  //progress bar
// Slider State
  var successScoreRate = 50.0.obs;
}