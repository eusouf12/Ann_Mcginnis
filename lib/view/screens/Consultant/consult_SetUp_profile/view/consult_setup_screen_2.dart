import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/consult_setup_controller.dart';
import '../widget/custom_progressbar.dart';
import '../widget/custom_upload_card.dart';
import 'consult_setup_screen_3.dart';

class ConsultSetupScreen2 extends StatelessWidget {
  ConsultSetupScreen2({super.key});
  final ConsultSetupController controller = Get.put(ConsultSetupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Global Jump"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            const CustomText(text: "Step 2 of 4", fontSize: 14, color: Color(0xFF1E3A8A), fontWeight: FontWeight.w600),
            SizedBox(height: 8.h),
            CustomProgressBar(factor: 0.50),
            SizedBox(height: 30.h),
            Text(
              "Upload Your Professional\nDocuments",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              "Upload your certifications, licenses, and other credentials securely",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
            SizedBox(height: 30.h),

            // --- Professional License ---
            Obx(() => CustomUploadCard(
              title: "Professional License",
              hintText: controller.professionalLicense.value == null
                  ? "Upload PDF, JPG or PNG"
                  : "Selected: ${controller.professionalLicense.value!.path.split('/').last}",
              icon: Icons.badge_outlined,
              onChooseFile: controller.pickProfessionalLicense,
            )),
            SizedBox(height: 20.h),

            // --- Certifications (Optional) ---
            Obx(() => CustomUploadCard(
              title: "Certifications(Optional)",
              hintText: controller.certifications.value == null
                  ? "Upload PDF, JPG or PNG"
                  : "Selected: ${controller.certifications.value!.path.split('/').last}",
              icon: Icons.card_membership_outlined,
              onChooseFile: controller.pickCertifications,
            )),
            SizedBox(height: 20.h),

            // --- Additional Documents (Array/List) ---
            Obx(() => Column(
              children: List.generate(controller.additionalDocuments.length, (index) {
                final doc = controller.additionalDocuments[index];
                return Column(
                  children: [
                    CustomUploadCard(
                      title: doc['title'],
                      hintText: doc['file'].value == null
                          ? "Upload PDF, JPG or PNG"
                          : "Selected: ${doc['file'].value!.path.split('/').last}",
                      icon: Icons.description_outlined,
                      onChooseFile: () => controller.pickAdditionalDocument(index),
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }),
            )),

            // Add More Button
            DottedBorder(
              color: Colors.blue.shade200,
              borderType: BorderType.RRect,
              radius: Radius.circular(10.r),
              child: InkWell(
                onTap: controller.addMoreDocument,
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Colors.blue),
                      SizedBox(width: 6),
                      Text("Add More Documents", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),

            // Continue Button
            CustomButton(
              onTap: () => Get.to(ConsultSetupScreen3()),
              title: "Continue",
              fillColor: const Color(0xFFFBB03B),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}