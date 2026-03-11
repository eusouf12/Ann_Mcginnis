import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_show_popup/custom_show_popup.dart';
import '../../../components/custom_text/custom_text.dart';
import 'package:ann_mcginnis/service/api_url.dart';
import 'controller/user_profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  final UserProfileController controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getUserProfile();
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                /// ===== USER HEADER =====
                Obx(() {
                  if (controller.isUserLoading.value) {
                    return const Center(child: CustomLoader());
                  }

                  final user = controller.userData.value;

                  final imageUrl = (user?.avatar ?? "").isNotEmpty
                      ? "${ApiUrl.imageUrl}${user!.avatar}"
                      : AppConstants.profileImage;

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
                        text: user?.fullname ?? "",
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

                SizedBox(height: 15.h),

                _buildOption(
                  titleKey: 'Edit Profile',
                  onTap: () => Get.toNamed(AppRoutes.userEditScreen),
                ),

                SizedBox(height: 15.h),

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
                  onTap: () => Get.toNamed(AppRoutes.userHelpSupport),
                ),

                SizedBox(height: 15.h),

                /// ===== LOGOUT =====
                GestureDetector(
                  onTap: () => _showLogoutDialog(context),
                  child: _buildOption(titleKey: 'Logout', color: AppColors.red),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ===== OPTION ITEM =====
  Widget _buildOption({
    required String titleKey,
    VoidCallback? onTap,
    Color? color,
    bool showArrow = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            CustomText(
              text: titleKey.tr,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: color ?? AppColors.white,
            ),

            const Spacer(),

            if (showArrow)
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.white,
                ),
                child: const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// ===== LOGOUT DIALOG =====
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.white,
        contentPadding: const EdgeInsets.all(12),
        content: CustomShowDialog(
          textColor: AppColors.black,
          title: 'Are You Sure',
          discription: 'Logout Your Account',
          showColumnButton: true,
          showCloseButton: true,
          rightOnTap: () => Get.back(),
          leftOnTap: () => Get.offAllNamed(AppRoutes.loginOnlyScreen),
        ),
      ),
    );
  }
}
