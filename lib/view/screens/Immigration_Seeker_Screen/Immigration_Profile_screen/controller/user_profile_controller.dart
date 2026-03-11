import 'dart:convert';
import 'package:ann_mcginnis/utils/app_const/app_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../model/privacy_model.dart';

class UserProfileController extends GetxController {
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
