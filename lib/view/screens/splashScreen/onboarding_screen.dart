import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/app_routes/app_routes.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_images/app_images.dart';
import '../../components/custom_button/custom_button.dart';
import '../../components/custom_gradient/custom_gradient.dart';
import '../../components/custom_image/custom_image.dart';
import '../../components/custom_text/custom_text.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/images/splashScreenImage1.svg",
      "title": "Welcome to Global Jump!",
      "subtitle": "Your journey to global opportunities starts here. Find out where you are eligible to live and work!",
    },
    {
      "image": "assets/images/splashScreenImage2.svg",
      "title": "Complete Your Eligibility Check",
      "subtitle": "Answer a few simple questions to discover your immigration options!",
    },
    {
      "image": "assets/images/splashScreenImage3.svg",
      "title": "Connect with Immigration Experts",
      "subtitle": "Connect with verified immigration professionals for personalized guidance!",
    },
    {
      "image": "assets/images/splashScreenImage4.svg",
      "title": "You're Ready to Start Your Journey!",
      "subtitle": "Let's get you started with finding the best countries and visa options!"
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    } else {
      Get.offNamed(AppRoutes.chooseRole);
    }
  }
  //skip Btn
  void _skip() {
    Get.offNamed(AppRoutes.chooseRole);
  }

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [

              PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 50.h),
                        Text(
                          _pages[index]["title"]!,
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary1
                          ),
                          textAlign: TextAlign.center,
                        ),
                        index== 3? SizedBox(height: 100.h):SizedBox(height: 150.h),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              _pages[index]["image"]!,
                              height:index == 2 ? 120.h : index == 3 ? 250.h : 180.h,
                              width: index == 2 ? 150.w :  index == 3 ? 250.h : 180.h,
                              fit: BoxFit.contain,
                            ),
                            if (index == 2)
                              Positioned(
                                bottom: -30.h,
                                right: 50.w,
                                child: CustomImage(
                                  imageSrc: AppImages.onboarding3rd,
                                ),
                              ),
                          ],
                        ),
                        index== 3? SizedBox(height: 50.h):SizedBox(height: 100.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _pages[index]["subtitle"]!,
                            style: TextStyle(
                              fontSize: 18.sp,
                                color: Colors.black
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // TOP RIGHT SKIP BUTTON
              Positioned(
                right: 20.w,
                child: TextButton(
                  onPressed: _skip,
                  child: CustomText(
                    text: "Skip",
                    color: AppColors.primary1,
                    fontWeight: FontWeight.w500,
                  )
                ),
              ),
              // TOP CENTER PAGE INDICATOR
              Positioned(
                top: 20.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                        (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: _currentPage == index ? 30.w : 10.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.white : AppColors.white_1.withOpacity(.40),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
              ),
              // BOTTOM NEXT BUTTON
              Positioned(
                bottom: 40.h,
                left: 20.w,
                right: 20.w,
                child: SizedBox(
                  height: 50.h,
                  child: CustomButton(
                      onTap: _nextPage,
                      title: _currentPage == _pages.length - 1
                            ? "Get Started"
                            : "Next",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

