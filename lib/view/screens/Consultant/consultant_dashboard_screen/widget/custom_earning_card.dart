import 'package:flutter/material.dart';

import '../../../../components/custom_text/custom_text.dart';

class CustomSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData? icon;
  final Color backgroundColor;
  final Gradient? gradient;

  const CustomSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    this.icon,
    this.backgroundColor = const Color(0xFF003057),
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: gradient == null ? backgroundColor : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (icon != null)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
          if (icon != null) const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
              const SizedBox(height: 6),
              CustomText(
                text: value,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: subtitle,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.white54,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
