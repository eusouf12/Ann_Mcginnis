import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_icons/app_icons.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_nav_bar/navbar.dart';
import '../../../components/custom_text/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      color1: AppColors.white,
      color2: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.white_2,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // appbar profile info
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: CustomImage(
                        imageSrc: AppIcons.idCard,
                        height: 18.w,
                        width: 18.w,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Digital ID",
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //notification
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.notificationScreen),
                child: Icon(
                  Icons.notifications,
                  color: AppColors.primary,
                  size: 30.w,
                ),
              ),
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ========== RECENT DOCUMENTS ==========
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Recent Documents",
                      fontSize: 20,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.recentDocument);
                      },
                      child: CustomText(
                        text: "View All",
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),


            ],
          ),
        ),

        bottomNavigationBar: HostNavbar(currentIndex: 0),
      ),
    );
  }
}