import 'package:ann_mcginnis/view/screens/Consultant/profile_screen/consult_profile_screen.dart';
import 'package:ann_mcginnis/view/screens/Immigration_Seeker_Screen/Immigration_Profile_screen/Immigration_Profile_screen.dart';
import 'package:get/get.dart';
import '../../view/screens/Consultant/view/consultant_dashboard.dart';
import '../../view/screens/Immigration_Seeker_Screen/Booking_Flow_Screen/view/consult_profile_view_details.dart';
import '../../view/screens/Immigration_Seeker_Screen/Immigration_Profile_screen/Immigration_Account_settings/Immigration_About_screen.dart';
import '../../view/screens/Immigration_Seeker_Screen/Immigration_Profile_screen/Immigration_Account_settings/Immigration_Change_pass_screen.dart';
import '../../view/screens/Immigration_Seeker_Screen/Immigration_Profile_screen/Immigration_Account_settings/Immigration_Privacy_screen.dart';
import '../../view/screens/Immigration_Seeker_Screen/Immigration_Profile_screen/Immigration_Account_settings/Immigration_Terms_services_screen.dart';
import '../../view/screens/Immigration_Seeker_Screen/Immigration_Profile_screen/Immigration_Edit_screen.dart';
import '../../view/screens/Immigration_Seeker_Screen/Immigration_Profile_screen/Immigration_help_support.dart';
import '../../view/screens/Immigration_Seeker_Screen/Recommended_Countries_Screen/view/recommended_countries_screen.dart';
import '../../view/screens/Immigration_Seeker_Screen/Recommended_Countries_Screen/view/single_country_view_screen.dart';
import '../../view/screens/Immigration_Seeker_Screen/Recommended_dashboard_Screen/view/user_dashboard.dart';
import '../../view/screens/Immigration_Seeker_Screen/SetUp_Profile_Screen/views/set_up_profile_screen_1.dart';
import '../../view/screens/Immigration_Seeker_Screen/message_screen/view/chat_list_screen.dart';
import '../../view/screens/authentication_screen/forgot_screen/forgot_screen.dart';
import '../../view/screens/authentication_screen/login_screen/login_screen.dart';
import '../../view/screens/authentication_screen/otp_screen/otp_screen.dart';
import '../../view/screens/authentication_screen/set_new_password/set_new_password.dart';
import '../../view/screens/authentication_screen/sign_up_screen/sign_up_screen.dart';
import '../../view/screens/role_screen/role_screen.dart';
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
  static const String chooseRole = "/ChooseRole";

  ///===========================other part Part==========================
  static const String singleView = "/SingleView";

  ///===========================Immigration Seeker==========================
  static const String setUpProfileScreen = "/SetUpProfileScreen";
  static const String recommendedCountriesScreen = "/RecommendedCountriesScreen";
  static const String countryDetailsScreen = "/CountryDetailsScreen";
  static const String userDashboard = "/UserDashboard";
  static const String userProfileScreen ="/UserProfileScreen";
  static const String userEditScreen = "/UserEditScreen";
  static const String userSecurityScreen = "/UserSecurityScreen";
  static const String userAccountSettingsScreen = "/UserAccountSettingsScreen";
  static const String userChangePassScreen = "/UserChangePassScreen";
  static const String userTermsServicesScreen = "/UserTermsServicesScreen";
  static const String userPrivacyScreen = "/UserPrivacyScreen";
  static const String userAboutScreen = "/UserAboutScreen";
  static const String userHelpSupport = "/UserHelpSupport";
  static const String chatListScreen = "/ChatListScreen";
  static const String consultProfileViewDetails = "/ConsultProfileViewDetails";

  ///=============================== Consultant ======================================
  static const String consultantDashboard = "/ConsultantDashboard";


  static List<GetPage> routes = [

    ///===========================Authentication==========================
    GetPage(name: splashScreen, page: () => Splashscreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: chooseRole, page: () => ChooseRole()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: accountReadyScreen, page: () => AccountReadyScreen()),
    GetPage(name: subscribeScreen, page: () => SubscribeScreen()),
    GetPage(name: otpScreen, page: () => OtpScreen()),
    GetPage(name: forgotScreen, page: () => ForgotScreen()),
    GetPage(name: setNewPassword, page: () => SetNewPassword()),

    ///============== Immigration Seeker ==================
    GetPage(name: recommendedCountriesScreen, page: () => RecommendedCountriesScreen()),
    GetPage(name: setUpProfileScreen, page: () => SetUpProfileScreen1()),
    GetPage(name: countryDetailsScreen, page: () => CountryDetailsScreen()),
    GetPage(name: userDashboard, page: () => UserDashboard()),
    GetPage(name: userProfileScreen, page: () => UserProfileScreen()),
    GetPage(name: userEditScreen, page: () => UserEditScreen()),
    GetPage(name: userChangePassScreen, page: () => ImmigrationChangePassScreen()),
    GetPage(name: userTermsServicesScreen, page: () => ImmigrationTermsServicesScreen()),
    GetPage(name: userPrivacyScreen, page: () => ImmigrationPrivacyScreen()),
    GetPage(name: userAboutScreen, page: () => ImmigrationAboutScreen()),
    GetPage(name: userHelpSupport, page: () => ImmigrationHelpSupport()),
    GetPage(name: chatListScreen, page: () => ChatListScreen()),
    GetPage(name: consultProfileViewDetails, page: () => ConsultProfileViewDetails()),

    ///=============================== Consultant ======================================
    GetPage(name: consultantDashboard, page: () => ConsultantDashboard()),


  ];
}
