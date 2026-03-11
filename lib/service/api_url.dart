class ApiUrl {
  static const String baseUrl = "http://10.0.2.2:8080/api/v1";
  //static const String baseUrl = "https://womens-jennifer-procedure-cars.trycloudflare.com";
  static const String imageUrl = "http://10.0.2.2:8080";
  static String socketUrl = "http://10.0.2.2:8080";
  static String mapKey = "AIzaSyD96BSj2VcHpAfuy2LE1p7NTO7becR44RE";

  ///========================= Authentication =========================
  static const String signUp = "/auth/signup";
  static const String signIn = "/auth/login";
  static const String verificationOtp = "/auth/verify-signup-otp";
  static const String forgotPassword = "/auth/forgot-password";
  static const String verificationOtpForgetPass = "/auth/verify-reset-otp";
  static const String newPassword = "/auth/reset-password";

  // =================== my profile =====================================
  static const String privacyPolicy = "/legal-docs/privacy-policy";
  static const String termsCondition = "/legal-docs/terms-conditions";
  static const String aboutUs = "/legal-docs/about-us";
  static const String changePassword = "/auth/change-password";
  static const String myProfile = "/auth/me";
  static const String updateProfile = "/users/update-user";

  static const String googleAuth = "/api/v1/user/google_auth";

  ///========================= Host =========================
  static const String createEvent = "/api/v1/event/create_event";
  static String updateEvent({required String eventId}) =>
      "/api/v1/event/update_event/$eventId";
  static String allHostEvent({required int page}) =>
      "/api/v1/event/find_my_event_list?page=$page&limit=10";
  static String allHostEventChatRoom({required int page}) =>
      "/api/v1/event_chat_room/find_by_my_event_chatroom?page=$page&limit=10";

  static String getGalleryPostFilter({
    required int page,
    required String filter,
  }) =>
      "/api/v1/memories_event/find_my_upload_memories_event?contentType=$filter&page=$page&limit=10";
  //share post
  static String sharePost(String postId) => "post/$postId";

  // map
  static const String getMap =
      "/map?sw_lat=18&sw_lng=89&ne_lat=24&ne_lng=92&category_id=68185fc91db8477bce1fade2";
}
