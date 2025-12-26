import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/app_routes/app_routes.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../components/custom_button/custom_button.dart';
import '../../components/custom_gradient/custom_gradient.dart';
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
      "image": "assets/images/onboarding1.svg",
      "title": "Digitize Your Identity",
      "subtitle": "Scan and store your ID cards\n securely.",
    },
    {
      "image": "assets/images/onboarding2.svg",
      "title": "Access Anywhere",
      "subtitle": "Keep your IDs safe and available\n anytime.",
    },
    {
      "image": "assets/images/onboarding3.svg",
      "title": "Access Anywhere",
      "subtitle": "Keep your IDs safe and available\n anytime.",
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut);
    } else {
      Get.offNamed(AppRoutes.loginScreen);
    }
  }
  //skip Btn
  void _skip() {
    Get.offNamed(AppRoutes.loginScreen);
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.h),
                      SvgPicture.asset(
                        _pages[index]["image"]!,
                        height: 320.h,
                        width: 320.w,
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        _pages[index]["title"]!,
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        _pages[index]["subtitle"]!,
                        style: TextStyle(
                          fontSize: 18.sp,
                            color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
                bottom: 10.h,
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

