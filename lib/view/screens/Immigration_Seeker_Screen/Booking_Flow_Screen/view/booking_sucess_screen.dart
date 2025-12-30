
import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          "Booking Confirmed",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            _buildSuccessHeader(),
            SizedBox(height: 20.h),
            _buildConsultantCard(),
            SizedBox(height: 20.h),
            _buildSectionTitle("Consultation Details"),
            _buildConsultationDetails(),
            SizedBox(height: 20.h),
            _buildSectionTitle("Booking Summary"),
            _buildBookingSummary(),
            SizedBox(height: 20.h),
            _buildSectionTitle("Contact Information"),
            _buildContactInfo(),
            SizedBox(height: 30.h),
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
        Text(
          "Booking Confirmed!",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A237E),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Your consultation has been successfully booked",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildConsultantCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              "https://i.pravatar.cc/150?img=5",
              height: 60.h,
              width: 60.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr. Sarah Johnson",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A237E),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Business Strategy Consultant",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      "4.9 (127 reviews)",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
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
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0D1B2A),
          ),
        ),
      ),
    );
  }

  Widget _buildConsultationDetails() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Icons.calendar_today,
            label: "Date",
            value: "Monday, December 18, 2023",
          ),
          SizedBox(height: 15.h),
          _buildDetailRow(
            icon: Icons.access_time,
            label: "Time",
            value: "2:00 PM - 3:00 PM EST",
          ),
          SizedBox(height: 15.h),
          _buildDetailRow(
            icon: Icons.videocam,
            label: "Format",
            value: "Video Call",
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
            color: const Color(0xFFE3F2FD), // Light Blue
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: const Color(0xFF1A237E), size: 20.sp),
        ),
        SizedBox(width: 15.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
            ),
            SizedBox(height: 2.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0D1B2A),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBookingSummary() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildSummaryRow("Service", "1-Hour Strategy Session"),
          SizedBox(height: 12.h),
          _buildSummaryRow("Specialization", "Business Growth"),
          SizedBox(height: 12.h),
          _buildSummaryRow("Duration", "60 minutes"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(color: Colors.grey[200]),
          ),
          _buildSummaryRow("Total Amount", "\$150", isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? Colors.black : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: FontWeight.bold,
            color: isTotal ? const Color(0xFF1A237E) : const Color(0xFF0D1B2A),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Icons.email,
            label: "Email",
            value: "sarah.johnson@consultpro.com",
          ),
          SizedBox(height: 15.h),
          _buildDetailRow(
            icon: Icons.phone,
            label: "Phone",
            value: "+1 (555) 123-4567",
          ),
          SizedBox(height: 15.h),
// Info Box
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD).withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info, color: const Color(0xFF1A237E), size: 18.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                      children: const [
                        TextSpan(
                          text: "Meeting Link: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "You will receive a video call link via email 30 minutes before your scheduled consultation.",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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