import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomCountryProgressCar extends StatelessWidget {
  final String? img;
  final String? valueScore;
  final String? title;
  final String? subTitle;

  const CustomCountryProgressCar({
    super.key,
    this.img,
    required this.valueScore,
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border:Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(children: [
            CustomNetworkImage(imageUrl:img?? "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Flag_of_Australia.svg/2560px-Flag_of_Australia.svg.png", height: 20, width: 40),
            SizedBox(width: 20,),
            Column(children: [
              CustomText(
                  text: title ?? "Canada",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary1
              ),
              CustomText(
                  text: subTitle ?? "Top Match",fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black
              ),
            ]),
            Spacer(),
            CustomText(
              text: "${valueScore ?? "85"}%",
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.primary1,
            ),
          ]),
          SizedBox(height: 20,),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: int.parse(valueScore ?? "50")/100,
              minHeight: 12,
              backgroundColor: AppColors.grey_1,
              color: AppColors.primary1,
            ),
          ),
        ],
      ),
    );
  }
}
