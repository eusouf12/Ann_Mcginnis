import 'package:ann_mcginnis/utils/app_const/app_const.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../Recommended_dashboard_Screen/widget/custom_detais_profile_card.dart';

class ConsultProfileViewDetails extends StatelessWidget {
  const ConsultProfileViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomRoyelAppbar(leftIcon: true,titleName: "Consultant Profile"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomDetailsProfileCard(
              imageUrl: AppConstants.profileImage2,
              name: "Dr. Sarah Johnson",
              title: "Clinical Psychologist",
              rating: 4.9,
              totalReviews: "127",
              experience: "10",
              patients: "500",
            ),
            _buildFeesSection(),
            _buildAvailabilitySection(),
            _buildAboutSection(),
            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomSheet: _buildBottomActionButton(),
    );
  }


  // ২. কনসালটেশন ফি সেকশন
  Widget _buildFeesSection() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(text: "Consultation Fees", fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black, bottom: 15),
          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomText(text: "Video Consultation", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                    CustomText(text: "60 minutes session", fontSize: 12, color: Colors.grey),
                  ],
                ),
                const CustomText(text: "\$ 85", fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ৩. অ্যাভেইল্যাবিলিটি সেকশন (টাইম স্লট)
  Widget _buildAvailabilitySection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(text: "Availability", fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              TextButton.icon(onPressed: () {}, icon: const Icon(Icons.calendar_month, size: 16), label: const Text("Change Date")),
            ],
          ),
          const Center(child: CustomText(text: "Today, December 9, 2024", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black, bottom: 15)),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3,
            children: [
              _timeSlot("9:00 AM", true),
              _timeSlot("10:30 AM", true),
              _timeSlot("12:00 PM", false),
              _timeSlot("2:00 PM", true),
              _timeSlot("2:30 PM", true),
              _timeSlot("3:00 PM", false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _timeSlot(String time, bool isAvailable) {
    return Container(
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green.withOpacity(0.1) : Colors.white,
        border: Border.all(color: isAvailable ? Colors.green : Colors.grey),
        borderRadius: BorderRadius.circular(8.r),
      ),
      alignment: Alignment.center,
      child: CustomText(text: time, color: isAvailable ? Colors.green : Colors.black, fontWeight: FontWeight.w500),
    );
  }

  // ৪. অ্যাবাউট সেকশন
  Widget _buildAboutSection() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CustomText(text: "About", fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black, bottom: 10),
          CustomText(
            textAlign: TextAlign.start,
            text: "Dr. Sarah Johnson is a licensed clinical psychologist with over 10 years of experience in treating anxiety, depression, and relationship issues...",
            fontSize: 13,
            color: Colors.black54,
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  // ৫. বটম বুকিং বাটন
  Widget _buildBottomActionButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.black12))),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        onPressed: () {},
        child: const CustomText(text: "Book Now", fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}