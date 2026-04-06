import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../Immigration_Seeker_Screen/Recommended_dashboard_Screen/model/booking_consultaion.dart';

class PaymentDetailsScreen extends StatelessWidget {
  PaymentDetailsScreen({super.key});

  final Booking booking = Get.arguments as Booking;

  @override
  Widget build(BuildContext context) {
    final consultant = booking.consultantId;
    final user = booking.userId;
    final bool isPaid = booking.paymentStatus == "paid";

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Payment Details",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Payment Status Banner ──
            _buildStatusBanner(isPaid, booking.bookingStatus),
            SizedBox(height: 20.h),

            // ── Consultant Info Card ──
            _buildConsultantCard(consultant, user),
            SizedBox(height: 20.h),

            // ── Consultation Details ──
            _buildSectionTitle("Consultation Details"),
            SizedBox(height: 12.h),
            _buildInfoCard([
              _buildInfoRow(
                "Date",
                booking.consultationDate != null
                    ? DateFormat('EEEE, MMM dd, yyyy')
                        .format(DateTime.parse(booking.consultationDate!))
                    : "N/A",
                Icons.calendar_today_outlined,
              ),
              _buildInfoRow(
                "Time",
                booking.consultationTime ?? "N/A",
                Icons.access_time_outlined,
              ),
              _buildInfoRow(
                "Type",
                _formatConsultationType(booking.consultationType ?? ""),
                _getConsultationIcon(booking.consultationType ?? ""),
              ),
              _buildInfoRow(
                "Duration",
                _calculateDuration(booking.consultationTime ?? ""),
                Icons.timer_outlined,
              ),
            ]),
            SizedBox(height: 20.h),

            // ── Payment Breakdown ──
            _buildSectionTitle("Payment Breakdown"),
            SizedBox(height: 12.h),
            _buildPaymentBreakdownCard(booking),
            SizedBox(height: 20.h),

            // ── Payment Info ──
            _buildSectionTitle("Payment Info"),
            SizedBox(height: 12.h),
            _buildInfoCard([
              _buildInfoRow(
                "Payment Status",
                (booking.paymentStatus ?? "").capitalizeFirst ?? "",
                Icons.payments_outlined,
                valueColor: isPaid ? Colors.green : Colors.orange,
              ),
              _buildInfoRow(
                "Booking Status",
                (booking.bookingStatus ?? "").capitalizeFirst ?? "",
                Icons.bookmark_outline,
                valueColor: _getBookingStatusColor(booking.bookingStatus ?? ""),
              ),
              if (isPaid && booking.paymentDate != null)
                _buildInfoRow(
                  "Payment Date",
                  DateFormat('MMM dd, yyyy')
                      .format(DateTime.parse(booking.paymentDate!)),
                  Icons.check_circle_outline,
                  valueColor: Colors.green,
                ),
              _buildInfoRow(
                "Booked On",
                booking.createdAt != null
                    ? DateFormat('MMM dd, yyyy')
                        .format(DateTime.parse(booking.createdAt!))
                    : "N/A",
                Icons.history_outlined,
              ),
            ]),
            SizedBox(height: 20.h),

            // ── Consultant Additional Notes ──
            if ((consultant?.additionalNotes ?? "").isNotEmpty) ...[
              _buildSectionTitle("Notes from Consultant"),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded,
                        color: AppColors.primary1, size: 18.sp),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomText(
                        text: consultant?.additionalNotes ?? "",
                        fontSize: 13,
                        color: const Color(0xFF546E7A),
                        textAlign: TextAlign.start,
                        maxLines: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],

            // ── Booking ID ──
            Center(
              child: CustomText(
                text: "Booking ID: ${booking.id ?? ''}",
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  // ─────────────────── Status Banner ───────────────────
  Widget _buildStatusBanner(bool isPaid, String? bookingStatus) {
    Color bgColor;
    Color textColor;
    IconData icon;
    String message;

    if (isPaid) {
      bgColor = const Color(0xFFE8F5E9);
      textColor = const Color(0xFF2E7D32);
      icon = Icons.check_circle_rounded;
      message = "Payment Completed";
    } else if (bookingStatus == "cancelled" || bookingStatus == "rejected") {
      bgColor = const Color(0xFFFFEBEE);
      textColor = const Color(0xFFC62828);
      icon = Icons.cancel_rounded;
      message = bookingStatus == "cancelled"
          ? "Booking Cancelled"
          : "Booking Rejected";
    } else {
      bgColor = const Color(0xFFFFF8E1);
      textColor = const Color(0xFFF57F17);
      icon = Icons.pending_actions_rounded;
      message = "Payment Pending";
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: textColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: textColor, size: 32.sp),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: message,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  text: isPaid
                      ? "Your payment has been received successfully"
                      : "Complete payment to confirm your consultation",
                  fontSize: 12,
                  color: textColor.withOpacity(0.8),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────── Consultant Card ───────────────────
  Widget _buildConsultantCard(Consultant? consultant, User? user) {
    final String imageUrl =
        (consultant?.userId?.avatar != null &&
                consultant!.userId!.avatar!.isNotEmpty)
            ? "${ApiUrl.imageUrl}${consultant.userId!.avatar}"
            : AppConstants.profileImage;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
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
              gradient: LinearGradient(
                colors: [AppColors.primary1, AppColors.primary],
              ),
            ),
            child: ClipOval(
              child: CustomNetworkImage(
                imageUrl: imageUrl,
                height: 62.h,
                width: 62.h,
                boxShape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: consultant?.userId?.fullname ?? "Consultant",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 3.h),
                CustomText(
                  text: consultant?.jobTitle ?? "",
                  fontSize: 13,
                  color: const Color(0xFF546E7A),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 3.h),
                CustomText(
                  text: consultant?.businessName ?? "",
                  fontSize: 12,
                  color: AppColors.primary1,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────── Payment Breakdown Card ───────────────────
  Widget _buildPaymentBreakdownCard(Booking booking) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildBreakdownRow(
            "Original Price",
            "${booking.currency ?? 'USD'} ${booking.originalAmount?.toInt() ?? 0}",
            color: const Color(0xFF374151),
          ),
          SizedBox(height: 10.h),
          _buildBreakdownRow(
            "Discount (${booking.discountRate?.toInt() ?? 0}%)",
            "- ${booking.currency ?? 'USD'} ${booking.discountAmount?.toInt() ?? 0}",
            color: Colors.green,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(color: Colors.grey.shade200),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Total Paid",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary1, AppColors.primary],
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomText(
                  text:
                      "${booking.currency ?? 'USD'} ${booking.amount?.toInt() ?? 0}",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: label,
          fontSize: 14,
          color: const Color(0xFF6B7280),
        ),
        CustomText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color ?? AppColors.black,
        ),
      ],
    );
  }

  // ─────────────────── Shared Widgets ───────────────────
  Widget _buildSectionTitle(String title) {
    return CustomText(
      text: title,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: children.expand((w) {
          return [
            w,
            if (w != children.last)
              Divider(color: Colors.grey[100], height: 22.h),
          ];
        }).toList(),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: AppColors.primary1.withOpacity(0.07),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: AppColors.primary1, size: 17.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CustomText(
            text: label,
            fontSize: 13,
            color: const Color(0xFF6B7280),
            textAlign: TextAlign.start,
          ),
        ),
        CustomText(
          text: value,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: valueColor ?? AppColors.primary,
        ),
      ],
    );
  }

  // ─────────────────── Helpers ───────────────────
  String _formatConsultationType(String type) {
    switch (type) {
      case "video-call":
        return "Video Call";
      case "phone-call":
        return "Phone Call";
      case "in-person":
        return "In Person";
      default:
        return type.capitalizeFirst ?? type;
    }
  }

  IconData _getConsultationIcon(String type) {
    switch (type) {
      case "video-call":
        return Icons.videocam_outlined;
      case "phone-call":
        return Icons.phone_outlined;
      case "in-person":
        return Icons.location_on_outlined;
      default:
        return Icons.calendar_today_outlined;
    }
  }

  Color _getBookingStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "accepted":
        return Colors.green;
      case "completed":
        return AppColors.primary1;
      case "pending":
        return Colors.orange;
      case "rejected":
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _calculateDuration(String timeRange) {
    try {
      final parts = timeRange.split('-');
      if (parts.length != 2) return "N/A";
      final startParts = parts[0].trim().split(':');
      final endParts = parts[1].trim().split(':');
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day,
          int.parse(startParts[0]), int.parse(startParts[1]));
      final end = DateTime(now.year, now.month, now.day,
          int.parse(endParts[0]), int.parse(endParts[1]));
      final duration = end.difference(start);
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;
      if (hours == 0) return "$minutes Min";
      if (minutes == 0) return "$hours Hours";
      return "$hours Hr $minutes Min";
    } catch (_) {
      return "N/A";
    }
  }
}
