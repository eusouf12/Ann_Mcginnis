import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/consulltant_details-controller.dart';

class ConsultationProfileScreen extends StatelessWidget {
  ConsultationProfileScreen({super.key});

  final ConsultantDetailsController controller = Get.put(ConsultantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: CustomText(
          text: "Consultation Profile",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primary1, // আপনার কালার ব্যবহার করা হয়েছে
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // --- 1. YOUR BIO ---
            _buildLabel("Your Bio"),
            SizedBox(height: 10),
            Container(
              decoration: _fieldDecoration(),
              child: TextField(
                controller: controller.bioController,
                maxLines: 4,
                decoration: _inputDecoration("Tell us about yourself..."),
              ),
            ),

            SizedBox(height: 25),

            // --- 2. SPECIALIZATIONS ---
            _buildLabel("Specializations"),
            SizedBox(height: 10),
            Container(
              decoration: _fieldDecoration(),
              child: TextField(
                controller: controller.specializationInputController,
                decoration: _inputDecoration("Enter your areas of expertise..."),
              ),
            ),
            SizedBox(height: 15),

            // Add Button (Blue)
            SizedBox(
              width: 160,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: controller.addSpecialization,
                child: Text("Add Specialization", style: TextStyle(color: Colors.white)),
              ),
            ),

            SizedBox(height: 15),

            // Added Specialization List
            Obx(() => ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.specializationList.length,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F9FA), // Light Grey
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: controller.specializationList[index],
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      InkWell(
                        onTap: () => controller.removeSpecialization(index),
                        child: Icon(Icons.delete, color: Colors.redAccent, size: 20),
                      )
                    ],
                  ),
                );
              },
            )),

            SizedBox(height: 25),

            // --- 3. CONSULTATION PRICING ---
            _buildLabel("Consultation Pricing"),
            SizedBox(height: 10),
            Row(
              children: [
                // Currency Dropdown
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedCurrency.value,
                      items: ["USD", "BDT", "EUR"].map((e) =>
                          DropdownMenuItem(value: e, child: Text(e, style: TextStyle(fontWeight: FontWeight.bold)))
                      ).toList(),
                      onChanged: (val) => controller.selectedCurrency.value = val!,
                    ),
                  )),
                ),
                SizedBox(width: 10),
                // Price Input
                Expanded(
                  child: Container(
                    decoration: _fieldDecoration(),
                    child: TextField(
                      controller: controller.priceController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration("Amount"),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            // --- 4. DOCUMENTATION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabel("Documentation"),
                // Upload Button (Yellow)
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: AppColors.yellow1,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(
                    child: Text(
                      "Upload\nDocumentation",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary1),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),

            // Document List
            Obx(() => ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.documentList.length,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                var doc = controller.documentList[index];
                bool isPdf = doc['type'] == 'pdf';

                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPdf ? Icons.picture_as_pdf : Icons.image,
                        color: isPdf ? Colors.red : Colors.blue,
                        size: 30,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: doc['name'],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                            CustomText(
                              text: "Uploaded: ${doc['date']}",
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.remove_red_eye, color: AppColors.primary1, size: 20),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () => controller.removeDocument(index),
                        child: Icon(Icons.delete, color: Colors.redAccent, size: 20),
                      ),
                    ],
                  ),
                );
              },
            )),

            SizedBox(height: 40),

            // --- SAVE BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                onPressed: controller.saveChanges,
                child: Text(
                  "SAVE CHANGES",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper Methods for Styling to keep build method clean
  Widget _buildLabel(String text) {
    return CustomText(
      text: text,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xFF444444),
    );
  }

  BoxDecoration _fieldDecoration() {
    return BoxDecoration(
      color: Color(0xFFF3F4F6), // Light grayish input bg
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(15),
      hintStyle: TextStyle(color: Colors.grey),
    );
  }
}

// =============================================
// MOCK CLASSES (আপনার প্রোজেক্টে এগুলো থাকলে বাদ দেবেন)
// =============================================
class AppColors {
  static const Color primary1 = Color(0xFF0D3B66);
  static const Color yellow1 = Color(0xFFFFC107);
  static const Color black = Colors.black87;
  static const Color grey_1 = Colors.grey;
}

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const CustomText({
    super.key, required this.text, this.fontSize, this.fontWeight, this.color, this.textAlign
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}