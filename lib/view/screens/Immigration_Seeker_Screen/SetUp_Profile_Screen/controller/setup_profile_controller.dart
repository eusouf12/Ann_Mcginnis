import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';

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
  final nationalityController = TextEditingController().obs;
  var selectedEnglishProficiency = "".obs;
  var selectedIeltsScore = TextEditingController().obs;
  var selectedToeflScore = TextEditingController().obs;

  final List<String> englishProficiencyRanges = ["basic","conversational", "fluent", "native", "Advanced"];

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return "This field is required";
    return null;
  }
  String? validateIeltsScore(String value) {

    if (value.isEmpty) {
      return "Please enter IELTS score";
    }

    final score = double.tryParse(value);

    if (score == null) {
      return "Enter a valid number";
    }

    if (score < 0 || score > 9) {
      return "IELTS score must be between 0 and 9";
    }

    return null;
  }
  String? validateToeflScore(String value) {

    if (value.isEmpty) {
      return "Please enter TOEFL score";
    }

    final score = int.tryParse(value);

    if (score == null) {
      return "Enter a valid number";
    }

    if (score < 0 || score > 120) {
      return "TOEFL score must be between 0 and 120";
    }

    return null;
  }

  // Step 2 Controllers
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
  var selectedTotalWorkExperienceYears = TextEditingController().obs;

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
  var hasCriminalHistory = "No".obs;
  var hasCriminalHistoryResolved = "".obs;
  var selectedSeverity = "".obs;
  final List<String> severityRanges = ["minor","moderate", "serious",];

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
    "Dogs",
    "Cats",
    "Birds",
    "Rabbits",
    "Small Animals",
    "Fish",
    "Invertebrates",
    "Livestock"
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

  //=========== Set Profile ==============
  final isSetupProfileLoading = false.obs;
  final rxSetupProfileStatus = Status.loading.obs;
  void setSetupProfileStatus(Status status) => rxSetupProfileStatus.value = status;

  Future<void> setupUserProfile() async {

    isSetupProfileLoading.value = true;
    setSetupProfileStatus(Status.loading);

    try {

      Map<String, dynamic> body = {

        "nationality": nationalityController.value.text.trim(),
        "fieldOfStudy": fieldOfStudyController.value.text.trim(),
        "yearOfGraduation": int.tryParse(graduationYearController.value.text) ?? 0,
        "certifications": selectedCertificate.value,
        "englishProficiency": selectedEnglishProficiency.value,
        "ieltsScore": double.tryParse(selectedIeltsScore.value.text) ?? 0,
        "toeflScore": int.tryParse(selectedToeflScore.value.text) ?? 0,
        "criminalHistory": {
          "hasRecord": hasCriminalHistory.value == "Yes",
          "severity": hasCriminalHistory.value == "Yes" ? selectedSeverity.value : null,
          "resolved": hasCriminalHistory.value == "Yes" ? (hasCriminalHistoryResolved.value == "Yes") : null,
        },
        "currentOccupation": currentOccupation.value ?? "",
        "remoteWorkStatus": remoteWorkStatus.value == "Yes",
        "careerFields": selectedCareerFields,
        "hasManagementExperience": hasManagementExperience.value,
        "totalWorkExperienceYears": int.tryParse(selectedTotalWorkExperienceYears.value.text) ?? 0,
        "workHistoryNotes": workHistoryController.text,
        "netWorth": int.tryParse(netWorthController.text) ?? 0,
        "lengthOfStay": selectedDuration.value ?? "",
        "isRetired": isRetired.value,
        "hasBusinessExperience": hasBusinessExperience.value,
        "internationalAchievements": selectedAchievements,
        "travelingWithPets": isTravelingWithPets.value,
        "petType": isTravelingWithPets.value ? selectedPetType.value : null,
        "numberOfPets": isTravelingWithPets.value ? numberOfPets.value : null,
        "petDetails": isTravelingWithPets.value ? petDetailsController.text : null,
      };

      final response = await ApiClient.postData(ApiUrl.setupUserProfile, jsonEncode(body),);

      final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        recommendationsCountries();

        Get.offAllNamed(AppRoutes.legalAdviceScreen);
        showCustomSnackBar(jsonResponse["message"] ?? "Profile setup successful", isError: false,);
        setSetupProfileStatus(Status.completed);


      } else {
        setSetupProfileStatus(Status.error);
        showCustomSnackBar(jsonResponse["message"] ?? "Failed to setup profile", isError: true,);
      }

    } catch (e) {
      setSetupProfileStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);

    } finally {

      isSetupProfileLoading.value = false;

    }
  }

  final isRecommendationsCountriesLoading = false.obs;
  Future<void> recommendationsCountries() async {
    isRecommendationsCountriesLoading.value = true;

    try {

      final response = await ApiClient.postData(ApiUrl.recommendationsCountries, null,);
      final Map<String, dynamic>  jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(jsonResponse["message"] ?? "Saved successfully",isError: false);
      }
      else{
        showCustomSnackBar(jsonResponse["message"] ??"Failed to save country", isError: true,);
      }

    } catch (e) {
      showCustomSnackBar("Error: ${e.toString()}", isError: true,);
    } finally {
      isRecommendationsCountriesLoading.value = false;

    }
  }

}