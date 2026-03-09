import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_url.dart';
import '../../../../utils/ToastMsg/toast_message.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../../utils/local_storage/local_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';



class AuthController extends GetxController {
  ///========== SignUp Api Controller ==========
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> dateOfBirthController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
  Rx<TextEditingController> countryController = TextEditingController().obs;
  RxString passwordError = "".obs;
  var completePhoneNumber = ''.obs;
  var countryCode = ''.obs;

  void validatePasswordLive(String value) {
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).+$';

    if (value.isEmpty) {
      passwordError.value = "Your password must have one number, one upper and lower case and symbol.";
    } else if (!RegExp(pattern).hasMatch(value)) {
      passwordError.value =
      "Your password must have one number, one upper and lower case and symbol.";
    } else {
      passwordError.value = "";
    }
  }

  bool isEmailValidate(String input) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",).hasMatch(input);
  }

  //=============== Date Formate Function ================
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirthController.value.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  // toggle btn for 2_step verification
  RxBool isVerificationEnabled = false.obs;
  void toggleVerification(bool value) {
    isVerificationEnabled.value = value;
    print("Push Verification: $value");
  }

  //========== SignUp Api Loading ==========
  RxBool signUpLoading = false.obs;
  Future<void> signUp({required String role}) async {
    signUpLoading.value = true;
    Map<String, dynamic> body = {
      "firstName": nameController.value.text.trim(),
      "lastName": lastNameController.value.text.trim(),
      "password": passwordController.value.text,
      "email": emailController.value.text.trim().toLowerCase(),
      "mobile": phoneNumberController.value.text.trim(),
      "dateOfBirth": dateOfBirthController.value.text,
      "country": countryController.value.text,
      "role": role,
    };

    try {
      var response = await ApiClient.postData(ApiUrl.signUp, jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        signUpLoading.value = false;
        refresh();

        Map<String, dynamic> jsonResponse;

        response.body is String? jsonResponse = jsonDecode(response.body) : jsonResponse = response.body as Map<String, dynamic>;

        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Registration successful! Please verify your email.", isError: false);

        Get.toNamed(AppRoutes.otpScreen, arguments: SignUpAuthModel(emailController.value.text, AppStrings.signUp));
        //Get.toNamed(AppRoutes.accountReadyScreen);

        // Clear signup data
        clearSignUpData();
      } else {
        signUpLoading.value = false;
        refresh();

        if (response.statusText == ApiClient.somethingWentWrong) {
          showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
        } else {
          ApiChecker.checkApi(response);
        }
      }
    } catch (e) {
      signUpLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("SignUp Error: $e");
    }
  }

  //========== Clear SignUp Data ==========
  void clearSignUpData() {
    nameController.value.clear();
    lastNameController.value.clear();
    countryController.value.clear();
    emailController.value.clear();
    phoneNumberController.value.clear();
    dateOfBirthController.value.clear();
    passwordController.value.clear();
    confirmPasswordController.value.clear();
    forgetPasswordController.value.clear();
  }

  //=====================LOGIN METHOD=====================
  RxBool loginLoading = false.obs;
  @override
  void onInit() {
      super.onInit();
      loginEmailController.value.text = "mefile5102@feriwor.com" ; //"az0001@atomicmail.io" . p :   123123
      loginPasswordController.value.text = "1234567";
    }
  Rx<TextEditingController> loginEmailController = TextEditingController().obs;
  Rx<TextEditingController> loginPasswordController = TextEditingController().obs;
  Future<void> loginUser() async {
    loginLoading.value = true;

    Map<String, String> body = {
      "email": loginEmailController.value.text.trim(),
      "password": loginPasswordController.value.text.trim(),
    };

    try {
      var response = await ApiClient.postData(ApiUrl.signIn, jsonEncode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {

        Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : response.body;

        showCustomSnackBar(jsonResponse['message'] ?? "Login successful", isError: false);


        // Access Token
        var dataMap = jsonResponse['data'] as Map<String, dynamic>;
        String accessToken = dataMap['accessToken'].toString();
        debugPrint("Bearer Token: $accessToken");
        await SharePrefsHelper.setString(AppConstants.bearerToken, accessToken);

        // Decode token
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        String userId = decodedToken['_id'].toString();
        String userRole = decodedToken['role'].toString();

        await SharePrefsHelper.setString(AppConstants.userId, userId);
        String id = await SharePrefsHelper.getString(AppConstants.userId);
        debugPrint("Debug Id===========================================================${id} ==${userRole}");
        await SharePrefsHelper.setString(AppConstants.role, userRole);

        userRole.toLowerCase() == "user" ? Get.offAllNamed(AppRoutes.recommendedCountriesScreen) : Get.offAllNamed(AppRoutes.consultantDashboard);
      }
      else {
        refresh();

        Map<String, dynamic> errorResponse;

        if (response.body is String) {
          errorResponse = jsonDecode(response.body);
        } else {
          errorResponse = response.body as Map<String, dynamic>;
        }
        if (response.statusCode == 400 || response.statusCode == 401) {
          showCustomSnackBar(errorResponse['message']?.toString() ?? "Invalid email or password", isError: true,);
        } else {
          showCustomSnackBar(errorResponse['message']?.toString() ?? "Login failed", isError: true,);
        }
      }
    } catch (e) {
      debugPrint("Login error: $e");
      showCustomSnackBar("Something went wrong", isError: true);

    } finally {
      loginLoading.value = false;
    }
  }

  ///========== OTP Controller SIGN UP PATCH METHOD==========

  final TextEditingController otpController = TextEditingController();
  RxBool otpLoading = false.obs;

  Future<void> verifyOtp({required String screenName,required String signUpEmail,}) async {
    otpLoading.value = true;
    refresh();

    // Prepare API body (verification code is always required)
    if (otpController.value.text.isEmpty) {
      otpLoading.value = false;
      showCustomSnackBar("OTP cannot be empty.", isError: true);
      return;
    }

    Map<String, dynamic> body = {"otp": otpController.value.text,"email":signUpEmail};

    try {
      // PATCH request to verify OTP
      var response = await ApiClient.postData(ApiUrl.verificationOtp, jsonEncode(body));

      otpLoading.value = false;
      refresh();

      Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : response.body as Map<String, dynamic>;

      // Show success message
      showCustomSnackBar(jsonResponse['message']?.toString() ?? "Account verified successfully!", isError: false,);

      // Clear OTP field
      otpController.clear();

      var dataMap = jsonResponse['data'] as Map<String, dynamic>;
      String accessToken = dataMap['accessToken'].toString();

      // Save access token
      await SharePrefsHelper.setString(AppConstants.bearerToken, accessToken);

      // Decode JWT to get id & role
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      String userId = decodedToken['id'].toString();
      String userRole = decodedToken['role'].toString();

      // Save user id & role
      await SharePrefsHelper.setString(AppConstants.userId, userId);
      await SharePrefsHelper.setString(AppConstants.role, userRole);

      Get.offAllNamed(AppRoutes.loginOnlyScreen);
    }
    catch (e) {
      otpLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true,);
      debugPrint("OTP Verification Error: $e");
    }
  }

  //======================Forget password CONTROLLER=====================

  Rx<TextEditingController> forgetPasswordController = TextEditingController().obs;
  RxBool forgetPasswordLoading = false.obs;
  Future<void> forgetPassword({required String screenName}) async {
    forgetPasswordLoading.value = true;
    refresh();

    Map<String, String> body = {
      "email": forgetPasswordController.value.text,
    };

    try {
      var response = await ApiClient.postData(ApiUrl.forgotPassword, jsonEncode(body));

      forgetPasswordLoading.value = false;
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonResponse;

        if (response.body is String) {jsonResponse = jsonDecode(response.body);}
        else { jsonResponse = response.body as Map<String, dynamic>;}

        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Check your email for OTP", isError: false,);

        Get.toNamed( AppRoutes.otpScreen,
          arguments: SignUpAuthModel(emailController.value.text, AppStrings.forgetPassword),
        );

      }
      else {
        if (response.statusText == ApiClient.somethingWentWrong) {
          showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
        } else {
          showCustomSnackBar('Please enter your correct email address!', isError: true);
          ApiChecker.checkApi(response);
        }
      }
    } catch (e) {
      forgetPasswordLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("ForgotPassword Error: $e");
    }
  }

  ///======================update password CONTROLLER=====================

  Rx<TextEditingController> updatePasswordController = TextEditingController().obs;
  Rx<TextEditingController> updateConfirmPasswordController = TextEditingController().obs;
  RxBool updatePasswordLoading = false.obs;

  Future<void> updatePassword() async {
    String resetToken = await SharePrefsHelper.getString("resetToken");
    debugPrint("===================${resetToken} ");
    updatePasswordLoading.value = true;
    refresh();

    // Prepare request body
    Map<String, dynamic> body = {
      "newPassword":updatePasswordController.value.text,
      "confirmPassword": updateConfirmPasswordController.value.text,
    };

    try {
      var response = await ApiClient.postData(
          ApiUrl.newPassword, jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $resetToken',
          }
      );

      updatePasswordLoading.value = false;
      refresh();
      Map<String, dynamic> jsonResponse;

      if (response.statusCode == 200 || response.statusCode == 201) {
        response.body is String ? jsonResponse = jsonDecode(response.body) :
        jsonResponse = response.body as Map<String, dynamic>;

        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Password updated successfully!", isError: false,);
        updatePasswordController.value.clear();
        updateConfirmPasswordController.value.clear();
        Get.offAllNamed(AppRoutes.loginOnlyScreen);
      }
      else {
        response.body is String ? jsonResponse = jsonDecode(response.body) :
        jsonResponse = response.body as Map<String, dynamic>;
        showCustomSnackBar(jsonResponse['message']?.toString() ?? "Password update failed", isError: true,);
      }
    } catch (e) {
      updatePasswordLoading.value = false;
      refresh();
      showCustomSnackBar("An error occurred. Please try again.", isError: true);
      debugPrint("UpdatePassword Error: $e");
    }
  }


  ///========== OTP Controller ForgetPass POST METHOD==========
  RxBool otpForgetLoading = false.obs;
  Future<void> verifyOtpForgetPass() async {
    otpForgetLoading.value = true;
    refresh();

    if (otpController.value.text.isEmpty) {
      otpForgetLoading.value = false;
      showCustomSnackBar("OTP cannot be empty.", isError: true);
      return;
    }

    Map<String, dynamic> body = {
      "otp": otpController.value.text,
    };

    try {
      var response = await ApiClient.postData(ApiUrl.verificationOtpForgetPass, jsonEncode(body),);

      otpForgetLoading.value = false;
      refresh();

      Map<String, dynamic> jsonResponse = response.body is String ? jsonDecode(response.body) : response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(jsonResponse['message'] ?? "Verified!", isError: false,);
        otpController.clear();
        String resetToken = jsonResponse['data']['resetToken'];
        await SharePrefsHelper.setString("resetToken", resetToken,);
        debugPrint(" email screen ===================${resetToken} ");
        Get.offAllNamed(AppRoutes.setNewPassword);
      }
      else {
        showCustomSnackBar(jsonResponse['message'] ?? "OTP verification failed", isError: true,);
      }

    } catch (e) {
      otpForgetLoading.value = false;
      refresh();

      showCustomSnackBar("Error occurred: $e", isError: true);
      debugPrint("OTP Verification Error: $e");
    }
  }

}

///========== Models ==========
class SignUpAuthModel {
  final String email;
  final String screenName;

  SignUpAuthModel(
      this.email,
      this.screenName,
      );
}