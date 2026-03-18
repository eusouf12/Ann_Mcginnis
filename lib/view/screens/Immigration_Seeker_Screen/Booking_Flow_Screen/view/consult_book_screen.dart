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
  final String consultantId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingFlowController.getSingleConsultant(id: consultantId);
    });
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
                        // --- Availability Header with Date & Day ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Availability-",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              right: 10,
                            ),
                            Obx(() {
                              final date = bookingFlowController.selectedDate.value ?? DateTime.now();
                              final formattedDate = DateFormat('EEEE, MMMM dd, yyyy').format(date);

                              return CustomText(
                                text: formattedDate,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                bottom: 15,
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        // --- Time Slots Logic ---
                        Obx(() {
                          final consultant = bookingFlowController.singleConsultant.value;
                          final bool isDayAvailable = bookingFlowController.isAvailableOnSelectedDay(
                            consultant?.availability?.recurringDays,
                          );

                          if (!isDayAvailable) {
                            return Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 30.h),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.event_busy, color: Colors.red.shade400, size: 30),
                                  SizedBox(height: 8.h),
                                  CustomText(
                                    text: "Not available on this day",
                                    color: Colors.red.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            );
                          }
                          final List<String> slots = consultant?.availability?.preferredTimeSlots ?? [];

                          if (slots.isEmpty) {
                            return const Center(child: Text("No time slots available"));
                          }

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 3,
                            ),
                            itemCount: slots.length,
                            itemBuilder: (context, index) {
                              final time = slots[index];

                              return Obx(() {
                                final isSelected = bookingFlowController.selectedTimes.contains(time);
                                // এখানে আপনি চাইলে আপনার নিজস্ব logic (যেমন: Is already booked) দিয়ে isAvailable সেট করতে পারেন
                                bool isAvailable = true;

                                return CustomTimeCard(
                                  time: time,
                                  isAvailable: isAvailable,
                                  isSelected: isSelected,
                                  onTap: () {
                                    if (isAvailable) {
                                      bookingFlowController.toggleTime(time);
                                    }
                                  },
                                );
                              });
                            },
                          );
                        }),
                      ],
                    ),
                    //================ consultant type===============
                    SizedBox(height: 20.h),
                    // video or audio card
                    CustomText(text: "Consultation Type" , fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black, ),
                    SizedBox(height: 10.h),
                    Obx(() {
                      final consultant = bookingFlowController.singleConsultant.value;
                      if (consultant?.id == null) return const SizedBox();
                      final formats = consultant?.consultationFormats ?? [];
                      final fees = consultant?.consultationFees;

                      return Column(
                        children: formats.map((format) {
                          String title = "";
                          String price = "0";
                          String subTitle = "45 minutes session";
                          if (format == "Video Consultation") {
                            title = "Video Call";
                            price = "\$${fees?.videoCall ?? 0}";
                          } else if (format == "Phone Call") {
                            title = "Phone Call";
                            price = "\$${fees?.phoneCall ?? 0}";
                          } else if (format == "In-Person") {
                            title = "In-Person";
                            price = "\$${fees?.inPerson ?? 0}";
                          }

                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: ConsultationTypeCard(
                              title: title,
                              price: price,
                              isSelected: bookingFlowController.selectedConsultationType.value == title,
                              onTap: () {
                                bookingFlowController.selectConsultation(title, price);
                              },
                            ),
                          );
                        }).toList(),
                      );
                    }),
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

