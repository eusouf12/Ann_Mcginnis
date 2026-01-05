import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text/custom_text.dart';

class BookingDetailsController extends GetxController {

  // Documents List
  final clientDocuments = [
    {"name": "Resume.pdf", "date": "March 8, 2024", "type": "pdf"},
    {"name": "Passport_Copy.jpg", "date": "March 8, 2024", "type": "image"},
  ].obs;

  // Action Logs
  final actionLogs = [
    {"action": "Email confirmation sent", "status": "Success • 10:32 AM", "color": "green"},
    {"action": "Meeting link generated", "status": "Completed • 10:32 AM", "color": "blue"},
    {"action": "Calendar Invite sent", "status": "Pending • 10:35 AM", "color": "grey"},
  ].obs;

  // Methods
  void contactClient() => print("Contacting Client...");
  void rescheduleBooking() => print("Reschedule Clicked");
  void addNotes() => print("Add Notes Clicked");
  void joinMeeting() => print("Joining Meeting...");
}



class BookingDetailsScreen extends StatelessWidget {
  BookingDetailsScreen({super.key});

  final BookingDetailsController controller = Get.put(BookingDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:CustomRoyelAppbar(leftIcon: true,titleName: "Booking Details",),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Sarah Mitchell",
                  fontSize: 16.sp, fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:CustomText(
                      text: "Confirmed",
                      fontSize: 12.sp, fontWeight: FontWeight.bold,
                      color: Colors.blue
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            CustomText(
                text: "March 15, 2024 • 2:00 PM - 3:00 PM",
                fontSize: 10.sp, fontWeight: FontWeight.w500,
                color: AppColors.grey_1
            ),
            SizedBox(height: 15),

            // --- CONTACT BUTTON ---
            CustomButton(
              onTap:(){
              debugPrint("Contacting Client...");
            },
              title: "Contact Client",
              fontSize: 14.sp, fontWeight: FontWeight.bold,
              textColor: Colors.black,
              icon:  Icon(Icons.call, color: Colors.black, size: 20),
            ),
            SizedBox(height: 20),

            // --- CLIENT INFORMATION CARD ---
            CustomText(
              text: "Client Information",
              fontSize: 14.sp, fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Full Name",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      CustomText(
                         text: "Sara Rahman",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //Phone
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Phone",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      CustomText(
                         text: "+1 (555) 123-4567",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //"Email",
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Email",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      CustomText(
                         text:   "sarah.m@email.com",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //"Nationality"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Nationality",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      CustomText(
                         text: "Canadian",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //"Immigration Interest"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Immigration Interest",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      CustomText(
                         text: "Work Visa",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- CONSULTATION DETAILS CARD ---
            CustomText(
              text: "Consultation Details",
              fontSize: 14.sp, fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "Type"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Type",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      CustomText(
                          text: "General Consultation",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  // Duration
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Duration",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      CustomText(
                          text: "1 hour",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //  "Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Location",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      CustomText(
                          text:   "Virtual",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //join Meeting"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Meeting Link",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      TextButton(
                          onPressed: (){
                            debugPrint("Joining Meeting...");
                          },
                          child: CustomText(
                              text: "Join Meeting",
                              color: AppColors.primary1, fontSize: 14.sp
                          ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            const SizedBox(height: 15),

            // --- ACTION BUTTONS ROW ---
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap:(){
                      debugPrint("Contacting Client...");
                    },
                    title: "Reschedule",
                    fontSize: 12.sp, fontWeight: FontWeight.bold,
                    height: 48,
                    textColor: Colors.black,
                    icon:   Icon(Icons.calendar_today, size: 16),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CustomButton(
                    onTap:(){
                      debugPrint("Contacting Client...");
                    },
                    title: "Add Notes",
                    fontSize: 12.sp, fontWeight: FontWeight.bold,
                    height: 48,
                    textColor: Colors.white,
                    fillColor: AppColors.primary,
                    icon: Icon(Icons.note_add, size: 16,color:Colors.white,),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // --- BOOKING HISTORY ---
            CustomText(
              text: "Booking History",
              fontSize: 14.sp, fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            const SizedBox(height: 20),
            //Consultation Confirmed
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Icon(Icons.circle, size: 12, color: Colors.green),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Consultation Confirmed",
                      fontSize: 12.sp, fontWeight: FontWeight.bold,color: AppColors.grey,
                    ),
                    CustomText(
                      text: "March 10, 2024 • 10:00 AM",
                      fontSize: 10.sp, fontWeight: FontWeight.bold,color: AppColors.grey,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16),
            //"Booking Accepted"
            Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(Icons.circle, size: 12, color: Colors.blue),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Booking Accepted",
                  fontSize: 12.sp, fontWeight: FontWeight.bold,color: AppColors.grey,
                ),
                CustomText(
                  text: "March 10, 2024 • 10:00 AM",
                  fontSize: 10.sp, fontWeight: FontWeight.bold,color: AppColors.grey,
                ),
              ],
            )
          ],
        ),
            SizedBox(height: 16),
            //"Consultation Requested",
            Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(Icons.circle, size: 12, color: Colors.grey),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Consultation Requested",
                  fontSize: 12.sp, fontWeight: FontWeight.bold,color: AppColors.grey,
                ),
                CustomText(
                  text: "March 9, 2024 • 3:15 PM",
                  fontSize: 10.sp, fontWeight: FontWeight.bold,color: AppColors.grey,
                ),
              ],
            )
          ],
        ),
            const SizedBox(height: 20),

            // --- NOTES ---
            CustomText(
              text: "Notes",
              fontSize: 14.sp, fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Client is interested in work visa options for tech professionals. Has 5+ years experience in software development.\n\nAdded on March 10, 2024",
                style: TextStyle(fontSize: 13, color: AppColors.grey, height: 1.4),
              ),
            ),

            const SizedBox(height: 20),

            // --- CLIENT DOCUMENTS ---
            CustomText(
              text: "Client Documents",
              fontSize: 14.sp, fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            Obx(() => Column(
              children: controller.clientDocuments.map((doc) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      doc['type'] == 'pdf' ? Icons.picture_as_pdf : Icons.image,
                      color: doc['type'] == 'pdf' ? Colors.red : Colors.blue,
                      size: 28,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doc['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text("Uploaded: ${doc['date']}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ),
                    const Icon(Icons.download, color: AppColors.primary, size: 22),
                  ],
                ),
              )).toList(),
            )),

            const SizedBox(height: 20),

            // --- ACTIONS LOG ---
            CustomText(
              text: "Actions Log",
              fontSize: 14.sp, fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            Obx(() => Column(
              children: controller.actionLogs.map((log) {
                Color bgColor = log['color'] == 'green' ? const Color(0xFFE8F5E9)
                    : log['color'] == 'blue' ? const Color(0xFFE3F2FD)
                    : const Color(0xFFF5F5F5);
                Color textColor = log['color'] == 'green' ? Colors.green
                    : log['color'] == 'blue' ? Colors.blue
                    : Colors.grey;

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(log['action']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      Text(log['status']!, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textColor)),
                    ],
                  ),
                );
              }).toList(),
            )),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }



}