
import 'package:ann_mcginnis/utils/app_images/app_images.dart';
import 'package:ann_mcginnis/view/components/custom_gradient/custom_gradient.dart';
import 'package:ann_mcginnis/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';

class ConsultantDashboard extends StatelessWidget {
  const ConsultantDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
        child: Scaffold(
          appBar: CustomRoyelAppbar(rightIcon: AppImages.logo1,titleName: "ConsultantDashboard",),
        )
    );
  }
}
