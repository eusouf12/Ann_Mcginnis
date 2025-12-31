import 'package:get/get.dart';

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

  //progress bar
// Slider State
  var successConsultantScoreRate = 50.0.obs;
}