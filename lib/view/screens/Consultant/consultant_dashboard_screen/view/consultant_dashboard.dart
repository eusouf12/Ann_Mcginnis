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
import '../../profile_screen/consult_profile_screen.dart';
import '../../profile_screen/widget/custom_appoinment_card.dart';
import '../../profile_screen/widget/upcoming_appointments_card.dart';
import '../controller/booki_controller_consult.dart';
import '../controller/consult_dashboard_controller.dart';
import '../widget/custom_bar_card.dart';
import '../widget/custom_earning_card.dart';


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
                                    Get.toNamed(AppRoutes.bookingDetailsScreen);
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
                    // tab 02
                    else if (controller.selectedConsultantDashboardTab.value == 2) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Earnings Information",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary1,
                          ),
                          SizedBox(height: 20.h),
                         //Earnings card
                          Row(
                            children: [
                              Expanded(
                                child: CustomSummaryCard(
                                  title: "Total Earnings",
                                  value: "1200",
                                  subtitle: "This month",
                                  backgroundColor: AppColors.primary1,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomSummaryCard(
                                  title: "Total Bookings",
                                  value: "3/5",
                                  subtitle: "This month",
                                  backgroundColor: AppColors.primary1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),

                         // 2. Earnings Trend Section
                          _buildTrendHeader("EARNINGS TREND"),

                          CustomBarChartCard(
                            title: "Earnings",
                            data: {
                              ChartFilter.week: [20, 40, 55, 70, 90, 60, 100],
                              ChartFilter.month: [20, 500, 90, 200], // Week 1,2,3,4
                              ChartFilter.year: [500, 600, 700, 800, 650, 700, 750, 800, 900, 850, 950, 1000], // 12 months
                            },
                          ),


                          SizedBox(height: 24.h),

                          // 3. Bookings Trend Section
                          _buildTrendHeader("BOOKINGS TREND"),
                          _buildChartContainer(
                            title: "Bookings Trend",
                            isBarChart: false, // Line Chart er jonno
                          ),
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
                              // SizedBox(width: 12.w),
                              // Expanded(
                              //   child: CustomButton(
                              //     onTap: bookingController.blockOutSelectedDates,
                              //     title: "Block Out",
                              //     icon: Icon(Icons.block, color: Colors.white),
                              //     fillColor: AppColors.primary1, // Deep Blue
                              //   ),
                              // ),
                            ],
                          ),

                          SizedBox(height: 12.h),

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

Widget _cardItem(String title, String value, String subtitle) {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: const Color(0xFF003057), // Deep Dark Blue
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
        SizedBox(height: 8.h),
        Text(value, style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold)),
        Text(subtitle, style: TextStyle(color: Colors.white54, fontSize: 10.sp)),
      ],
    ),
  );
}
//header btn
Widget _buildTrendHeader(String label) {
  return Column(
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.grey.withOpacity(0.2),),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 16,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary1)),
        ),
      ),
      Icon(Icons.arrow_drop_up, color: const Color(0xFF0A47A1), size: 30.sp),
    ],
  );
}

Widget _buildChartContainer({required String title, required bool isBarChart}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: const Color(0xFF0A47A1), // Royal Blue color from image
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
              child: Row(
                children: [
                  Text("This Week", style: TextStyle(fontSize: 10.sp, color: Colors.black)),
                  Icon(Icons.keyboard_arrow_down, size: 14.sp),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        // Ekhane apni apnar Chart library (fl_chart) add korben
        Container(
          height: 150.h,
          width: double.infinity,
          color: Colors.white10, // Placeholder for chart
          child: Center(child: Text(isBarChart ? "Bar Chart Space" : "Line Chart Space", style: TextStyle(color: Colors.white38))),
        ),
      ],
    ),
  );
}