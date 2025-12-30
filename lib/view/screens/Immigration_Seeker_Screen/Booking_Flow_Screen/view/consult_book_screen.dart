import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/booking_flow_controller.dart';
import '../widget/custom_consult_payment_card.dart';
import '../widget/custom_time_card.dart';
import 'package:table_calendar/table_calendar.dart';
import 'booking_sucess_screen.dart';


class ConsultBookScreen extends StatelessWidget {
  ConsultBookScreen({super.key});
  final BookingFlowController bookingFlowController = Get.put(BookingFlowController());

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:CustomRoyelAppbar(leftIcon: true,titleName: "Book a Consultation"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Divider(thickness: 2,color: Colors.grey.shade100,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => TableCalendar(
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: TextStyle(color: AppColors.black),
                        todayDecoration: BoxDecoration(
                          color: AppColors.green,
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: TextStyle(color: AppColors.white),
                        selectedDecoration: BoxDecoration(
                          color: AppColors.primary1,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(color: Colors.white),
                      ),
                      locale: "en_US",
                      rowHeight: 43,
                      headerStyle: HeaderStyle(
                        titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.w,
                        ),
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        rightChevronIcon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ),
                      availableGestures: AvailableGestures.all,
                      selectedDayPredicate: (day) =>
                          isSameDay(bookingFlowController.selectedDate.value, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        bookingFlowController.changeDate(selectedDay);
                      },
                      focusedDay: bookingFlowController.selectedDate.value ?? DateTime.now(),
                      firstDay: DateTime.now(),
                      lastDay: DateTime(DateTime.now().year + 5),
                    )),
                    SizedBox(height: 15.h),
                    Divider(thickness: 1,color: Colors.grey.shade200,),
                    SizedBox(height: 15.h),
                    //AvailabilitySection
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Change date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Availability Time -",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              right: 10,
                            ),

                             Obx(() {
                               final formattedDate = DateFormat('MMMM dd, yyyy').format(bookingFlowController.selectedDate.value ?? DateTime.now(),);

                               return Center(
                                child: CustomText(
                                  text: formattedDate,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  bottom: 15,
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        // Time Slots
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 3,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            String time = index == 0 ? '9:00 AM' : index == 1 ? '10:30 AM' : index == 2 ? '12:00 PM' : '2:30 PM';
                            bool isAvailable = index== 1?false: true;
                            print("isAvailable===== ${isAvailable}");
                            return Obx(() {
                              final isSelected = bookingFlowController.selectedTimes.contains(time);
                              return CustomTimeCard(
                                time: time,
                                isAvailable: isAvailable,
                                isSelected: isAvailable && isSelected,
                                onTap: () {
                                  if (isAvailable) {
                                    bookingFlowController.toggleTime(time);
                                  }
                                },
                              );
                            });

                          },
                        ),
                        SizedBox(height: 20.h),
                        // video or audio card
                        CustomText(text: "Consultation Type" , fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black, ),
                        SizedBox(height: 10.h),
                        Obx(() => Column(
                          children: [
                            ConsultationTypeCard(
                              title: "Video Call",
                              subTitle: "45 minutes session",
                              price: "\$89",
                              isSelected: bookingFlowController.selectedConsultationType.value == "Video Call",
                              onTap: () {
                                bookingFlowController.selectConsultation("Video Call", "\$89");
                              },
                            ),

                            SizedBox(height: 12.h),

                            ConsultationTypeCard(
                              title: "Phone Call",
                              subTitle: "45 minutes session",
                              price: "\$69",
                              isSelected: bookingFlowController.selectedConsultationType.value == "Phone Call",
                              onTap: () {
                                bookingFlowController.selectConsultation("Phone Call", "\$69");
                              },
                            ),
                          ],
                        ),)
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              //cancel
              Expanded(
                child: CustomButton(
                  onTap: () {
                    bookingFlowController.clearSelection();
                  },
                  title: "Cancel",
                  textColor: Colors.white,
                  fillColor: Color(0xFF6B7280),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    final date = bookingFlowController.formattedSelectedDate;
                    final times = bookingFlowController.selectedTimes;
                    final double rating = 4.9;
                    final int totalReviews = 127;
                    if ( times.isNotEmpty) {
                      debugPrint("Booking Date: $date");
                      debugPrint("Booking Times: $times");
                       Get.to(() => BookingConfirmedScreen(),
                           arguments: {
                              'name':"Dr Sarah",
                              'title':"Clinical Psychologist",
                             'id':"12345678",
                             "rating": rating, //'rating': rating.toString(),
                             "reviews":totalReviews,
                             'date': date,
                             'times': times
                          }
                       );
                    } else {
                      Get.snackbar("Error", "Please select date and time");
                    }
                  },
                  title: "Book Now",
                  textColor: AppColors.white,
                ),
              ),
            ],
          )

        ),
      ),
    );
  }
}

