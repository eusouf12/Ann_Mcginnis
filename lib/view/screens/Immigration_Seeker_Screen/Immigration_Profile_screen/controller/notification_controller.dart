import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxBool generalNotification = true.obs;
  RxBool soundNotification = true.obs;
  RxBool vibrateNotification = true.obs;

  // General toggle
  void toggleGeneral(bool value) {
    generalNotification.value = value;
    updateBackend("general", value);
  }

  // Sound toggle
  void toggleSound(bool value) {
    soundNotification.value = value;
    updateBackend("sound", value);
  }

  // Vibrate toggle
  void toggleVibrate(bool value) {
    vibrateNotification.value = value;
    updateBackend("vibrate", value);
  }

  // API Call
  void updateBackend(String key, bool value) {
    print("Sending → $key : $value");
  }
}
