import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/booking_details_controller.dart';
import 'model/singel_booking_model.dart';

class BookingDetailsScreen extends StatelessWidget {
  BookingDetailsScreen({super.key});

  final BookingDetailsController bookingDetailsController = Get.put(
    BookingDetailsController(),
  );
  final String bookingId = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingDetailsController.getSingleBooking(id: bookingId);
    });

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Booking Details"),
      body: Obx(() {
        if (bookingDetailsController.isSingleBookingLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final bookingData = bookingDetailsController.singleBooking.value;
        if (bookingData == null) {
          return const Center(child: CustomText(text: "Booking Not Found"));
        }

        final user = bookingData.userId;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- CLIENT PROFILE HEADER ---
              _buildProfileHeader(user),
              SizedBox(height: 24.h),

              // --- BOOKING STATUS CARD ---
              _buildStatusCard(bookingData),
              SizedBox(height: 24.h),

              // --- CONSULTATION DETAILS ---
              _buildSectionTitle("Consultation Details"),
              SizedBox(height: 12.h),
              _buildInfoCard([
                _buildInfoRow(
                  "Date",
                  bookingData.consultationDate != null
                      ? DateFormat(
                          'MMM dd, yyyy',
                        ).format(DateTime.parse(bookingData.consultationDate!))
                      : "N/A",
                  Icons.calendar_today_outlined,
                ),
                _buildInfoRow(
                  "Time",
                  bookingData.consultationTime ?? "",
                  Icons.access_time_outlined,
                ),
                _buildInfoRow(
                  "Duration",
                  calculateDuration(bookingData.consultationTime ?? ""),
                  Icons.timer_outlined,
                ),
                _buildInfoRow(
                  "Type",
                  bookingData.consultationType?.capitalizeFirst ?? "",
                  Icons.videocam_outlined,
                ),
              ]),
              SizedBox(height: 24.h),

              // --- PAYMENT INFORMATION ---
              _buildSectionTitle("Payment Information"),
              SizedBox(height: 12.h),
              _buildInfoCard([
                _buildInfoRow(
                  "Price",
                  "${bookingData.currency} ${bookingData.originalAmount?.toInt()}",
                  Icons.payments_outlined,
                ),
                _buildInfoRow(
                  "Discount",
                  "${bookingData.discountRate?.toInt()}%",
                  Icons.local_offer_outlined,
                ),
                _buildInfoRow(
                  "Final Amount",
                  "${bookingData.currency} ${bookingData.amount?.toInt()}",
                  Icons.check_circle_outline,
                  valueColor: AppColors.primary1,
                  isBold: true,
                ),
                _buildInfoRow(
                  "Payment Status",
                  bookingData.paymentStatus?.capitalizeFirst ?? "",
                  Icons.info_outline,
                  valueColor: bookingData.paymentStatus == "paid"
                      ? Colors.green
                      : Colors.orange,
                ),
              ]),
              SizedBox(height: 24.h),

              // --- NOTES SECTION ---
              if (bookingData.consultantId?.profileDescription != null &&
                  bookingData.consultantId!.profileDescription!.isNotEmpty) ...[
                _buildSectionTitle("Consultant Info"),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: CustomText(
                    text: bookingData.consultantId?.profileDescription ?? "",
                    fontSize: 14.sp,
                    color: AppColors.black_02,
                    textAlign: TextAlign.start,
                    maxLines: 20,
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileHeader(dynamic user) {
    String imageUrl = (user?.avatar != null && user!.avatar!.isNotEmpty)
        ? ApiUrl.imageUrl + user.avatar!
        : AppConstants.profileImage2;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(3.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary1.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: CustomNetworkImage(
                imageUrl: imageUrl,
                height: 70.h,
                width: 70.h,
                boxShape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: user?.fullname ?? "Unknown Client",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primary1,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    CustomText(
                      text: user?.country ?? "Not Specified",
                      fontSize: 14.sp,
                      color: AppColors.black_02,
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: user?.email ?? "",
                  fontSize: 12.sp,
                  color: AppColors.grey_1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(SingleBookingData booking) {
    Color statusColor;
    switch (booking.bookingStatus?.toLowerCase()) {
      case "accepted":
        statusColor = Colors.green;
        break;
      case "pending":
        statusColor = Colors.orange;
        break;
      case "cancelled":
        statusColor = Colors.red;
        break;
      case "completed":
        statusColor = AppColors.primary1;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: statusColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Booking Status",
                fontSize: 12.sp,
                color: AppColors.black_02,
              ),
              SizedBox(height: 4.h),
              CustomText(
                text: booking.bookingStatus?.capitalizeFirst ?? "",
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ],
          ),
          Icon(Icons.stars, color: statusColor, size: 28.sp),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return CustomText(
      text: title,
      fontSize: 17.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: children
            .expand(
              (w) => [
                w,
                if (w != children.last)
                  Divider(color: Colors.grey[100], height: 24.h),
              ],
            )
            .toList(),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: AppColors.primary1.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: AppColors.primary1, size: 18.sp),
        ),
        SizedBox(width: 12.w),
        CustomText(text: label, fontSize: 14.sp, color: AppColors.black_02),
        const Spacer(),
        CustomText(
          text: value,
          fontSize: 14.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          color: valueColor ?? AppColors.primary,
        ),
      ],
    );
  }

  String calculateDuration(String timeRange) {
    try {
      List<String> parts = timeRange.split('-');
      if (parts.length != 2) return "30 Min";
      List<String> startParts = parts[0].trim().split(':');
      List<String> endParts = parts[1].trim().split(':');

      final now = DateTime.now();
      final startTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(startParts[0]),
        int.parse(startParts[1]),
      );
      final endTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(endParts[0]),
        int.parse(endParts[1]),
      );

      final duration = endTime.difference(startTime);
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;

      if (hours == 0) return "$minutes Min";
      if (minutes == 0) return "$hours Hours";
      return "$hours Hr $minutes Min";
    } catch (e) {
      return "30 Min";
    }
  }
}
