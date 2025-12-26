import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text/custom_text.dart';
import 'controller/security_controller.dart';

class SecurityScreen extends StatelessWidget {
  SecurityScreen({super.key});
  final securityController = Get.put(SecurityController());


  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Security',
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
                            text: 'Two-Factor Authentication',
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
                            value: securityController.twoFactorAuth.value,
                            onChanged: securityController.toggleTwoFactor,
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                //save locally
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
                //             text: "Save Locally",
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
                //             value: securityController.saveLocally.value,
                //             onChanged: securityController.toggleSaveLocally,
                //           )),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // //Biometric Unlock
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
                //             text: "Biometric Unlock",
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
                //             value: securityController.biometricUnlock.value,
                //             onChanged: securityController.toggleBiometric,
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
                //             text: "Pin",
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
                //             value: securityController.pinEnabled.value,
                //             onChanged: securityController.togglePin,
                //           )),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 50,),
                CustomButton(
                  onTap: (){
                    securityController.clearAllSwitches();
                  },
                  title: 'Clear All Documents',
                  textColor: AppColors.red,
                  borderRadius: 12,
                  fillColor: AppColors.primary1,
                  fontSize: 14,
                ),
              ]
          ),
        ),
      ),
    );
  }
}
