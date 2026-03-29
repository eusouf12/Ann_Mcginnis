import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../service/api_url.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_show_popup/custom_show_popup.dart';
import '../../../components/custom_text/custom_text.dart';
import '../../Immigration_Seeker_Screen/Immigration_Profile_screen/controller/user_profile_controller.dart';
import 'consult_profile_setup_screen.dart' hide AppColors, CustomText;

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
  final UserProfileController controller = Get.put(UserProfileController());
  String? name;
  String? email;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUserProfile();
    });
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24,right: 24, top: 30),
          child: SingleChildScrollView(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ===== USER HEADER =====
                    Obx(() {
                      if (controller.isUserLoading.value) {
                        return const Center(child: CustomLoader());
                      }

                      final user = controller.userData.value;
                      final imageUrl = (user?.avatar ?? "").isNotEmpty ? "${ApiUrl.imageUrl}${user!.avatar}" : AppConstants.profileImage;
                      name = user!.fullname;
                      email = user.email;

                      return Row(
                        children: [
                          CustomNetworkImage(
                            imageUrl: imageUrl,
                            boxShape: BoxShape.circle,
                            height: 64.h,
                            width: 64.w,
                          ),

                          SizedBox(width: 15.w),
                          CustomText(
                            text: name ?? "",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ],
                      );
                    }),

                    SizedBox(height: 30.h),

                    /// ===== OPTIONS =====
                    _buildOption(
                      titleKey: 'Chat',
                      onTap: () => Get.toNamed(AppRoutes.chatListScreen),
                    ),
                    SizedBox(height: 15),
                    //edit
                    _buildOption(
                      titleKey: 'Edit Profile',
                      onTap: () => Get.toNamed(AppRoutes.userEditScreen),
                    ),
                    SizedBox(height: 15),
                    _buildOption(
                      titleKey: 'Consultation Profile',
                      onTap: () => Get.to(ConsultationProfileScreen()),
                    ),
                    SizedBox(height: 15),
                    _buildOption(
                      titleKey: 'Change Password',
                      onTap: () => Get.toNamed(AppRoutes.userChangePassScreen),
                    ),

                    SizedBox(height: 15.h),

                    _buildOption(
                      titleKey: 'Terms of Services',
                      onTap: () => Get.toNamed(AppRoutes.userTermsServicesScreen),
                    ),

                    SizedBox(height: 15.h),

                    _buildOption(
                      titleKey: 'Privacy Policy',
                      onTap: () => Get.toNamed(AppRoutes.userPrivacyScreen),
                    ),

                    SizedBox(height: 15.h),

                    _buildOption(
                      titleKey: 'About us',
                      onTap: () => Get.toNamed(AppRoutes.userAboutScreen),
                    ),

                    SizedBox(height: 15.h),

                    _buildOption(
                      titleKey: 'Help & Support',
                      onTap: () => Get.toNamed(AppRoutes.userHelpSupport,arguments: {"name" : name , "email": email}),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: AppColors.white,
                            insetPadding: EdgeInsets.all(8),
                            contentPadding: EdgeInsets.all(8),
                            content: SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: CustomShowDialog(
                                textColor: AppColors.black,
                                title: 'Are You Sure',
                                discription: 'Logout Your Account',
                                showColumnButton: true,
                                showCloseButton: true,
                                rightOnTap: () => Get.back(),
                                leftOnTap: () => Get.offAllNamed(AppRoutes.loginOnlyScreen),
                              ),
                            ),
                          ),
                        );
                      },
                      child: _buildOption(
                        titleKey: 'Logout',
                        color: AppColors.red,
                        showArrow: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required String titleKey,
    VoidCallback? onTap,
    Color? color,
    bool showArrow = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary.withOpacity(1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CustomText(
                text: titleKey.tr,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color ?? AppColors.white,
              ),
              Spacer(),
              if (showArrow)
                Container(
                  height: 45,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
