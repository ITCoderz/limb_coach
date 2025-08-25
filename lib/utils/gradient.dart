import 'package:flutter/material.dart';
import 'package:mylimbcoach/utils/app_colors.dart';

LinearGradient buildLinearGradient({
  bool leftToRight = false,
  List<Color>? colorList,
}) {
  colorList ??= [AppColors.primaryColor2, AppColors.primaryColor3];

  return LinearGradient(
    colors: colorList,
    begin: leftToRight ? Alignment.centerLeft : Alignment.topLeft,
    end: leftToRight ? Alignment.centerRight : Alignment.bottomRight,
  );
}

class GradientContainer extends StatelessWidget {
  const GradientContainer(
      {super.key, this.topToBottom = true, this.height = 162});
  final bool topToBottom;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: topToBottom
              ? [
                  AppColors.primaryColor.withOpacity(0.2),
                  AppColors.primaryColor.withOpacity(0.0),
                ]
              : [
                  AppColors.primaryColor.withOpacity(0.0),
                  AppColors.primaryColor.withOpacity(0.2),
                ],
        ),
      ),
    );
  }
}
