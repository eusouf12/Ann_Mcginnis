import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ConsultSetupController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      debugPrint("Gallery Image Path: ${image.path}");
    }
  }
  //Pick image from camera
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  // Step 1 Controllers
  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final jobTitleController = TextEditingController().obs;
  final profileDescriptionController = TextEditingController().obs;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return "This field is required";
    return null;
  }
  RxList<String> selectedAchievements = <String>[].obs;

  final List<String> achievements = [
    "International Sports Competition",
    "Internationally Acclaimed Research",
    "International Awards",
    "Published Author",
  ];

  void toggleAchievement(String value) {
    if (selectedAchievements.contains(value)) {
      debugPrint("Removed: $value");
      selectedAchievements.remove(value);
    } else {
      selectedAchievements.add(value);
      debugPrint("Added: $value");
    }
  }

  // Step 2 Controllers
  RxList<Map<String, dynamic>> documents = <Map<String, dynamic>>[
    {'title': "Professional License", 'file': Rx<File?>(null)},
    {'title': "Certifications(Optional)", 'file': Rx<File?>(null)},
  ].obs;

  /// Pick file
  Future<void> pickDocument(int index) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.single.path != null) {
        documents[index]['file'].value = File(result.files.single.path!);
        debugPrint("Picked: ${result.files.single.name}");
      }
    } catch (e) {
      debugPrint("File pick error: $e");
    }
  }

  /// Add more documents
  void addMoreDocument() {
    documents.add({
      'title': "Additional Document ${documents.length + 1}",
      'file': Rx<File?>(null),
    });
  }



  final RxList<String> certificates = <String>[
    "Aws Certified Solutions Architect",
    "Google Analytics Certified",
    "Magna Cum Laude",
    "Project Management Professional",
  ].obs;

  final TextEditingController certificateController = TextEditingController();



  // ================= Step 3: Career Information Variables =================
  var currentOccupation = Rxn<String>();
  var remoteWorkStatus = "No".obs;
  var selectedCareerFields = <String>[].obs;
  var hasManagementExperience = false.obs;
  final workHistoryController = TextEditingController();

  final List<String> occupationList = [
    "Student",
    "Employed",
    "Self-Employed",
    "Unemployed",
    "Retired",
    "Other"
  ];

  // CareerList
  final List<String> careerFieldsList = [
    "Agriculture, Food & Natural Resources",
    "Arts, A/V Tech & Communications",
    "Business Management & Admin",
    "Education & Training",
    "Finance",
    "Health Science",
    "Information Technology",
    "Law, Public Safety, & Corrections",
    "Manufacturing",
    "Science, Technology, Engineering & Math (STEM)",
    "Transportation, Distribution & Logistics",
    "Other"
  ];

  void toggleCareerField(String field) {
    if (selectedCareerFields.contains(field)) {
      selectedCareerFields.remove(field);
    } else {
      selectedCareerFields.add(field);
    }
  }

  // ================= Step 4: Criminal History Variables =================
  RxBool isCallChecked = false.obs;

  void callToggle(bool? value) {
    isCallChecked.value = value ?? false;
  }



}