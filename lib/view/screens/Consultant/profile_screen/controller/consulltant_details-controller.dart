import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultantDetailsController extends GetxController {
  // Text Controllers
  final bioController = TextEditingController();
  final specializationInputController = TextEditingController();
  final priceController = TextEditingController(text: "100");

  // Reactive Variables
  var selectedCurrency = "USD".obs;
  var specializationList = <String>["Visa Consulting", "Work Permits"].obs;

  // Fake Data for Documents
  var documentList = <Map<String, dynamic>>[
    {
      "name": "Immigration License.pdf",
      "date": "Dec 10, 2024",
      "type": "pdf"
    },
    {
      "name": "Certificate.jpg",
      "date": "Dec 8, 2024",
      "type": "image"
    }
  ].obs;

  // Actions
  void addSpecialization() {
    if (specializationInputController.text.isNotEmpty) {
      specializationList.add(specializationInputController.text);
      specializationInputController.clear();
    }
  }

  void removeSpecialization(int index) {
    specializationList.removeAt(index);
  }

  void removeDocument(int index) {
    documentList.removeAt(index);
  }

  void saveChanges() {
    Get.snackbar("Success", "Profile Updated Successfully",
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    bioController.dispose();
    specializationInputController.dispose();
    priceController.dispose();
    super.onClose();
  }
}