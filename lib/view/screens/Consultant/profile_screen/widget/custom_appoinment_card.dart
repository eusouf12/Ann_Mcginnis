import 'package:ann_mcginnis/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class CustomAppointmentCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const CustomAppointmentCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon ,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The Icon Circle
          Container(
            padding: const EdgeInsets.all(8),

            child: Icon(icon, color: AppColors.primary1, size: 32,),
          ),
          SizedBox(height: 10),

          // The Number Text
          CustomText(text: value, fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary1),
          SizedBox(height: 10),
          // The Label Text
          CustomText(text: label,  fontWeight: FontWeight.w500, color: Colors.grey,fontSize: 14),
        ],
      ),
    );
  }
}