import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../model/visa_type_model.dart' as model;

class VisaTypeRequirementScreen extends StatelessWidget {
  VisaTypeRequirementScreen({super.key});

  final RxInt selectedTab = 0.obs;

  @override
  Widget build(BuildContext context) {
    final model.VisaType visa = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: Column(
        children: [
          // ──── Custom Header ────
          _buildHeader(visa),

          // ──── Pill Tab Bar ────
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
            child: _buildPillTabs(),
          ),

          // ──── Content ────
          Expanded(
            child: Obx(
              () => SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
                child: selectedTab.value == 0
                    ? _buildRequirementsTab(visa)
                    : _buildProcessTab(visa),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────── HEADER ──────────────────────────
  Widget _buildHeader(model.VisaType visa) {
    return Container(
      padding: EdgeInsets.only(
        top: 52.h,
        left: 20.w,
        right: 20.w,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primary1],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28.r),
          bottomRight: Radius.circular(28.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back + title row
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomText(
                  text: "Visa Details",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Visa icon + name
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: Colors.white.withOpacity(0.25)),
                ),
                child: Icon(
                  _getVisaIcon(visa.name ?? ""),
                  color: Colors.white,
                  size: 26.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: visa.name ?? "Visa Requirements",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        if ((visa.duration ?? "").isNotEmpty)
                          _headerChip(Icons.schedule_rounded, visa.duration ?? ""),
                        if ((visa.tag ?? "").isNotEmpty) ...[
                          SizedBox(width: 8.w),
                          _headerChip(Icons.label_rounded, visa.tag ?? ""),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 12.sp),
          SizedBox(width: 4.w),
          CustomText(
            text: text,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // ──────────────────────── PILL TABS ──────────────────────────
  Widget _buildPillTabs() {
    final tabs = ["Requirements", "Process"];
    return Obx(
      () => Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final bool isSelected = selectedTab.value == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => selectedTab.value = index,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(vertical: 11.h),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [AppColors.primary1, AppColors.primary],
                          )
                        : null,
                    color: isSelected ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary1.withOpacity(0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index == 0
                            ? Icons.checklist_rounded
                            : Icons.timeline_rounded,
                        size: 16.sp,
                        color: isSelected ? Colors.white : Colors.grey,
                      ),
                      SizedBox(width: 6.w),
                      CustomText(
                        text: tabs[index],
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ──────────────────────── REQUIREMENTS TAB ──────────────────────────
  Widget _buildRequirementsTab(model.VisaType visa) {
    final reqs = visa.requirements ?? [];
    final mandatory = reqs.where((r) => r.isMandatory == true).toList();
    final optional = reqs.where((r) => r.isMandatory != true).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _importantNoticeCard(),
        SizedBox(height: 20.h),

        if (mandatory.isNotEmpty) ...[
          _sectionLabel("Mandatory Requirements", Icons.star_rounded, Colors.amber),
          SizedBox(height: 12.h),
          ...mandatory.asMap().entries.map(
                (e) => _buildRequirementItem(e.value, e.key, true),
              ),
          SizedBox(height: 20.h),
        ],

        if (optional.isNotEmpty) ...[
          _sectionLabel("Optional Requirements",
              Icons.check_circle_outline_rounded, AppColors.primary1),
          SizedBox(height: 12.h),
          ...optional.asMap().entries.map(
                (e) => _buildRequirementItem(e.value, e.key, false),
              ),
        ],
      ],
    );
  }

  Widget _sectionLabel(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18.sp),
        SizedBox(width: 8.w),
        CustomText(
          text: title,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ],
    );
  }

  Widget _buildRequirementItem(dynamic req, int index, bool isMandatory) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isMandatory
                ? Colors.amber.withOpacity(0.3)
                : Colors.grey.withOpacity(0.12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                color: isMandatory
                    ? Colors.amber.withOpacity(0.12)
                    : const Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                isMandatory ? Icons.star_rounded : Icons.check_rounded,
                color: isMandatory ? Colors.amber[700] : AppColors.primary1,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: req.name ?? "",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    textAlign: TextAlign.start,
                  ),
                  if ((req.description ?? "").isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    CustomText(
                      text: req.description ?? "",
                      fontSize: 13,
                      color: const Color(0xFF6B7280),
                      textAlign: TextAlign.start,
                      maxLines: 5,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _importantNoticeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.primary1.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.primary1.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.info_rounded,
                color: AppColors.primary1, size: 16.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF374151),
                  fontFamily: "Inter",
                  height: 1.5,
                ),
                children: [
                  const TextSpan(text: "Requirements marked with "),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Icon(Icons.star_rounded,
                          color: Colors.amber[700], size: 14.sp),
                    ),
                  ),
                  const TextSpan(
                    text: " are mandatory and must be submitted with your application.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────── PROCESS TAB ──────────────────────────
  Widget _buildProcessTab(model.VisaType visa) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProcessingTimeCard(visa),
        SizedBox(height: 16.h),

        if ((visa.processingInfo ?? "").isNotEmpty) ...[
          _buildInfoCard(visa),
          SizedBox(height: 16.h),
        ],

        if ((visa.delayFactors ?? []).isNotEmpty) ...[
          _buildDelayFactorsCard(visa),
          SizedBox(height: 16.h),
        ],

        if ((visa.timeline ?? []).isNotEmpty) ...[
          _buildTimelineCard(visa),
        ],
      ],
    );
  }

  Widget _buildProcessingTimeCard(model.VisaType visa) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.yellow1.withOpacity(0.12),
            AppColors.yellow1.withOpacity(0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.yellow1.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.yellow1.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child:
                Icon(Icons.hourglass_top_rounded, color: AppColors.yellow1, size: 26.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Processing Time",
                  fontSize: 13,
                  color: const Color(0xFF6B7280),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: visa.processingTime ?? "—",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.yellow1,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(model.VisaType visa) {
    return _sectionCard(
      icon: Icons.info_outline_rounded,
      iconBg: const Color(0xFFE8EAF6),
      iconColor: AppColors.primary1,
      title: "Important Information",
      child: CustomText(
        text: visa.processingInfo ?? "",
        fontSize: 13,
        color: const Color(0xFF546E7A),
        textAlign: TextAlign.start,
        maxLines: 20,
      ),
    );
  }

  Widget _buildDelayFactorsCard(model.VisaType visa) {
    return _sectionCard(
      icon: Icons.warning_amber_rounded,
      iconBg: const Color(0xFFFFF3E0),
      iconColor: const Color(0xFFE65100),
      title: "Factors That May Cause Delays",
      child: Column(
        children: (visa.delayFactors ?? []).asMap().entries.map((e) {
          final delay = e.value;
          final isLast = e.key == (visa.delayFactors!.length - 1);
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 3.h),
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE65100),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${delay.title}: ",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            fontFamily: "Inter",
                          ),
                        ),
                        TextSpan(
                          text: delay.description ?? "",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF546E7A),
                            fontFamily: "Inter",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTimelineCard(model.VisaType visa) {
    final timelineColors = [
      AppColors.primary1,
      const Color(0xFFFFA000),
      const Color(0xFF4CAF50),
      const Color(0xFF9C27B0),
      const Color(0xFFB0BEC5),
    ];

    return _sectionCard(
      icon: Icons.account_tree_outlined,
      iconBg: const Color(0xFFF3E5F5),
      iconColor: const Color(0xFF7B1FA2),
      title: "Typical Timeline",
      child: Column(
        children: (visa.timeline ?? []).asMap().entries.map((e) {
          final step = e.value;
          final color = timelineColors[e.key % timelineColors.length];
          final isLast = e.key == (visa.timeline!.length - 1);

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.4),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2.w,
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [color, color.withOpacity(0.15)],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: color.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: step.stage ?? "",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 3.h),
                                Row(
                                  children: [
                                    Icon(Icons.schedule_rounded,
                                        color: color, size: 13.sp),
                                    SizedBox(width: 4.w),
                                    CustomText(
                                      text: step.duration ?? "",
                                      fontSize: 12,
                                      color: const Color(0xFF6B7280),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CustomText(
                              text: "Step ${e.key + 1}",
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: iconColor, size: 18.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomText(
                  text: title,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  // ── Helpers ──
  IconData _getVisaIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains("student")) return Icons.school_rounded;
    if (n.contains("work") ||
        n.contains("employment") ||
        n.contains("permit")) return Icons.work_rounded;
    if (n.contains("business") ||
        n.contains("entre") ||
        n.contains("talent")) return Icons.business_center_rounded;
    if (n.contains("tourist") ||
        n.contains("visit") ||
        n.contains("schengen")) return Icons.flight_rounded;
    if (n.contains("residence")) return Icons.home_rounded;
    if (n.contains("golden")) return Icons.workspace_premium_rounded;
    if (n.contains("skilled") || n.contains("professional"))
      return Icons.engineering_rounded;
    return Icons.credit_card_rounded;
  }
}
