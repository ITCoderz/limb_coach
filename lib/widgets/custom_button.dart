import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height,
    this.borderColor,
    this.width,
    this.backgroundColor,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45,
      width: width ?? context.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          side: BorderSide(color: borderColor ?? AppColors.primaryColor),
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: textStyle ??
                    AppTextStyles.getLato(
                      16,
                      FontWeight.w600,
                      Colors.white,
                    ),
              ),
      ),
    );
  }
}
