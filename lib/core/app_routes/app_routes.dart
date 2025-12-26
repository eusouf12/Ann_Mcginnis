import 'package:get/get.dart';
import '../../view/screens/authentication_screen/forgot_screen/forgot_screen.dart';
import '../../view/screens/authentication_screen/login_screen/login_screen.dart';
import '../../view/screens/authentication_screen/otp_screen/otp_screen.dart';
import '../../view/screens/authentication_screen/set_new_password/set_new_password.dart';
import '../../view/screens/authentication_screen/sign_up_screen/sign_up_screen.dart';
import '../../view/screens/otherScreen/Home/home_screen.dart';
import '../../view/screens/otherScreen/profile_screen/account_settings/about_screen.dart';
import '../../view/screens/otherScreen/profile_screen/account_settings/account_settings_screen.dart';
import '../../view/screens/otherScreen/profile_screen/account_settings/change_pass_screen.dart';
import '../../view/screens/otherScreen/profile_screen/account_settings/privacy_screen.dart';
import '../../view/screens/otherScreen/profile_screen/help_support.dart';
import '../../view/screens/otherScreen/profile_screen/security_screen.dart';
import '../../view/screens/otherScreen/profile_screen/account_settings/terms_services_screen.dart';
import '../../view/screens/otherScreen/profile_screen/edit_screen.dart';
import '../../view/screens/otherScreen/profile_screen/notification_screen.dart';
import '../../view/screens/otherScreen/profile_screen/profile_screen.dart';
import '../../view/screens/splashScreen/account_ready_screen.dart';
import '../../view/screens/splashScreen/onboarding_screen.dart';
import '../../view/screens/splashScreen/splashScreen.dart';
import '../../view/screens/splashScreen/subscribe_screen.dart';


class AppRoutes {
  ///===========================Authentication==========================
  static const String splashScreen = "/SplashScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String loginScreen = "/LoginScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String subscribeScreen = "/SubscribeScreen";
  static const String accountReadyScreen = "/AccountReadyScreen";
  static const String otpScreen = "/otpScreen";
  static const String forgotScreen = "/ForgotScreen";
  static const String setNewPassword = "/SetNewPassword";

  ///===========================Host Part==========================
  static const String homeScreen = "/HomeScreen";
  static const String createScreen = "/CreateScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String profileScreen ="/ProfileScreen";
  static const String editScreen = "/EditScreen";
  static const String securityScreen = "/SecurityScreen";
  static const String accountSettingsScreen = "/AccountSettingsScreen";
  static const String changePassScreen = "/ChangePassScreen";
  static const String termsServicesScreen = "/TermsServicesScreen";
  static const String privacyScreen = "/PrivacyScreen";
  static const String aboutScreen = "/AboutScreen";
  static const String helpSupport = "/HelpSupport";
  static const String addDocument = "/AddDocument";
  static const String addNewDoc = "/AddNewDoc";
  static const String reviewScreen = "/ReviewScreen";
  static const String driverLicenseScreen = "/DriverLicenseScreen";
  static const String saveChange = "/SaveChange";
  static const String documentSavedScreen = "/DocumentSavedScreen";
  static const String documentScannerPage = "/DocumentScannerPage";
  static const String scannerFlutter = "/ScannerFlutter";
  static const String recentDocument = "/RecentDocument";
  static const String allDocument = "/AllDocument";
  static const String singleView = "/SingleView";

  ///===========================10 PART==========================

  static const String identity = "/Identity";
  static const String healthcare = "/Healthcare";
  static const String employment = "/Employment";
  static const String citizenship = "/Citizenship";
  static const String education = "/Education";
  static const String eVerification = "/EVerification";
  static const String financial = "/Financial";
  static const String residence = "/residence";
  static const String legalRights = "/LegalRights";
  static const String transportation = "/Transportation";


  static List<GetPage> routes = [

    ///===========================Authentication==========================
    GetPage(name: splashScreen, page: () => Splashscreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: accountReadyScreen, page: () => AccountReadyScreen()),
    GetPage(name: subscribeScreen, page: () => SubscribeScreen()),
    GetPage(name: otpScreen, page: () => OtpScreen()),
    GetPage(name: forgotScreen, page: () => ForgotScreen()),
    GetPage(name: setNewPassword, page: () => SetNewPassword()),
    GetPage(name: homeScreen, page: () => HomeScreen()),

  ///===========================Other Part==========================
  GetPage(name: profileScreen, page: () => ProfileScreen()),
  GetPage(name: editScreen, page: () => EditScreen()),
  GetPage(name: notificationScreen, page: () => NotificationScreen()),
  GetPage(name: securityScreen, page: () => SecurityScreen()),
  GetPage(name: accountSettingsScreen, page: () => AccountSettingsScreen()),
  GetPage(name: changePassScreen, page: () => ChangePassScreen()),
  GetPage(name: termsServicesScreen, page: () => TermsServicesScreen()),
  GetPage(name: privacyScreen, page: () => PrivacyScreen()),
  GetPage(name: aboutScreen, page: () => AboutScreen()),
  GetPage(name: helpSupport, page: () => HelpSupport()),

  ];
}
