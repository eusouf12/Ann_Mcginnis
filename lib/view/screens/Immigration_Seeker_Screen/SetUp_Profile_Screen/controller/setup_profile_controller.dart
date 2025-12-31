import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetupProfileController extends GetxController {
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
  var selectedCertificate = "".obs;

  final RxList<String> certificates = <String>[
    "Aws Certified Solutions Architect",
    "Google Analytics Certified",
    "Magna Cum Laude",
    "Project Management Professional",
  ].obs;

  final TextEditingController certificateController = TextEditingController();

  void addCertificate(String value) {
    if (value.isNotEmpty && !certificates.contains(value)) {
      certificates.add(value);
      selectedCertificate.value = value;
    }
  }

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
  var hasCriminalHistory = "".obs;

  // ================= Step 5: Financial Information Variables =================
  final netWorthController = TextEditingController();
  var selectedDuration = Rxn<String>();
  var isRetired = false.obs;
  var hasBusinessExperience = false.obs;
  var selectedAchievements = <String>[].obs;

  // Duration List
  final List<String> durationList = [
    "Less than 1 year",
    "1-3 years",
    "3-5 years",
    "More than 5 years",
    "Permanent"
  ];

  // Achievements List
  final List<String> achievementList = [
    "International Sports Competition",
    "Internationally Acclaimed Research",
    "International Awards",
    "Published Author"
  ];

  // Achievement Toggle Function
  void toggleAchievement(String achievement) {
    if (selectedAchievements.contains(achievement)) {
      selectedAchievements.remove(achievement);
    } else {
      selectedAchievements.add(achievement);
    }
  }

// ================= Step 6: Pet Information Variables =================
  var isTravelingWithPets = false.obs; // Switch value
  var selectedPetType = Rxn<String>(); // Dropdown value
  var numberOfPets = 1.obs; // Counter value
  final petDetailsController = TextEditingController(); // Text area

  // Pet Types List
  final List<String> petTypes = [
    "Dog",
    "Cat",
    "Bird",
    "Rabbit",
    "Other"
  ];

  // Counter Methods
  void incrementPets() {
    if (numberOfPets.value < 10) {
      numberOfPets.value++;
    }
  }

  void decrementPets() {
    if (numberOfPets.value > 1) {
      numberOfPets.value--;
    }
  }

}