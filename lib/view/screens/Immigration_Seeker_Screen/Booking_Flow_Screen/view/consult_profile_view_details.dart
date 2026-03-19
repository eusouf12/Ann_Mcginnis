import 'package:ann_mcginnis/utils/app_colors/app_colors.dart';
import 'package:ann_mcginnis/utils/app_const/app_const.dart';
import 'package:ann_mcginnis/view/components/custom_button/custom_button.dart';
import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:ann_mcginnis/view/screens/Immigration_Seeker_Screen/Booking_Flow_Screen/view/booking_sucess_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../service/api_url.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/booking_flow_controller.dart';
import '../widget/custom_detais_profile_card.dart';
import '../widget/custom_fees_card.dart';
import '../widget/custom_time_card.dart';
import 'consult_book_screen.dart';

class ConsultProfileViewDetails extends StatelessWidget {
  ConsultProfileViewDetails({super.key});
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
        appBar:CustomRoyelAppbar(leftIcon: true,titleName: "Consultant Profile"),
        body: Obx(() {

          if (bookingFlowController.isSingleConsultantLoading.value) {
            return const Center(child: CustomLoader());
          }

          final consultant = bookingFlowController.singleConsultant.value;

          if (consultant == null) {
            return const Center(child: Text("No consultant data found"));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Now Static
                  CustomDetailsProfileCard(
                    imageUrl: consultant.userId?.avatar?.isNotEmpty == true ? "${ApiUrl.imageUrl}${consultant.userId?.avatar}" : AppConstants.profileImage,
                    name: consultant.userId?.fullname ?? "",
                    title: consultant.jobTitle ?? "",
                    rating: 4.9,
                    totalReviews: "127",
                    experience: consultant.experienceYears.toString(),
                  ),
                  SizedBox(height: 20.h),
                  //======================== Consultation Fees ========================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Consultation Fees",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        bottom: 15,
                        textAlign: TextAlign.start,
                      ),
                      CustomText(
                        text: "Discount (${consultant.discountRates}%)",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary1,
                        bottom: 15,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Column(
                    children: List.generate(
                      consultant.consultationFormats?.length ?? 0, (index) {
                        final format = consultant.consultationFormats![index];
                        int price = 0;

                        if (format.toLowerCase().contains("video")) {
                          price = consultant.consultationFees?.videoCall ?? 0;
                        } else if (format.toLowerCase().contains("phone")) {
                          price = consultant.consultationFees?.phoneCall ?? 0;
                        } else {
                          price = consultant.consultationFees?.inPerson ?? 0;
                        }

                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: CustomConsultationCard(
                            title: format,
                            currency: consultant.currency,
                            price: "${price}",
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  //======================== Availability ========================
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    // selected date and change date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Availability",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),

                          TextButton.icon(
                            onPressed: () async {

                              DateTime now = DateTime.now();

                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: bookingFlowController.selectedDate.value,
                                firstDate: now,
                                lastDate: DateTime(now.year + 5),
                              );

                              if (pickedDate != null) {
                                bookingFlowController.changeDate(pickedDate);
                              }
                            },
                            icon: const Icon(
                              Icons.calendar_month,
                              size: 18,
                              color: AppColors.primary1,
                            ),
                            label: const CustomText(
                              text: "Change Date",
                              color: AppColors.primary1,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      // Today DATE or Selected Date
                      Obx(() {
                        final date = bookingFlowController.selectedDate.value ?? DateTime.now();
                        final formattedDate = DateFormat('EEEE, MMMM dd, yyyy').format(date);

                        return Center(
                          child: CustomText(
                            text: formattedDate,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            bottom: 15,
                          ),
                        );
                      }),
                      SizedBox(height: 10.h),

                      ///============ TIME SLOTS
                      Obx(() {
                        final bool isAvailable = bookingFlowController.isAvailableOnSelectedDay(
                            consultant.availability?.recurringDays
                        );

                        if (!isAvailable) {
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
                                  text: "Not available on ${DateFormat('EEEE').format(bookingFlowController.selectedDate.value!)}",
                                  color: Colors.red.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          );
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
                          itemCount: consultant.availability?.preferredTimeSlots?.length ?? 0,
                          itemBuilder: (context, index) {
                            final slot = consultant.availability!.preferredTimeSlots![index];

                            return Obx(() {
                              final isSelected = bookingFlowController.selectedTimes.contains(slot);
                              return CustomTimeCard(
                                onTap: () => bookingFlowController.toggleTime(slot),
                                time: slot,
                                isSelected: isSelected,
                                isAvailable: true,
                              );
                            });
                          },
                        );
                      })
                    ],
                  ),
                  SizedBox(height: 20.h),

                  //================== ABOUT ===================
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const CustomText(
                        text: "About",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        bottom: 10,
                      ),

                      CustomText(
                        textAlign: TextAlign.start,
                        text: consultant.profileDescription ?? "",
                        fontSize: 13,
                        color: Colors.black54,
                        maxLines: 6,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        }),

        bottomNavigationBar: Obx(() {
          final consultant = bookingFlowController.singleConsultant.value;
          if (bookingFlowController.isSingleConsultantLoading.value || consultant == null) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.consultBookScreen, arguments: consultant.id,);
              },
              title: "Book Now",
              textColor: AppColors.white,
            ),
          );
        }),
      ),
    );
  }
}

