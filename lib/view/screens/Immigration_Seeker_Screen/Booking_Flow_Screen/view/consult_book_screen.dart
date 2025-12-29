import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/utils/app_const/app_const.dart';
import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/booking_flow_controller.dart';
import '../widget/custom_time_card.dart';
import 'package:table_calendar/table_calendar.dart';


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
              Divider(thickness: 2,color: Colors.grey.shade200,),
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
                      focusedDay: bookingFlowController.selectedDate.value,
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
                              final formattedDate = DateFormat('MMMM dd, yyyy').format(bookingFlowController.selectedDate.value);
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
                            return CustomTimeCard(
                              onTap: () {

                              },
                              time: index==1 ?'10.50':'2.30',
                              isSelected: index==1 ? true:false,
                            );
                          },
                        ),
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
              Expanded(
                flex: 1,
                child: CustomButton(
                  onTap: (){

                  },
                  title: "Cancel",
                  textColor: Colors.white,
                  fillColor: Color(0xFF6B7280),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 1,
                child: CustomButton(
                  onTap: (){

                  },
                  title: "Book Now",
                  textColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

