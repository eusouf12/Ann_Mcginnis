import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/general_error.dart';
import '../controller/user_profile_controller.dart';

class ImmigrationTermsServicesScreen extends StatelessWidget {
  ImmigrationTermsServicesScreen({super.key});
  final UserProfileController profileController = Get.put(UserProfileController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.getTermsConditions();
    });
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: 'Terms Of Services',),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {

            switch (profileController.rxStatus.value) {

              case Status.loading:
                return const Center(child: CustomLoader());

              case Status.internetError:
                return const Center(
                  child: Text("No Internet Connection"),
                );

              case Status.error:
                return Center(
                  child: GeneralErrorScreen(
                    onTap: () {
                      profileController.getTermsConditions();
                    },
                  ),
                );

              case Status.completed:

                final htmlContent =
                    profileController.termsModel.value?.content ?? "";

                return SingleChildScrollView(
                  child: HtmlWidget(
                    htmlContent.isNotEmpty
                        ? htmlContent
                        : "<p>Terms & Conditions not available</p>",
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
            }
          }),
        ),
      ),
    );
  }
}