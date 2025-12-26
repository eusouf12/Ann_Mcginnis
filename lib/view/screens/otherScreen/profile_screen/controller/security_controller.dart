import 'package:get/get.dart';

class SecurityController extends GetxController {
  // Switch States
  RxBool twoFactorAuth = false.obs;
  RxBool saveLocally = false.obs;
  RxBool biometricUnlock = false.obs;
  RxBool pinEnabled = false.obs;

  // Toggle Functions
  void toggleTwoFactor(bool value) {
    twoFactorAuth.value = value;
    sendToBackend("two_factor_auth", value);
  }

  void toggleSaveLocally(bool value) {
    saveLocally.value = value;
    sendToBackend("save_locally", value);
  }

  void toggleBiometric(bool value) {
    biometricUnlock.value = value;
    sendToBackend("biometric_unlock", value);
  }

  void togglePin(bool value) {
    pinEnabled.value = value;
    sendToBackend("pin_enabled", value);
  }

  // Backend API Call
  void sendToBackend(String key, bool value) {
    print("Sending to backend: $key = $value");
  }

  void clearAllSwitches() {
    twoFactorAuth.value = false;
    saveLocally.value = false;
    biometricUnlock.value = false;
    pinEnabled.value = false;

    sendToBackend("two_factor_auth", false);
    sendToBackend("save_locally", false);
    sendToBackend("biometric_unlock", false);
    sendToBackend("pin_enabled", false);
  }

}
