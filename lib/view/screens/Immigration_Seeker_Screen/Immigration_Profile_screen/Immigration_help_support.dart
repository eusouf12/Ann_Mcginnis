import 'package:flutter/material.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text/custom_text.dart';
import 'controller/user_profile_controller.dart';
import 'package:get/get.dart';

class ImmigrationHelpSupport extends StatelessWidget {
  ImmigrationHelpSupport({super.key});
  final UserProfileController supportController = Get.put(UserProfileController());
  final args = Get.arguments;
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final name = args['name'];
    final email = args['email'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      supportController.getUserProfile();
    });
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Help & Support',
          color: AppColors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //img
                Center(
                  child: Column(
                    children: [
                      CustomImage(imageSrc: AppImages.help),
                      SizedBox(height: 20),
                      CustomText(
                        text: "Hello, how can we assist you?",
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomFormCard(
                  title: 'Title',
                  hintText: 'Enter the title of your issue',
                  titleColor: AppColors.black,
                  fillBorderRadius: 12,
                  curserColor: AppColors.black,
                  controller: subjectController,
                ),
                CustomFormCard(
                  title: 'Write in bellow box',
                  hintText: 'Write here.....',
                  maxLine: 5,
                  fillBorderRadius: 12,
                  curserColor: AppColors.black,
                  controller: messageController,
                ),
                SizedBox(height: 40),

                Obx(() {
                  return supportController.isContactLoading.value ?
                  CustomLoader()
                  : CustomButton(
                    onTap: () {
                      supportController.sendContactMessage(
                        name: name,
                        email: email,
                        subject: subjectController.text,
                        message: messageController.text,
                      );
                    },
                    borderRadius: 12,
                    textColor: AppColors.white,
                    title: "Send",
                    fillColor: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
