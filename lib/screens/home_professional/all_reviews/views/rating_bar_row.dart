import 'package:flutter/material.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class RatingBarRow extends StatelessWidget {
  final String title;
  final Color color;
  final double fillPercent; // 0.0 → 1.0
  final EdgeInsets margin;

  const RatingBarRow({
    super.key,
    required this.title,
    required this.color,
    required this.fillPercent,
    this.margin = const EdgeInsets.symmetric(vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              title,
              style: AppTextStyles.getLato(14, FontWeight.w400),
            ),
          ),
          10.pw,
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: fillPercent.clamp(0.0, 1.0),
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
