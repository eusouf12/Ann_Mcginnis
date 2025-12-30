import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetupProfileController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      debugPrint("Gallery Image Path: ${image.path}");
    }
  }

  /// Pick image from camera
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  // Step 1 Controllers
  final fullNameController = TextEditingController().obs;
  var selectedAgeRange = "".obs;
  var selectedCountry = "".obs;

  final List<String> ageRanges = ["10-15","16-25", "26-35", "36-45", "46+"];

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return "This field is required";
    return null;
  }

  // Step 2 Controllers
  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final fieldOfStudyController = TextEditingController().obs;
  final graduationYearController = TextEditingController().obs;
  final achievementsController = TextEditingController().obs;
}