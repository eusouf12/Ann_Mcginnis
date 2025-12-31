import 'package:ann_mcginnis/core/app_routes/app_routes.dart';
import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/utils/app_const/app_const.dart';
import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../Immigration_Seeker_Screen/Recommended_Countries_Screen/widget/custom_country_progress_card.dart';
import '../../../Immigration_Seeker_Screen/Recommended_dashboard_Screen/widget/book_consultation_card.dart';
import '../../../Immigration_Seeker_Screen/Recommended_dashboard_Screen/widget/custom_payment_card.dart';
import '../../../Immigration_Seeker_Screen/SetUp_Profile_Screen/model/custom_save_countries.dart';
import '../../profile_screen/consult_profile_screen.dart';
import '../../profile_screen/widget/custom_appoinment_card.dart';
import '../../profile_screen/widget/upcoming_appointments_card.dart';
import '../controller/booki_controller_consult.dart';
import '../controller/consult_dashboard_controller.dart';


class ConsultantDashboard extends StatelessWidget {
  ConsultantDashboard({super.key});
  final ConsultDashboardController controller = Get.put(ConsultDashboardController());
  final BookingController bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              CustomImage(imageSrc: AppImages.logoApp, height: 28.h, width: 28.w, ),
              SizedBox(width: 8.w),
              CustomText(text: "Global Jump", fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.primary, textAlign: TextAlign.start,),
            ],
          ),
          actions: [
            // 3. Notification
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {
                    },
                    icon: Icon(
                      Icons.notifications_none,
                      color: const Color(0xFF0D1B2A),
                      size: 26.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  // Red Badge
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16.w,
                        minHeight: 16.w,
                      ),
                      child: Center(
                        child: Text(
                          "2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 15.w),
            // 4. Profile Image
            GestureDetector(
              onTap: () {
                Get.to(ProfileScreen());
              },
              child:   ClipOval(
                child: CustomNetworkImage(
                  imageUrl: AppConstants.profileImage2,
                  height: 50.h,
                  width: 50.h,
                  boxShape: BoxShape.circle,
                ),
              ),
            ),

            SizedBox(width: 20.w),
          ],
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text: "Welcome, Sarah!",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary1,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 20.h),
            // toggle tab
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => Container(
                padding: EdgeInsets.only(top: 20.h,left: 10.h,right: 10.h,),
                decoration: BoxDecoration(
                  color: AppColors.primary1,
                ),
                child: Row(
                  children: List.generate(controller.tabs.length, (index) {
                    bool isSelected = controller.selectedConsultantDashboardTab.value == index;
                    return GestureDetector(
                      onTap: () => controller.changeTab(index),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 20.h, right: 10.w, left: 10.w),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isSelected ? AppColors.yellow1 : Colors.transparent,
                              width: 4.h,
                            ),
                          ),
                        ),
                        child: CustomText(
                          text: controller.tabs[index],
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color:  Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              )),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Obx(() {
                    // TAB - 00
                    if (controller.selectedConsultantDashboardTab.value == 0) {
                      //Eligibility Results
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1,
                            children: const [
                              CustomAppointmentCard(
                                icon: Icons.event_available,
                                value: '24',
                                label: 'Appointments',
                              ),
                              CustomAppointmentCard(
                                icon: Icons.mail,
                                value: '8',
                                label: 'New Messages',
                              ),
                              CustomAppointmentCard(
                                icon: Icons.attach_money,
                                value: '\$ 4,230',
                                label: 'This Month',
                              ),
                              CustomAppointmentCard(
                                icon: Icons.access_time_filled,
                                value: '18',
                                label: 'Hours Available',
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          //btn
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  // ================= BUTTON 1 =================
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.12),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: SizedBox(
                                      width: 165.w,
                                      height: 40.h,
                                      child: CustomButton(
                                        onTap: () {},
                                        title: "New Appointment",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        isBorder: true,
                                        borderColor: Colors.grey,
                                        fillColor: AppColors.yellow1,
                                        textColor: AppColors.primary1,
                                        icon: Icon(Icons.add, color: AppColors.primary1, size: 18.sp),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 12.w),

                                  // ================= BUTTON 2 =================
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.10),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: SizedBox(
                                      width: 150.w,
                                      height: 40.h,
                                      child: CustomButton(
                                        onTap: () {},
                                        title: "Messages",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fillColor: AppColors.white,
                                        textColor: Colors.black,
                                        isBorder: true,
                                        borderColor: Colors.grey,
                                        icon: Icon(Icons.message, color: AppColors.black, size: 18.sp),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 12.w),

                                  // ================= BUTTON 3 =================
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary1.withOpacity(0.25),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: SizedBox(
                                      width: 160.w,
                                      height: 40.h,
                                      child: CustomButton(
                                        onTap: () {},
                                        title: "Calendar",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fillColor: AppColors.primary1,
                                        textColor: Colors.white,
                                        icon: Icon(Icons.calculate_outlined,
                                            color: AppColors.white, size: 18.sp),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Upcoming Appointments", fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary1,),
                              GestureDetector(
                                  onTap: () {},
                                  child: CustomText(text: "View All", fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.yellow1,)
                              )
                            ],
                          ),
                          SizedBox(height: 20.h),
                          UpcomingAppointmentsCard(
                            title: "John Robertson" ,
                            subTitle: "Visa Consultant - Australia",
                            img: AppConstants.profileImage2,
                            isConfirm: true,
                            onTapViewDetails: (){
                              Get.toNamed(AppRoutes.consultProfileViewDetails);
                            },
                            onTapConfirm: (){
                              // Get.to(ConsultBookScreen());
                            },
                          ),

                        ],
                      );
                    }
                    // TAB - 01
                    else if (controller.selectedConsultantDashboardTab.value == 1) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Upcoming Appointments", fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary1,),
                              GestureDetector(
                                  onTap: () {},
                                  child: CustomText(text: "View All", fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.yellow1,)
                              )
                            ],
                          ),
                          SizedBox(height: 20.h),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: UpcomingAppointmentsCard(
                                  title:index==1 ? "John Robertson" : null,
                                  subTitle: "Visa Consultant - Australia",
                                  img: AppConstants.profileImage2,
                                  isConfirm:index==1? true:false,
                                  onTapViewDetails: (){
                                    Get.toNamed(AppRoutes.consultProfileViewDetails);
                                  },
                                  onTapConfirm: (){
                                    // Get.to(ConsultBookScreen());
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      );
                    }
                    else if (controller.selectedConsultantDashboardTab.value == 2) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Upcoming Appointments", fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary1,),
                              GestureDetector(
                                  onTap: () {},
                                  child: CustomText(text: "View All", fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.yellow1,)
                              )
                            ],
                          ),
                          SizedBox(height: 20.h),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: UpcomingAppointmentsCard(
                                  title:index==1 ? "John Robertson" : null,
                                  subTitle: "Visa Consultant - Australia",
                                  img: AppConstants.profileImage2,
                                  isConfirm:index==1? true:false,
                                  onTapViewDetails: (){
                                    Get.toNamed(AppRoutes.consultProfileViewDetails);
                                  },
                                  onTapConfirm: (){
                                    // Get.to(ConsultBookScreen());
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      );
                    }
                    else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Availability",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary1,
                          ),
                          SizedBox(height: 20.h),

                          // Calendar Box
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                            ),
                            child: Obx(() {
                              final __ = bookingController.availableDays.length;
                               return  TableCalendar(
                                focusedDay: DateTime.now(),
                                firstDay: DateTime.now(),
                                lastDay: DateTime(DateTime.now().year + 1),
                                headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),

                                selectedDayPredicate: (day) =>
                                    bookingController.selectedDates.contains(DateTime(day.year, day.month, day.day)),
                                onDaySelected: bookingController.onDaySelected,

                                calendarBuilders: CalendarBuilders(
                                  defaultBuilder: (context, day, focusedDay) {
                                    DateTime d = DateTime(day.year, day.month, day.day);
                                    if (bookingController.availableDays.any((e) => isSameDay(e, d))) {
                                      return _buildCalendarBox(day, AppColors.green.withOpacity(0.5));
                                    }
                                    if (bookingController.scheduledDays.any((e) => isSameDay(e, d))) {
                                      return _buildCalendarBox(day, Colors.orangeAccent.withOpacity(0.5));
                                    }
                                    return null;
                                  },
                                  selectedBuilder: (context, day, focusedDay) =>
                                      _buildCalendarBox(day, AppColors.primary1, textColor: Colors.white),
                                ),
                              );
                            }
                               ),
                          ),

                          SizedBox(height: 24.h),

                          // বাটন গ্রুপ (স্ক্রিনশট অনুযায়ী)
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onTap: bookingController.addTimeToSelectedDates,
                                  title: "Add Time",
                                  icon: Icon(Icons.add, color: Colors.white),
                                  fillColor: Colors.orange, // Yellowish-Orange color
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: CustomButton(
                                  onTap: bookingController.blockOutSelectedDates,
                                  title: "Block Out",
                                  icon: Icon(Icons.block, color: Colors.white),
                                  fillColor: AppColors.primary1, // Deep Blue
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          // নিচের বড় বাটন
                          CustomButton(
                            onTap: () { /* Set Working Hours logic */ },
                            title: "Set Working Hours",
                            icon: Icon(Icons.access_time, color: Colors.black54),
                            fillColor: Colors.grey[200], // Light grey color
                            textColor: Colors.black87,
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCalendarBox(DateTime day, Color color, {Color textColor = Colors.black}) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        '${day.day}',
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

}