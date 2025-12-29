import 'package:get/get.dart';

class BookingFlowController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedTime = "".obs;

  void changeDate(DateTime date) {
    selectedDate.value = date;
    print("Selected date: $date");
  }

  void selectTime(String time) {
    selectedTime.value = time;
  }
}
