import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../components/custom_nav_bar/navbar.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_show_popup/custom_show_popup.dart';
import '../../../components/custom_text/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0C7A43),
              Color(0xFF2DBE60),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 24,right: 24, top: 30),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomNetworkImage(
                        imageUrl: AppConstants.girlsPhoto,
                        boxShape: BoxShape.circle,
                        height: 64.h,
                        width: 64.w,
                      ),
                      SizedBox(width: 15),
                      CustomText(
                        text: 'Debbendu Paul',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  _buildOption(
                    titleKey: 'Edit Profile',
                    onTap: () => Get.toNamed(AppRoutes.editScreen),
                  ),
                  SizedBox(height: 15),
                  _buildOption(
                    titleKey: 'Notification',
                    onTap: () => Get.toNamed(AppRoutes.notificationScreen),
                  ),
                  SizedBox(height: 15),
                  _buildOption(
                    titleKey: 'Security',
                    onTap: () => Get.toNamed(AppRoutes.securityScreen),
                  ),
                  SizedBox(height: 15),
                  _buildOption(
                    titleKey: 'Account Settings',
                    onTap: () => Get.toNamed(AppRoutes.accountSettingsScreen),
                  ),
                  SizedBox(height: 15),
                  _buildOption(
                    titleKey: 'Help & Support',
                     onTap: () => Get.toNamed(AppRoutes.helpSupport),
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
                               leftOnTap: () => Get.offAllNamed(AppRoutes.loginScreen),
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
      bottomNavigationBar: HostNavbar(currentIndex: 1),
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
          color: AppColors.primary1.withOpacity(1),
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
                    color: AppColors.primary,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
