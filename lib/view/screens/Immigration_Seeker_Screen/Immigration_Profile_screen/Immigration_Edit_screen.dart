import 'package:ann_mcginnis/view/screens/Immigration_Seeker_Screen/Immigration_Profile_screen/controller/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../service/api_url.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../Consultant/profile_screen/consult_profile_setup_screen.dart'
    hide AppColors;

class UserEditScreen extends StatelessWidget {
  UserEditScreen({super.key});
  final UserProfileController profileController = Get.put(
    UserProfileController(),
  );

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Edit Profile',
          color: AppColors.black,
        ),
        body: Obx(() {
          if (profileController.rxUserStatus.value == Status.loading) {
            return Center(child: CustomLoader());
          }

          if (profileController.userData.value == null) {
            return Center(
              child: CustomText(text: "Profile not found", fontSize: 16),
            );
          }
          final userData = profileController.userData.value!;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: ClipOval(
                              child:
                                  profileController.selectedImage.value != null
                                  ? Image.file(
                                      profileController.selectedImage.value!,
                                      height: 70.h,
                                      width: 70.w,
                                      fit: BoxFit.cover,
                                    )
                                  : CustomNetworkImage(
                                      imageUrl: userData.avatar!.isNotEmpty
                                          ? ApiUrl.imageUrl + userData.avatar!
                                          : AppConstants.profileImage,
                                      height: 70.h,
                                      width: 70.w,
                                      boxShape: BoxShape.circle,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 120.w,
                        bottom: 10.w,
                        child: GestureDetector(
                          onTap: () {
                            profileController.pickImageFromGallery();
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 15,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Name
                  Obx(
                    () => CustomFormCard(
                      title: 'Name',
                      fontSize: 16,
                      hintText: 'Enter Your Name',
                      controller: profileController.nameController.value,
                    ),
                  ),
                  // Email
                  Obx(
                    () => CustomFormCard(
                      title: 'Email',
                      hintText: 'Enter Your Email',
                      controller: profileController.emailController.value,
                      readOnly: true,
                    ),
                  ),
                  // Date of Birth
                  Obx(
                    () => CustomFormCard(
                      title: 'Date Of Birth',
                      hintText: 'MM-DD-YYYY',
                      controller: profileController.dateOfBirthController.value,
                    ),
                  ),
                  //gender
                  // Obx(
                  //   () => CustomFormCard(
                  //     title: 'Gender',
                  //     hintText: 'Male/Female',
                  //     controller: profileController.genderController.value,
                  //   ),
                  // ),
                  //country
                  Obx(
                    () => CustomFormCard(
                      title: 'Country',
                      hintText: 'United State',
                      controller: profileController.countryController.value,
                    ),
                  ),
                  //phone
                  Obx(
                    () => CustomFormCard(
                      title: 'Phone Number',
                      hintText: 'Enter Your Phone Number',
                      controller: profileController.phoneNumberController.value,
                    ),
                  ),

                  // ==== Save btn ========
                  SizedBox(height: 20),
                  Obx(() {
                    if (profileController.updateProfileLoading.value) {
                      return CustomLoader();
                    }
                    return CustomButton(
                      onTap: () {
                        profileController.updateProfile();
                      },
                      title: 'Save',
                      textColor: AppColors.white,
                      borderRadius: 50,
                      fillColor: AppColors.primary,
                    );
                  }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
