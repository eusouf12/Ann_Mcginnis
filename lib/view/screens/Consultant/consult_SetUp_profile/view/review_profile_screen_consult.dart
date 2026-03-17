        import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text/custom_text.dart';

        import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
        import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
        import 'package:flutter/material.dart';
        import 'package:flutter_screenutil/flutter_screenutil.dart';
        import 'package:get/get.dart';

        import '../../../../components/custom_button/custom_button.dart';
        import '../../../../components/custom_text/custom_text.dart';
        import '../controller/consult_setup_controller.dart';

        class ConsultReviewProfileScreen extends StatelessWidget {
          ConsultReviewProfileScreen({super.key});
          final ConsultSetupController controller = Get.put(ConsultSetupController());

          @override
          Widget build(BuildContext context) {
            return Scaffold(
              backgroundColor: const Color(0xFFF8F9FA),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "Global Jump",
                  style: TextStyle(
                      color: const Color(0xFF1E3A8A),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
                ),
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.black54))
                ],
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                        text: "Review Your Profile",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A)),
                    SizedBox(height: 5.h),
                    const CustomText(
                        text: "Please review all information before confirming your profile setup",
                        fontSize: 12,
                        color: Colors.grey),

                    SizedBox(height: 25.h),

                    // 1. Personal Information (From Step 1)
                    _buildReviewSection(
                      icon: Icons.person,
                      title: "Business Information",
                      onEdit: () => Get.back(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow("Business Name", controller.businessNameController.value.text),
                          _buildDetailRow("Job Title", controller.jobTitleController.value.text),
                          _buildDetailRow("Description", controller.profileDescriptionController.value.text),
                        ],
                      ),
                    ),

                    // 2. Documents (From Step 2)
                    _buildReviewSection(
                      icon: Icons.description,
                      title: "Documents",
                      onEdit: () => Get.back(),
                      child: Column(
                        children: [
                          if (controller.professionalLicense.value != null)
                            _buildDocStatusRow("Professional License", true),
                          if (controller.certifications.value != null)
                            _buildDocStatusRow("Certifications", true),
                          ...controller.additionalDocuments.map((doc) {
                            return doc['file'].value != null ? _buildDocStatusRow(doc['title'], true) : const SizedBox.shrink();
                          }).toList(),
                        ],
                      ),
                    ),

                    // 3. Availability (From Step 3)
                    _buildReviewSection(
                      icon: Icons.calendar_month,
                      title: "Availability",
                      onEdit: () => Get.back(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow("Time Zone", controller.selectedTimeZone.value),
                          _buildDetailRow("Available Days", controller.selectedDays.join(", ")),
                          _buildDetailRow("Preferred Slots", controller.preferredTimeSlots.join(" | ")),
                        ],
                      ),
                    ),

                    // 4. Pricing & Formats (From Step 4)
                    _buildReviewSection(
                      icon: Icons.attach_money,
                      title: "Pricing & Formats",
                      onEdit: () => Get.back(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow("Currency", controller.selectedCurrency.value),
                          if (controller.isVideoSelected.value)
                            _buildDetailRow("Video Call", "${controller.videoFeeController.text} ${controller.selectedCurrency.value}"),
                          if (controller.isPhoneSelected.value)
                            _buildDetailRow("Phone Call", "${controller.phoneFeeController.text} ${controller.selectedCurrency.value}"),
                          if (controller.isInPersonSelected.value)
                            _buildDetailRow("In-Person", "${controller.inPersonFeeController.text} ${controller.selectedCurrency.value}"),

                          if (controller.discountPercentageController.text.isNotEmpty)
                            _buildDetailRow("Discount", "${controller.discountPercentageController.text}%"),

                          if (controller.notesController.text.isNotEmpty)
                            _buildDetailRow("Additional Notes", controller.notesController.text),
                        ],
                      ),
                    ),

                    // 5. Selected Achievements
                    if (controller.selectedAchievements.isNotEmpty)
                      _buildReviewSection(
                        icon: Icons.emoji_events,
                        title: "Achievements",
                        onEdit: () => Get.back(),
                        child: Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: controller.selectedAchievements.map((skill) => _buildSkillChip(skill)).toList(),
                        ),
                      ),

                    SizedBox(height: 30.h),

                    // Confirm Button
                    CustomButton(
                      onTap: () {
                        controller.setupUserProfileConsultant();
                      },
                      title: "Confirm Profile",
                      textColor: AppColors.white,
                      icon: const Icon(Icons.check, color: Colors.white, size: 16),
                      fillColor: const Color(0xFFFBB03B),
                    ),

                    SizedBox(height: 12.h),

                    // Back to Edit Button
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: OutlinedButton.icon(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back, size: 18, color: Color(0xFF1E3A8A)),
                        label: const Text("Back to Edit",
                            style: TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.bold)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1E3A8A)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            );
          }


          Widget _buildReviewSection({required IconData icon, required String title, required VoidCallback onEdit, required Widget child}) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
                          SizedBox(width: 8.w),
                          CustomText(text: title, fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF1E3A8A)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  child,
                ],
              ),
            );
          }

          Widget _buildDetailRow(String label, String value) {
            return Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 13.sp, color: Colors.black87, height: 1.4),
                  children: [
                    TextSpan(text: "$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: value.isEmpty ? "N/A" : value),
                  ],
                ),
              ),
            );
          }

          Widget _buildDocStatusRow(String docName, bool isUploaded) {
            return Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.green.withOpacity(0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 16),
                      SizedBox(width: 8.w),
                      SizedBox(
                        width: 150.w,
                        child: Text(docName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  const Text("Uploaded", style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }

          Widget _buildSkillChip(String label) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                label,
                style: TextStyle(color: Colors.blue.shade700, fontSize: 11.sp, fontWeight: FontWeight.w500),
              ),
            );
          }
        }