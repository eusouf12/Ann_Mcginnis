import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../model/visa_type_model.dart' as model;
import '../widget/custom_requirment_card.dart';
import '../widget/custom_timeline_card.dart';

class VisaTypeRequirementScreen extends StatelessWidget {
  VisaTypeRequirementScreen({super.key});

  final RxInt selectedTab = 0.obs;

  @override
  Widget build(BuildContext context) {
    final model.VisaType visa = Get.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomRoyelAppbar(
        titleName: visa.name ?? "Visa Requirements",
        leftIcon: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tab Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _tabButton("Requirements", 0),
                  SizedBox(width: 20.w),
                  _tabButton("Process", 1),
                ],
              ),
              SizedBox(height: 20.h),

              Obx(
                () => selectedTab.value == 0
                    ? _buildRequirementsTab(visa)
                    : _buildProcessTab(visa),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String title, int index) {
    return GestureDetector(
      onTap: () => selectedTab.value = index,
      child: Obx(() {
        bool isSelected = selectedTab.value == index;
        return Column(
          children: [
            CustomText(
              text: title,
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.primary1 : Colors.grey,
            ),
            SizedBox(height: 4.h),
            Container(
              height: 3.h,
              width: 60.w,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary1 : Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildRequirementsTab(model.VisaType visa) {
    return Column(
      children: [
        ...List.generate(visa.requirements?.length ?? 0, (index) {
          final req = visa.requirements![index];
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: CustomRequirementCard(
              title: req.name ?? "",
              description: req.description ?? "",
              isMandatory: req.isMandatory ?? false,
            ),
          );
        }),
        SizedBox(height: 20.h),
        _importantNoticeCard(),
      ],
    );
  }

  Widget _buildProcessTab(model.VisaType visa) {
    return Column(
      children: [
        //"Processing Time",
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Processing Time",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  CustomText(
                    text: "Processing Time :",
                    fontSize: 14.sp,
                    color: const Color(0xFF546E7A),
                    textAlign: TextAlign.start,
                    maxLines: 10,
                  ),
                  CustomText(
                    text: " ${visa.processingTime ?? ""}",
                    fontSize: 20.sp,
                    color: AppColors.yellow1,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        //information
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info, color: AppColors.primary1, size: 20.sp),
                  SizedBox(width: 8.w),
                  CustomText(
                    text: "Important Information",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: visa.processingInfo ?? "",
                fontSize: 14.sp,
                color: const Color(0xFF546E7A),
                textAlign: TextAlign.start,
                maxLines: 10,
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        //Factors That May Cause Delays
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info, color: AppColors.primary1, size: 20.sp),
                  SizedBox(width: 8.w),
                  CustomText(
                    text: "Factors That May Cause Delays",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Column(
                children: List.generate(visa.delayFactors?.length ?? 0, (
                  index,
                ) {
                  final delay = visa.delayFactors![index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle_rounded,
                          color: AppColors.yellow1,
                          size: 12.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${delay.title} ",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.yellow1,
                                  ),
                                ),
                                TextSpan(
                                  text: "- ${delay.description}",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        //Typical Timeline
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_tree_outlined,
                    color: AppColors.primary1,
                    size: 24.sp,
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    text: "Typical Timeline",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Column(
                children: List.generate(visa.timeline?.length ?? 0, (index) {
                  final step = visa.timeline![index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: CustomTimelineCard(
                      color: index == 0
                          ? const Color(0xFF2848D7)
                          : index == 1
                          ? const Color(0xFFFFA000)
                          : const Color(0xFFB0BEC5),
                      title: step.stage ?? "",
                      subtitle: step.duration ?? "",
                      isLast: index == (visa.timeline!.length - 1),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _importantNoticeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border(
          left: BorderSide(color: const Color(0xFF2848D7), width: 4.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            children: [
              Icon(Icons.info, color: const Color(0xFF2848D7), size: 20.sp),
              SizedBox(width: 8.w),
              CustomText(
                text: "Important Notice",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2848D7),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Description
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF546E7A),
                fontFamily: "Inter",
              ),
              children: [
                const TextSpan(text: "Requirements marked with "),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Icon(Icons.star, color: Colors.amber, size: 14.sp),
                  ),
                ),
                const TextSpan(
                  text:
                      " mandatory and must be submitted with your application.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
