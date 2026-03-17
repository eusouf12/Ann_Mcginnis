import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';

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
  final businessNameController = TextEditingController().obs;
  final jobTitleController = TextEditingController().obs;
  final experienceYearsController = TextEditingController().obs;
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

  // ==========Step 2 Controllers
  var professionalLicense = Rx<File?>(null);
  var certifications = Rx<File?>(null);
  RxList<Map<String, dynamic>> additionalDocuments = <Map<String, dynamic>>[].obs;

  // ==========Step 3 Controllers
  var selectedTimeZone = "GMT-8 (Pacific Time)".obs;

  void setTimeZone(String value) {
    selectedTimeZone.value = value;
    debugPrint("Selected TimeZone in Controller: ${selectedTimeZone.value}");
  }

  RxList<String> selectedDays = <String>[].obs;
  final List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    debugPrint("Current Selected Days: $selectedDays");
  }

  RxList<String> preferredTimeSlots = <String>[].obs;

  void addTimeSlot(TimeOfDay start, TimeOfDay end) {
    String start24 = "${start.hour.toString().padLeft(2, '0')}:${start.minute
        .toString().padLeft(2, '0')}";
    String end24 = "${end.hour.toString().padLeft(2, '0')}:${end.minute
        .toString().padLeft(2, '0')}";

    preferredTimeSlots.add("$start24-$end24");
  }

  String formatToAmPm(String time24) {
    final parts = time24.split(':');
    final hour = int.parse(parts[0]);
    final minute = parts[1];
    final period = hour >= 12 ? "PM" : "AM";
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return "${displayHour.toString().padLeft(2, '0')}:$minute $period";
  }

  void removeTimeSlot(int index) {
    preferredTimeSlots.removeAt(index);
  }

  Map<String, dynamic> getAvailabilityData() {
    return {
      "availability": {
        "timeZone": selectedTimeZone.value,
        "recurringDays": selectedDays.toList(),
        "preferredTimeSlots": preferredTimeSlots.toList(),
      }
    };
  }

  // =========Step 4 Controllers
  var isVideoSelected = false.obs;
  var isPhoneSelected = false.obs;
  var isInPersonSelected = false.obs;
  final videoFeeController = TextEditingController();
  final phoneFeeController = TextEditingController();
  final inPersonFeeController = TextEditingController();
  final notesController = TextEditingController();
  var selectedCurrency = "USD".obs;
  final discountPercentageController = TextEditingController();


  Map<String, dynamic> getConsultationData() {
    List<String> formats = [];
    if (isVideoSelected.value) formats.add("Video Consultation");
    if (isPhoneSelected.value) formats.add("Audio Consultation");
    if (isInPersonSelected.value) formats.add("In-Person Consultation");

    return {
      "consultationFormats": formats,
      "consultationFees": {
        if (isVideoSelected.value) "videoCall": int.tryParse(
            videoFeeController.text) ?? 0,
        if (isPhoneSelected.value) "phoneCall": int.tryParse(
            phoneFeeController.text) ?? 0,
        if (isInPersonSelected.value) "inPerson": int.tryParse(
            inPersonFeeController.text) ?? 0,
      },
      "additionalNotes": notesController.text,
    };
  }


  // file picup
  Future<File?> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );
      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
    } catch (e) {
      debugPrint("File pick error: $e");
    }
    return null;
  }

  // professionalLicense
  Future<void> pickProfessionalLicense() async {
    professionalLicense.value = await _pickFile();
  }

  // certifications
  Future<void> pickCertifications() async {
    certifications.value = await _pickFile();
  }

  //additionalDocuments
  Future<void> pickAdditionalDocument(int index) async {
    File? pickedFile = await _pickFile();
    if (pickedFile != null) {
      additionalDocuments[index]['file'].value = pickedFile;
    }
  }

  // new additionalDocuments
  void addMoreDocument() {
    additionalDocuments.add({
      'title': "Additional Document ${additionalDocuments.length + 1}",
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


  //=========== Set Profile Consultant ==============
  final isSetupProfileConsultantLoading = false.obs;
  final rxSetupProfileConsultantStatus = Status.loading.obs;
  void setSetupProfileConsultantStatus(Status status) => rxSetupProfileConsultantStatus.value = status;

  Future<void> setupUserProfileConsultant() async {
    isSetupProfileConsultantLoading.value = true;
    setSetupProfileConsultantStatus(Status.loading);

    try {
      List<MultipartBody> multipartFiles = [];
      if (professionalLicense.value != null) {
        multipartFiles.add(MultipartBody("professionalLicenseDoc", professionalLicense.value!));
      }
      if (certifications.value != null) {
        multipartFiles.add(MultipartBody("certificationsFile", certifications.value!));
      }
      for (var doc in additionalDocuments) {
        if (doc['file'].value != null) {
          multipartFiles.add(MultipartBody("additionalDocuments", doc['file'].value!));
        }
      }
      Map<String, String> body = {
        "businessName": businessNameController.value.text.trim(),
        "jobTitle": jobTitleController.value.text.trim(),
        "experienceYears": experienceYearsController.value.text.trim(),
        "profileDescription": profileDescriptionController.value.text.trim(),
        "currency": selectedCurrency.value,
        "discountRates": discountPercentageController.text.trim(),
        "additionalNotes": notesController.text.trim(),
        "consultationFees": jsonEncode({
          if (isVideoSelected.value) "videoCall": int.tryParse(videoFeeController.text) ?? 0,
          if (isPhoneSelected.value) "phoneCall": int.tryParse(phoneFeeController.text) ?? 0,
          if (isInPersonSelected.value) "inPerson": int.tryParse(inPersonFeeController.text) ?? 0,
        }),

        "consultationFormats": jsonEncode([
          if (isVideoSelected.value) "Video Consultation",
          if (isPhoneSelected.value) "Phone Call",
          if (isInPersonSelected.value) "In-Person",
        ]),

        "availability": jsonEncode({
          "timeZone": selectedTimeZone.value,
          "recurringDays": selectedDays.toList(),
          "preferredTimeSlots": preferredTimeSlots.toList(),
        }),
      };
      final response = await ApiClient.postMultipartData(ApiUrl.setupUserProfileConsultants, body,multipartBody: multipartFiles,);

      final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.offAllNamed(AppRoutes.consultantDashboard);
        showCustomSnackBar(jsonResponse["message"] ?? "Profile setup successful", isError: false,);
        setSetupProfileConsultantStatus(Status.completed);
      } else {
        setSetupProfileConsultantStatus(Status.error);
        showCustomSnackBar(jsonResponse["message"] ?? "Failed to setup profile", isError: true,);
      }
    } catch (e) {
      setSetupProfileConsultantStatus(Status.error);
      showCustomSnackBar("Error: ${e.toString()}", isError: true);
    } finally {
      isSetupProfileConsultantLoading.value = false;
    }
  }

}