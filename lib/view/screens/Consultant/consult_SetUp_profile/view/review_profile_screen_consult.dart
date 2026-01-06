import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text/custom_text.dart';

class ConsultReviewProfileScreen extends StatelessWidget {
  const ConsultReviewProfileScreen({super.key});

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
          style: TextStyle(color: const Color(0xFF1E3A8A), fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.black54))],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: "Review Your Profile", fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
            SizedBox(height: 5.h),
            const CustomText(text: "Please review all information before confirming your profile setup", fontSize: 12, color: Colors.grey),

            SizedBox(height: 25.h),

            // 1. Personal Bio Section
            _buildReviewSection(
              icon: Icons.person,
              title: "Personal Bio",
              onEdit: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow("Name", "Dr. Sarah Johnson"),
                  _buildDetailRow("Title", "Senior Business Consultant"),
                  _buildDetailRow("Experience", "8+ years in strategic consulting"),
                  _buildDetailRow("Specialization", "Digital transformation, process optimization"),
                ],
              ),
            ),

            // 2. Documents Section
            _buildReviewSection(
              icon: Icons.description,
              title: "Documents",
              onEdit: () {},
              child: Column(
                children: [
                  _buildDocStatusRow("Resume/CV", true),
                  _buildDocStatusRow("Professional Certificates", true),
                  _buildDocStatusRow("Portfolio", true),
                ],
              ),
            ),

            // 3. Availability Section
            _buildReviewSection(
              icon: Icons.calendar_month,
              title: "Availability",
              onEdit: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow("Working Hours", "9:00 AM - 6:00 PM (EST)"),
                  _buildDetailRow("Days Available", "Monday - Friday"),
                  _buildDetailRow("Time Zone", "Eastern Standard Time"),
                  _buildDetailRow("Project Duration", "3-6 months preferred"),
                ],
              ),
            ),

            // 4. Pricing Section
            _buildReviewSection(
              icon: Icons.attach_money,
              title: "Pricing",
              onEdit: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow("Hourly Rate", "\$150/hour"),
                  _buildDetailRow("Project Rate", "\$15,000 - \$50,000"),
                  _buildDetailRow("Payment Terms", "Net 30 days"),
                  _buildDetailRow("Currency", "USD"),
                ],
              ),
            ),

            // 5. Skills Section
            _buildReviewSection(
              icon: Icons.lightbulb,
              title: "Skills & Expertise",
              onEdit: () {},
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  _buildSkillChip("Strategy Development"),
                  _buildSkillChip("Digital Transformation"),
                  _buildSkillChip("Process Optimization"),
                  _buildSkillChip("Change Management"),
                  _buildSkillChip("Data Analytics"),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Confirm Button
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.consultantDashboard);
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
                label: const Text("Back to Edit", style: TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.bold)),
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

  // --- হেল্পার উইজেটস ---

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
              TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 14, color: Colors.blue),
                label: const Text("Edit", style: TextStyle(color: Colors.blue, fontSize: 12)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
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
          style: TextStyle(fontSize: 13.sp, color: Colors.black87),
          children: [
            TextSpan(text: "$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
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
              Text(docName, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
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