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
import '../../../../../service/api_url.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../Immigration_Seeker_Screen/Immigration_Profile_screen/controller/user_profile_controller.dart';
import '../../profile_screen/widget/custom_appoinment_card.dart';
import '../../profile_screen/widget/upcoming_appointments_card.dart';
import '../controller/booki_controller_consult.dart';
import '../controller/consult_dashboard_controller.dart';
import '../widget/custom_bar_card.dart';
import '../widget/custom_earning_card.dart';
import '../widget/custom_line_chart.dart';



class ConsultantDashboard extends StatelessWidget {
  ConsultantDashboard({super.key});
  final ConsultDashboardController controller = Get.put(ConsultDashboardController());
  final BookingController bookingController = Get.put(BookingController());
  final UserProfileController userProfileController = Get.put(UserProfileController(),);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final DateTime now = DateTime.now();
      userProfileController.getUserProfile();
      controller.getBookingSummary();
      controller.getAllAppointments();
      controller.getEarningsTrend();
      controller.getBookingTrend();
      bookingController.getBookedDates(year: now.year, month: now.month);
    });
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              CustomImage(imageSrc: AppImages.logoApp, height: 28.h, width: 28.w,),
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none,
                      color: const Color(0xFF0D1B2A),
                      size: 26.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  // Red Badge
                  // Positioned(
                  //   right: -2,
                  //   top: -2,
                  //   child: Container(
                  //     padding: EdgeInsets.all(3.w),
                  //     decoration: const BoxDecoration(
                  //       color: Colors.red,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     constraints: BoxConstraints(
                  //       minWidth: 16.w,
                  //       minHeight: 16.w,
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         "2",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 10.sp,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            SizedBox(width: 15.w),
            // 4. Profile Image
            Obx(() {
              final user = userProfileController.userData.value;

              String imageUrl = (user?.avatar != null && user!.avatar!.isNotEmpty)? ApiUrl.imageUrl + user.avatar! : AppConstants.profileImage2;

              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.userProfileScreen);
                },
                child: ClipOval(
                  child: CustomNetworkImage(
                    imageUrl: imageUrl,
                    height: 50.h,
                    width: 50.h,
                    boxShape: BoxShape.circle,
                  ),
                ),
              );
            }),
            SizedBox(width: 20.w),
          ],
        ),
          body: Obx(() {
            final user = userProfileController.userData.value;
            return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text: "Welcome, ${user?.fullname}",
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
                          // ========== booking summary =========
                          Obx(() {
                            if (controller.isBookingSummaryLoading.value) {
                              return const Center(child: CustomLoader());
                            }

                            final data = controller.bookingSummary.value;

                            if (data == null) {
                              return const Center(child: Text("No data found"));
                            }

                            return GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.2,
                              children: [
                                CustomAppointmentCard(
                                  icon: Icons.event_available,
                                  value: "${data.totalBookings ?? 0}",
                                  label: 'Total \nAppointments',
                                ),
                                CustomAppointmentCard(
                                  icon: Icons.mail,
                                  value: "${data.totalPaidBookings ?? 0}",
                                  label: 'Total Paid \nAppointments',
                                ),
                                CustomAppointmentCard(
                                  icon: Icons.currency_exchange,
                                  value: "${data.totalEarnings ?? 0}",
                                  label: 'Total Earning',
                                ),
                                CustomAppointmentCard(
                                  icon: Icons.attach_money_outlined,
                                  value: data.currency ?? "USD",
                                  label: 'Currency',
                                ),
                              ],
                            );
                          }),
                          SizedBox(height: 16.h),
                          //======= btn sms and calender ======
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomButton(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.chatListScreen);
                                  },
                                  title: "Messages",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fillColor: AppColors.yellow1,
                                  textColor: AppColors.primary1,
                                  isBorder: true,
                                  borderColor: Colors.grey,
                                  icon: Icon(Icons.message, color: AppColors.primary1, size: 18.sp),
                                ),
                              ),
                              SizedBox(width: 10.h),
                              Expanded(
                                flex: 1,
                                child: CustomButton(
                                  onTap: () async {
                                    controller.changeTab(3);
                                  },
                                  title: "Calendar",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fillColor: AppColors.primary1,
                                  textColor: Colors.white,
                                  isBorder: true,
                                  borderColor: Colors.grey,
                                  icon: Icon(Icons.calendar_month, color: AppColors.white, size: 18.sp), 
                                ),
                              ),
                            ],
                          ),
                         
                          SizedBox(height: 16.h),
                          // appoinment
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Recent Appointments", fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary1,),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Obx(() {
                            if (controller.rxAppointmentStatus.value == Status.loading && controller.appointmentList.isEmpty) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (controller.appointmentList.isEmpty) {
                              return const Center(child: Text("No upcoming appointments found"));
                            }
                            final firstAppointment = controller.appointmentList[0];

                            final user = firstAppointment.userId;

                            return UpcomingAppointmentsCard(
                              title: user?.fullname ?? "Unknown Name",
                              subTitle: user?.country ?? "Unknown Country",
                              date: firstAppointment.consultationDate,
                              time: firstAppointment.consultationTime,
                              status: firstAppointment.bookingStatus,
                              show: firstAppointment.bookingStatus == "completed" || firstAppointment.bookingStatus == "cancelled" ? true : false,
                              img: (firstAppointment.userId?.avatar != null && firstAppointment.userId!.avatar!.isNotEmpty) ? "${ApiUrl.imageUrl}${firstAppointment.userId?.avatar}" : AppConstants.profileImage2,
                              isConfirm: firstAppointment.bookingStatus == "accepted",

                               onTapViewDetails: () {
                                      Get.toNamed( AppRoutes.bookingDetailsScreen, arguments: firstAppointment.id,);
                                    },
                               onTapConfirm: () {
                                      controller.confirmAppointment(appointmentId: firstAppointment.id!);
                                    },
                                    onTapCancel: (){
                                      controller.cancelAppointment(appointmentId: firstAppointment.id!);
                                    },
                            );
                          })

                        ],
                      );
                    }
                    // TAB - 01
                    else if (controller.selectedConsultantDashboardTab.value == 1) {
                      return Obx(() {

                        if (controller.isAppointmentLoading.value && controller.appointmentList.isEmpty) {
                          return const Center(child: CustomLoader());
                        }

                        if (controller.appointmentList.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: CustomText(
                                text: "No appointments found",
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Upcoming Appointments",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary1,
                            ),

                            SizedBox(height: 20.h),

                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.appointmentList.length,
                              itemBuilder: (context, index) {
                                final booking = controller.appointmentList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: UpcomingAppointmentsCard(
                                    title: booking.userId?.fullname ?? "",
                                    subTitle: booking.userId?.country ?? "",
                                    date: booking.consultationDate,
                                    time: booking.consultationTime,
                                    status: booking.bookingStatus,
                                    show: booking.bookingStatus == "completed" || booking.bookingStatus == "cancelled" || booking.bookingStatus == "rejected"? true : false,
                                    isConfirm: booking.bookingStatus == "accepted",
                                    img: (booking.userId?.avatar != null && booking.userId!.avatar!.isNotEmpty) ? "${ApiUrl.imageUrl}${booking.userId?.avatar}" : AppConstants.profileImage2,


                                    onTapViewDetails: () {
                                      Get.toNamed( AppRoutes.bookingDetailsScreen,arguments: booking.id );
                                    },

                                    onTapConfirm: () {
                                      controller.confirmAppointment(appointmentId: booking.id!);
                                    },
                                    onTapCancel: (){
                                      controller.cancelAppointment(appointmentId: booking.id!);
                                    },
                                  ),
                                );
                              },
                            ),

                            ///  LOAD MORE LOADER
                            if (controller.isAppointmentLoadMore.value)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Center(child: CustomLoader()),
                              ),
                          ],
                        );
                      });
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
                          Obx(() {
                            final summary = controller.bookingSummary.value;

                            return Row(
                              children: [
                                Expanded(
                                  child: CustomSummaryCard(
                                    title: "Total Earnings",
                                    value: summary != null ? "${summary.currency} ${summary.totalEarnings?.toInt() ?? 0}" : "0",
                                    subtitle: "This month",
                                    backgroundColor: AppColors.primary1,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: CustomSummaryCard(
                                    title: "Total Bookings",
                                    value: summary != null ? "${summary.totalPaidBookings ?? 0}/${summary.totalBookings ?? 0}" : "0/0",
                                    subtitle: "This month",
                                    backgroundColor: AppColors.primary1,
                                  ),
                                ),
                              ],
                            );
                          }),
                          SizedBox(height: 24.h),

                         // 2. Earnings Trend Section
                          _buildTrendHeader("EARNINGS TREND"),

                          Obx(() {
                            if (controller.isEarningsTrendLoading.value) {
                              return const Center(child: CustomLoader());
                            }
                            List<double> yearData = List.filled(12, 0.0);

                            List<String> monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

                            for (var item in controller.earningsTrendList) {
                              int index = monthNames.indexOf(item.month ?? "");
                              if (index >= 0 && index < 12) {
                                yearData[index] = (item.amount ?? 0).toDouble();
                              }
                            }
                            return CustomBarChartCard(
                              title: "Earnings",
                              data: {
                                ChartFilter.year: yearData,
                              },
                            );
                          }),
                          SizedBox(height: 24.h),

                          // 3. Bookings Trend Section
                          _buildTrendHeader("BOOKINGS TREND"),
                          Obx(() {
                            if (controller.isBookingTrendLoading.value) {
                              return const Center(child: CustomLoader());
                            }

                            List<double> trendData = List.filled(12, 0.0);
                            List<String> months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

                            for (var item in controller.bookingTrendList) {
                              int index = months.indexOf(item.month ?? "");
                              if (index >= 0 && index < 12) {
                                trendData[index] = (item.count ?? 0).toDouble();
                              }
                            }

                            return CustomLineChartCard(
                              title: "Bookings Trend",
                              data: {ChartFilter.year: trendData},
                            );
                          })
                        ],
                      );
                    }
                    //Tab 03
                    else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CustomText(
                              text: "Availability",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 40.h),
                          // Calendar Box
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                            ),
                            child:
                            Obx(() {
                              final _ = bookingController.bookedDatesList.length;

                              return TableCalendar(
                                focusedDay: bookingController.focusedDay.value,
                                firstDay: DateTime.utc(2020, 1, 1),
                                lastDay: DateTime.utc(2030, 12, 31),
                                headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                                selectedDayPredicate: (day) => false,
                                onDaySelected: (selectedDay, focusedDay) {
                                },

                                onPageChanged: (focusedDay) {
                                  bookingController.focusedDay.value = focusedDay;
                                  bookingController.getBookedDates(year: focusedDay.year, month: focusedDay.month);
                                },

                                calendarBuilders: CalendarBuilders(
                                  todayBuilder: (context, day, focusedDay) => null,
                                  defaultBuilder: (context, day, focusedDay) {
                                    DateTime d = DateTime(day.year, day.month, day.day);
                                    final bookedDate = bookingController.bookedDatesList.firstWhereOrNull((e) => isSameDay(DateTime.tryParse(e.date ?? ""), d));

                                    if (bookedDate != null) {
                                      return _buildLargeYellowSquare(day, bookedDate.totalBookings ?? 0);
                                    }
                                    return null;
                                  },
                                ),
                              );
                            })
                          ),
                          SizedBox(height: 24.h),


                        ],
                      );
                    }
                  }),
                ),
              ),
            ),
          ],
        );
          }),
      ),
    );
  }
  Widget _buildLargeYellowSquare(DateTime day, int count) {
    return Container(
      margin: const EdgeInsets.all(1),
      padding:EdgeInsets.only(bottom: 3),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.yellow1,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.orange.withOpacity(0.3), width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(text:'${day.day}',fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppColors.black,),
          CustomText(text: '$count',fontSize: 8.sp, fontWeight: FontWeight.bold, color: AppColors.red,),
          CustomText(text: 'Booking',fontSize: 8.sp, fontWeight: FontWeight.bold, color: AppColors.red),

        ],
      ),
    );
  }
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