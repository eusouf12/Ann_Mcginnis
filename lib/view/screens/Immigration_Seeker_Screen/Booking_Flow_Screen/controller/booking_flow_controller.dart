import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingFlowController extends GetxController {
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxList<String> selectedTimes = <String>[].obs;

  void changeDate(DateTime? date) {
    selectedDate.value = date;
  }

  String get formattedSelectedDate {
    if (selectedDate.value == null) return '';
    return DateFormat('yyyy-MM-dd').format(selectedDate.value!.toLocal());
  }
  void toggleTime(String time) {
    if (selectedTimes.contains(time)) {
      selectedTimes.remove(time);
    } else {
      selectedTimes.add(time);
    }
    print("Selected times: $selectedTimes");
  }

  void clearSelection() {
    selectedDate.value = null;
    selectedTimes.clear();
  }

  //======================= payment car selected type

  var selectedConsultationType = "".obs;
  var selectedPrice = "".obs;

  void selectConsultation(String type, String price) {
    selectedConsultationType.value = type;
    selectedPrice.value = price;
  }
}
