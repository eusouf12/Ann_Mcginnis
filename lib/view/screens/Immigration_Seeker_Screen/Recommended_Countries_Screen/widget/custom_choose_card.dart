import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomChooseCard extends StatelessWidget {
  final IconData? icon;
  final String? value;
  final String? title;

  const CustomChooseCard({
    super.key,
     this.icon,
     this.value,
     this.title,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon ?? Icons.check, color: Colors.orange, size: 18.sp),
        SizedBox(width: 10,),
        Expanded(child: CustomText(text: title ?? "",maxLines: 3,textAlign: TextAlign.start, overflow: TextOverflow.visible,fontSize: 14, color: Colors.grey,)),
      ],
    );
  }
}
