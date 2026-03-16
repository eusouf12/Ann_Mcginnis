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
                    experience: "10",
                  ),
                  SizedBox(height: 20.h),
                  //Consultation Fees
                  CustomText(
                    text: "Consultation Fees",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    bottom: 15,
                    textAlign: TextAlign.start,
                  ),
                  Column(
                    children: List.generate(
                      consultant.consultationFormats?.length ?? 0,
                          (index) {

                        final format = consultant.consultationFormats![index];

                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: CustomConsultationCard(
                            title: format,
                            subTitle: "30",
                            price: "${consultant.consultationFees ?? 0}",
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20.h),

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
                        final formattedDate = DateFormat('MMMM dd, yyyy').format(date);

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

                      /// TIME SLOTS
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 3,
                        ),
                        itemCount:
                        consultant.availability?.preferredTimeSlots?.length ?? 0,

                        itemBuilder: (context, index) {

                          final slot =
                          consultant.availability!.preferredTimeSlots![index];

                          return CustomTimeCard(
                            onTap: () {},
                            time: slot,
                            isSelected: false,
                            isAvailable: true,
                          );
                        },
                      ),
                    ],
                  ),
                 // available or not
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.green,
                            width: 1,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      CustomText(
                        text: "Available",
                        fontSize: 12,
                        color: Colors.black,
                      ),

                      SizedBox(width: 20.w),

                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      CustomText(
                        text: "Unavailable",
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// ABOUT
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

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomButton(
            onTap: (){
                 Get.to(ConsultBookScreen());
            },
            title: "Book Now",
            textColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}

