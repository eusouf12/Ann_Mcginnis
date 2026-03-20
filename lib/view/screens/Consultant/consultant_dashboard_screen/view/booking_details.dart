import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../Immigration_Seeker_Screen/Recommended_dashboard_Screen/model/booking_consultaion.dart';


class BookingDetailsController extends GetxController {


  // Methods
  void contactClient() => print("Contacting Client...");
  void rescheduleBooking() => print("Reschedule Clicked");
  void addNotes() => print("Add Notes Clicked");
  void joinMeeting() => print("Joining Meeting...");
}



class BookingDetailsScreen extends StatelessWidget {
  BookingDetailsScreen({super.key});

  final BookingDetailsController controller = Get.put(BookingDetailsController());
  final Booking booking = Get.arguments;

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
                  text: booking.consultantId?.userId?.fullname ?? "",
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
                      text: "Completed",
                      fontSize: 12.sp, fontWeight: FontWeight.bold,
                      color: Colors.blue
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            CustomText(
                text:  booking.paymentStatus == "paid"? DateFormat('MMM dd, yyyy').format(DateTime.parse(booking.updatedAt!)) : "",
                fontSize: 10.sp, fontWeight: FontWeight.w500,
                color: AppColors.grey_1
            ),
            SizedBox(height: 15),

            // --- CONTACT BUTTON ---
            // CustomButton(
            //   onTap:(){
            //   debugPrint("Contacting Client...");
            // },
            //   title: "Contact Client",
            //   fontSize: 14.sp, fontWeight: FontWeight.bold,
            //   textColor: Colors.black,
            //   icon:  Icon(Icons.call, color: Colors.black, size: 20),
            // ),
            // SizedBox(height: 20),

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
                          text: booking.consultantId?.userId?.fullname ?? "",
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
                         text:  booking.consultantId?.userId?.email ?? "",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //"Nationality"
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
                         text: booking.consultantId?.businessName ??"",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            //payment section
            CustomText(
              text: "Payment Information",
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
                  //Original Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Original Amount",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      CustomText(
                          text: "${booking.currency} ${booking.originalAmount?.toInt()}",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //"Discount",
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Discount",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      CustomText(
                          text:  "${booking.discountRate?.toInt()} %",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  //"payment"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Payment Amount",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                      CustomText(
                          text: "${booking.currency} ${booking.amount?.toInt()}",
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
                          text:booking.consultantId?.jobTitle ?? "",
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
                      if (booking.consultationTime != null)
                        CustomText(
                          text: " ${calculateDuration(booking.consultationTime!)}",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary1,
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
                          text: booking.consultationType== "video-call" || booking.consultationType== "audio-call" ?  "Virtual" : "In Person",
                          color: AppColors.grey, fontSize: 14.sp
                      ),
                    ],
                  ),

                ],
              ),
            ),
            const SizedBox(height: 15),
            CustomText(
              text: "Notes",
              fontSize: 14.sp, fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            const SizedBox(height: 20),
            //note
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child:CustomText(text: booking.consultantId?.additionalNotes ?? "",fontSize: 13, color: AppColors.grey,maxLines: 20,textAlign: TextAlign.start,)
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  String calculateDuration(String timeRange) {
    try {
      List<String> parts = timeRange.split('-');
      if (parts.length != 2) return "";
      List<String> startParts = parts[0].trim().split(':');
      List<String> endParts = parts[1].trim().split(':');

      final now = DateTime.now();
      final startTime = DateTime(now.year, now.month, now.day, int.parse(startParts[0]), int.parse(startParts[1]));
      final endTime = DateTime(now.year, now.month, now.day, int.parse(endParts[0]), int.parse(endParts[1]));

      final duration = endTime.difference(startTime);
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;

      if (minutes == 0) {
        return "$hours Hours";
      } else {
        return "$hours Hr $minutes Min";
      }
    } catch (e) {
      return "";
    }
  }

}