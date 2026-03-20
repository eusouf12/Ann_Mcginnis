
import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
import 'package:ann_mcginnis/service/api_url.dart';
import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/booking_flow_controller.dart';

class BookingConfirmedScreen extends StatelessWidget {
  BookingConfirmedScreen({super.key});
  final BookingFlowController bookingFlowController = Get.put(BookingFlowController());
  final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final consultantId = args['consultantId'];
    final name = args['consultantName'];
    final img = args['consultantPhoto'];
    final jobTitle = args['jobTitle'];
    final bookDate = args['consultationDate'];
    final bookTime = args['consultationTime'];
    final type = args['consultationType'];
    final double originalPrice = double.tryParse(args['consultationPrice'].toString()) ?? 0.0;
    final String currencySymbol = args['currency'] ?? "";
    final double discountRate = double.tryParse(args['discount'].toString()) ?? 0.0;
    final experience = args['experience'];
    double discountAmount = (originalPrice * discountRate) / 100;
    double totalToPay = originalPrice - discountAmount;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingFlowController.getSingleConsultant(id: consultantId);
    });
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomRoyelAppbar(leftIcon: false,titleName:"Booking Confirmed" ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            _buildSuccessHeader(),
            SizedBox(height: 20.h),
            _buildConsultantCard(name, jobTitle, img),
            SizedBox(height: 20.h),
            _buildSectionTitle("Consultation Details"),
            _buildConsultationDetails(bookDate, bookTime, type),
            SizedBox(height: 20.h),
            _buildSectionTitle("Booking Summary"),
            _buildBookingSummary(type: type.toString(), originalPrice: originalPrice, totalPrice: totalToPay, currency: currencySymbol, discount: discountRate),
            SizedBox(height: 20.h),
            // _buildSectionTitle("Contact Information"),
            // _buildContactInfo(),
            // SizedBox(height: 30.h),
            _buildBottomButtons(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

// ================= Helper Widgets =================

  Widget _buildSuccessHeader() {
    return Column(
      children: [
        Container(
          height: 60.h,
          width: 60.h,
          decoration: const BoxDecoration(
            color: Color(0xFF00C853),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, color: Colors.white, size: 35.sp),
        ),
        SizedBox(height: 15.h),
        CustomText(text: "Booking Confirmed!",fontSize: 18.sp, color: Color(0xFF1A237E),fontWeight: FontWeight.bold,),
        SizedBox(height: 8.h),
        CustomText(text:  "Your consultation has been successfully booked",fontSize: 12.sp, color: Colors.grey,textAlign: TextAlign.center,),
      ],
    );
  }

  Widget _buildConsultantCard(String name, String title, String imgUrl) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          CustomNetworkImage(imageUrl :imgUrl.isNotEmpty ?ApiUrl.imageUrl + imgUrl  :  AppConstants.profileImage2, height: 80, width: 80,boxShape: BoxShape.circle,),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: name, fontSize: 18.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1A237E)),
                SizedBox(height: 4.h),
                CustomText(text: title,fontSize: 12.sp, color: Colors.grey,fontWeight: FontWeight.normal,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child:CustomText(text: title,fontSize: 14.sp, color: Color(0xFF0D1B2A),fontWeight: FontWeight.bold,),
      ),
    );
  }

  Widget _buildConsultationDetails(String date, String time, String type) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Icons.calendar_today,
            label: "Date",
            value: date,
          ),
          SizedBox(height: 15.h),
          _buildDetailRow(
            icon: Icons.access_time,
            label: "Time Slot",
            value: time,
          ),
          SizedBox(height: 15.h),
          _buildDetailRow(
            icon: type.toLowerCase().contains("video") ? Icons.videocam : Icons.phone,
            label: "Format",
            value: type,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.h,
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: const Color(0xFF1A237E), size: 20.sp),
        ),
        SizedBox(width: 15.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey[500])),
            SizedBox(height: 2.h),
            Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF0D1B2A))),
          ],
        ),
      ],
    );
  }

  Widget _buildBookingSummary({required String type, required double originalPrice, required double totalPrice, required String currency, required double discount}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
          ]
      ),
      child: Column(
        children: [
          _buildSummaryRow("Service", "$type Session"),
          SizedBox(height: 12.h),
          _buildSummaryRow("Subtotal", "$currency ${originalPrice.toStringAsFixed(2)}"),
          SizedBox(height: 12.h),
          _buildSummaryRow("Discount", "- $discount%", isDiscount: true),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(color: Colors.grey[200]),
          ),
          _buildSummaryRow("Total Amount", "$currency ${totalPrice.toStringAsFixed(2)}", isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false, bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text:title, fontSize: isTotal ? 16.sp : 14.sp, fontWeight: isTotal ? FontWeight.bold : FontWeight.w500, color: isTotal ? Colors.black : Colors.grey),
        CustomText(text:value, fontSize: isTotal ? 18.sp : 14.sp, fontWeight: FontWeight.bold, color: isDiscount ? Colors.red : (isTotal ? const Color(0xFF1A237E) : const Color(0xFF0D1B2A))),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return CustomButton(onTap: (){
      Get.toNamed(AppRoutes.userDashboard);
     },
      title: "Back To DashBoard",
      textColor: AppColors.white,
      fontSize: 16,
      icon: Icon(Icons.home,color: AppColors.white,),
    );
  }
}