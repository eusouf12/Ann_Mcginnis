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
import '../widget/custom_detais_profile_card.dart';
import '../widget/custom_fees_card.dart';
import '../widget/custom_time_card.dart';
import 'consult_book_screen.dart';

class ConsultProfileViewDetails extends StatelessWidget {
  ConsultProfileViewDetails({super.key});
  final BookingFlowController bookingFlowController = Get.put(BookingFlowController());

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:CustomRoyelAppbar(leftIcon: true,titleName: "Consultant Profile"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //profile section
                CustomDetailsProfileCard(
                  imageUrl: AppConstants.profileImage2,
                  name: "Dr. Sarah Johnson",
                  title: "Clinical Psychologist",
                  rating: 4.9,
                  totalReviews: "127",
                  experience: "10",
                  patients: "500",
                ),
                SizedBox(height: 20.h),
                // Fees section
                CustomText(text: "Consultation Fees", fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black, bottom: 15,textAlign: TextAlign.start,),
                CustomConsultationCard(
                  title: "Audio Consultation",
                  subTitle: "30",
                  price: "45",
                ),
                SizedBox(height: 20.h),
                //AvailabilitySection
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Change date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         CustomText(
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
                              lastDate: DateTime(now.year + 5, now.month, now.day),
                            );
      
                            if (pickedDate != null) {
                              bookingFlowController.changeDate(pickedDate);
                            }
                          },
                          icon: const Icon(Icons.calendar_month, size: 18,color: AppColors.primary1,),
                          label: CustomText(text: "Change Date",color: AppColors.primary1,fontSize: 16,)
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    //Show Date
                    Obx(() {
                      final formattedDate = DateFormat('MMMM dd, yyyy').format(bookingFlowController.selectedDate.value);
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
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.green,
                                width: 1,
                              ),
                            ),
                            child: Icon(Icons.rectangle,color: Color(0xFFDCFCE7),size: 18,)
                        ),
                        SizedBox(width: 10.h),
                        CustomText(text: "Available",color: Colors.black),
                        SizedBox(width: 20.h),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Icon(Icons.rectangle,color: Colors.white,size: 18,)
                        ),
                        SizedBox(width: 10.h),
                        CustomText(text: "Unavailable",color: Colors.black)
                      ],
                    )
      
                  ],
                ),
                SizedBox(height: 20.h),
                //about
                Column(
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
                CustomText(text: "Specializations", fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,top: 20, bottom: 20,textAlign: TextAlign.start,),
                Wrap(
                  spacing: 12.w, 
                  runSpacing: 12.h,
                  children: List.generate(5, (index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Color(0xFFD1E4FF),
                        borderRadius: BorderRadius.circular(30.r), 
                      ),
                      child: CustomText(text:index==1? "Anxiety": index==3? "CBT" : "Relationships",color:AppColors.primary1, )

                    );
                  }),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
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

