import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text/custom_text.dart';
import 'controller/notification_controller.dart';
class NotificationScreen extends StatelessWidget {
   NotificationScreen({super.key});
  final NotificationController notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Notification'.tr,
          color: AppColors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary1,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        CustomText(
                          text: 'General Notification'.tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        Spacer(),
                        Obx(() => Switch(
                          activeColor: Colors.white,
                          activeTrackColor: Color(0xFFFFCC00),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Color(0xFF4B5563),
                          trackOutlineColor: MaterialStateProperty.resolveWith<Color>((states) {
                            return Colors.white;
                          }),
                          value: notificationController.generalNotification.value,
                          onChanged: (value) {
                            notificationController.toggleGeneral(value);
                          },
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 15),
              //   child: Container(
              //     height: 60,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: AppColors.primary1,
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Row(
              //         children: [
              //           CustomText(
              //             text: "Sound",
              //             fontSize: 14,
              //             fontWeight: FontWeight.w500,
              //           ),
              //           Spacer(),
              //           Obx(() => Switch(
              //             activeColor: Colors.white,
              //             activeTrackColor: Color(0xFFFFCC00),
              //             inactiveThumbColor: Colors.white,
              //             inactiveTrackColor: Color(0xFF4B5563),
              //             trackOutlineColor: MaterialStateProperty.resolveWith<Color>((states) {
              //               return Colors.white;
              //             }),
              //             value: notificationController.soundNotification.value,
              //             onChanged: (value) {
              //               notificationController.toggleSound(value);
              //             },
              //           )),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 15),
              //   child: Container(
              //     height: 60,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: AppColors.primary1,
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Row(
              //         children: [
              //           CustomText(
              //             text: "Vibrate",
              //             fontSize: 14,
              //             fontWeight: FontWeight.w500,
              //           ),
              //           Spacer(),
              //           Obx(() => Switch(
              //             activeColor: Colors.white,
              //             activeTrackColor: Color(0xFFFFCC00),
              //             inactiveThumbColor: Colors.white,
              //             inactiveTrackColor: Color(0xFF4B5563),
              //             trackOutlineColor: MaterialStateProperty.resolveWith<Color>((states) {
              //               return Colors.white;
              //             }),
              //             value: notificationController.vibrateNotification.value,
              //             onChanged: (value) {
              //               notificationController.toggleVibrate(value);
              //             },
              //           )),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
        ]
          ),
        ),
      ),
    );
  }
}
