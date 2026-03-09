import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../model/privacy_model.dart';

class UserProfileController extends GetxController {
  //=================== Privacy Policy =================
  final rxPrivacyStatus = Status.loading.obs;
  void setPrivacyStatus(Status status) => rxPrivacyStatus.value = status;
  Rx<PrivacyPolicyData?> privacyModel = Rx<PrivacyPolicyData?>(null);
  Future<void> getPrivacyPolicy() async {
    setPrivacyStatus(Status.loading);

    try {
      final response = await ApiClient.getData(ApiUrl.privacyPolicy);

      if (response.statusCode == 200 || response.statusCode == 201) {

        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

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
        setPrivacyStatus(response.statusText == ApiClient.somethingWentWrong ? Status.internetError : Status.error,
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

        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final result = PrivacyPolicyResponse.fromJson(jsonResponse);

        termsModel.value = result.data;

        setStatus(Status.completed);

      } else if (response.statusCode == 404) {

        setStatus(Status.error);
        termsModel.value = null;

      } else {

        setStatus(
          response.statusText == ApiClient.somethingWentWrong ? Status.internetError : Status.error,
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

        final Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : Map<String, dynamic>.from(response.body);

        final result = PrivacyPolicyResponse.fromJson(jsonResponse);

        aboutUsModel.value = result.data;

        setAboutStatus(Status.completed);

        debugPrint("================ About Us Loaded =================\n"
              "Type: ${aboutUsModel.value?.type}\n"
              "Content Length: ${aboutUsModel.value?.content?.length}",
        );

      } else if (response.statusCode == 404) {

        setAboutStatus(Status.error);
        aboutUsModel.value = null;

      } else {

        setAboutStatus(
          response.statusText == ApiClient.somethingWentWrong ? Status.internetError : Status.error,
        );
      }

    } catch (e) {
      setAboutStatus(Status.error);
      debugPrint("About Us Parsing/Error: $e");
    }
  }

}