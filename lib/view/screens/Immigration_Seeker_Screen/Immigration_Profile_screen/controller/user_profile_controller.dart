import 'dart:convert';
import 'dart:io';
import 'package:ann_mcginnis/helper/shared_prefe/shared_prefe.dart';
import 'package:ann_mcginnis/utils/app_const/app_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../model/privacy_model.dart';
import '../model/user_profile_model.dart';

class UserProfileController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  // Pick an image using the camera
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  //============== my profile controller============
  Rxn<User> userData = Rxn<User>();
  final isUserLoading = false.obs;
  final rxUserStatus = Status.loading.obs;
  void setUserStatus(Status status) => rxUserStatus.value = status;

  Future<void> getUserProfile() async {
    isUserLoading.value = true;
    setUserStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.myProfile);
      final Map<String, dynamic> jsonResponse;

      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final UserProfileModel model = UserProfileModel.fromJson(jsonResponse);
        userData.value = model.data?.user;

        if (nameController.value.text.isEmpty) {
          nameController.value.text = userData.value?.fullname ?? "";
        }
        if (countryController.value.text.isEmpty) {
          countryController.value.text = userData.value?.country ?? "";
        }
        emailController.value.text = userData.value?.email ?? "";

        if (dateOfBirthController.value.text.isEmpty) {
          dateOfBirthController.value.text = userData.value?.dateOfBirth ?? "";
        }
        if (phoneNumberController.value.text.isEmpty) {
          phoneNumberController.value.text = userData.value?.mobile ?? "";
        }

        setUserStatus(Status.completed);
      } else {
        setUserStatus(Status.error);
        showCustomSnackBar(
          "Error , Failed to load user profile",
          isError: true,
        );
      }
    } catch (e) {
      setUserStatus(Status.error);
      showCustomSnackBar("Error , ${e.toString()}", isError: true);
    } finally {
      isUserLoading.value = false;
    }
  }

  // Text controllers
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> userNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> countryController = TextEditingController().obs;
  Rx<TextEditingController> fullAddress = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> dateOfBirthController = TextEditingController().obs;
  Rx<TextEditingController> genderController = TextEditingController().obs;

  //========== Update Profile ==========
  RxBool updateProfileLoading = false.obs;
  Future<void> updateProfile() async {
    final role = await SharePrefsHelper.getString(AppConstants.role);
    updateProfileLoading.value = true;
    refresh();

    try {
      Map<String, dynamic> body = {
        "fullname": nameController.value.text,
        "userName": userNameController.value.text,
        "mobile": phoneNumberController.value.text,
        "dateOfBirth": dateOfBirthController.value.text,
        "country": countryController.value.text,
        "fullAddress": fullAddress.value.text,
        "gender": genderController.value.text,
      };

      dynamic response;
      if (selectedImage.value != null) {
        response = await ApiClient.patchMultipartData(
          ApiUrl.updateProfile,
          body,
          multipartBody: [MultipartBody("image", selectedImage.value!)],
        );
      } else {
        response = await ApiClient.patchData(
          ApiUrl.updateProfile,
          jsonEncode(body),
        );
      }

      updateProfileLoading.value = false;
      refresh();

      Map<String, dynamic> jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        getUserProfile();

        Navigator.of(Get.context!).pop();
        Future.delayed(const Duration(milliseconds: 100), () {
          showCustomSnackBar(
            jsonResponse['message']?.toString() ??
                "Profile updated successfully!",
            isError: false,
          );
        });
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Update failed",
          isError: true,
        );
      }
    } catch (e) {
      updateProfileLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("Profile update error: $e");
    }
  }

  //=================== CHANGE PASS===================
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> oldPasswordController = TextEditingController().obs;
  RxBool changePassLoading = false.obs;

  Future<void> changePassword() async {
    if (newPasswordController.value.text !=
        confirmPasswordController.value.text) {
      showCustomSnackBar("Passwords do not match", isError: true);
      return;
    }

    changePassLoading.value = true;
    refresh();

    try {
      Map<String, String> body = {
        "oldPassword": oldPasswordController.value.text.trim(),
        "newPassword": newPasswordController.value.text.trim(),
      };

      dynamic response = await ApiClient.postData(
        ApiUrl.changePassword,
        jsonEncode(body),
      );

      changePassLoading.value = false;
      refresh();

      Map<String, dynamic> jsonResponse = response.body is String
          ? jsonDecode(response.body)
          : response.body as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ??
              "Change password successfully!",
          isError: false,
        );

        resetPasswordFields();
        Get.back();
      } else if (response.statusCode == 404 ||
          response.statusCode == 400 ||
          response.statusCode == 422) {
        // Handle validation errors
        Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : response.body as Map<String, dynamic>;

        if (jsonResponse.containsKey('errorSources') &&
            jsonResponse['errorSources'] is List) {
          List<dynamic> errorSources = jsonResponse['errorSources'];

          for (var error in errorSources) {
            if (error is Map<String, dynamic> && error.containsKey('message')) {
              showCustomSnackBar(error['message'].toString(), isError: true);
              break;
            }
          }
        } else if (jsonResponse.containsKey('message')) {
          showCustomSnackBar(jsonResponse['message'].toString(), isError: true);
        } else {
          showCustomSnackBar("Invalid data provided", isError: true);
        }
      } else {
        showCustomSnackBar(
          jsonResponse['message']?.toString() ?? "Change password failed",
          isError: true,
        );
      }
    } catch (e) {
      changePassLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("Password update error: $e");
    }
  }

  void resetPasswordFields() {
    oldPasswordController.value.clear();
    newPasswordController.value.clear();
    confirmPasswordController.value.clear();
  }

  //=================== Privacy Policy =================
  final rxPrivacyStatus = Status.loading.obs;
  void setPrivacyStatus(Status status) => rxPrivacyStatus.value = status;
  Rx<PrivacyPolicyData?> privacyModel = Rx<PrivacyPolicyData?>(null);
  Future<void> getPrivacyPolicy() async {
    setPrivacyStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.privacyPolicy);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final data = jsonResponse['data'];

        if (data != null) {
          privacyModel.value = PrivacyPolicyData.fromJson(data);
        } else {
          privacyModel.value = null;
        }
        setPrivacyStatus(Status.completed);
      } else if (response.statusCode == 404) {
        setPrivacyStatus(Status.error);
        privacyModel.value = null;
      } else {
        setPrivacyStatus(
          response.statusText == ApiClient.somethingWentWrong
              ? Status.internetError
              : Status.error,
        );
      }
    } catch (e) {
      setPrivacyStatus(Status.error);
      debugPrint("Privacy Parsing/Error: $e");
    }
  }

  //=================== getTermsConditions =================
  final rxStatus = Status.loading.obs;
  void setStatus(Status status) => rxStatus.value = status;
  Rx<PrivacyPolicyData?> termsModel = Rx<PrivacyPolicyData?>(null);

  Future<void> getTermsConditions() async {
    setStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.termsCondition);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final result = PrivacyPolicyResponse.fromJson(jsonResponse);

        termsModel.value = result.data;

        setStatus(Status.completed);
      } else if (response.statusCode == 404) {
        setStatus(Status.error);
        termsModel.value = null;
      } else {
        setStatus(
          response.statusText == ApiClient.somethingWentWrong
              ? Status.internetError
              : Status.error,
        );
      }
    } catch (e) {
      setStatus(Status.error);
      debugPrint("Terms Parsing/Error: $e");
    }
  }

  //=================== About Us =================

  final rxAboutStatus = Status.loading.obs;
  void setAboutStatus(Status status) => rxAboutStatus.value = status;
  Rx<PrivacyPolicyData?> aboutUsModel = Rx<PrivacyPolicyData?>(null);

  Future<void> getAboutUs() async {
    setAboutStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.aboutUs);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = response.body is String
            ? jsonDecode(response.body)
            : Map<String, dynamic>.from(response.body);

        final result = PrivacyPolicyResponse.fromJson(jsonResponse);

        aboutUsModel.value = result.data;

        setAboutStatus(Status.completed);

        debugPrint(
          "================ About Us Loaded =================\n"
          "Type: ${aboutUsModel.value?.type}\n"
          "Content Length: ${aboutUsModel.value?.content?.length}",
        );
      } else if (response.statusCode == 404) {
        setAboutStatus(Status.error);
        aboutUsModel.value = null;
      } else {
        setAboutStatus(
          response.statusText == ApiClient.somethingWentWrong
              ? Status.internetError
              : Status.error,
        );
      }
    } catch (e) {
      setAboutStatus(Status.error);
      debugPrint("About Us Parsing/Error: $e");
    }
  }
}
