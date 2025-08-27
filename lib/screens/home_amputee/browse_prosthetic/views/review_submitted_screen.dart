// lib/screens/shop/views/write_review_submitted_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/homepage/views/home_page.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class WriteReviewSubmittedScreen extends StatelessWidget {
  const WriteReviewSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Review Submitted"),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            CustomButton(
                text: "Go Back to Home",
                onPressed: () {
                  Get.offAll(() => AmputeeDashboardScreen());
                }),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 69,
              width: 69,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.05),
                  shape: BoxShape.circle),
              child: Image.asset(
                Assets.pngIconsTickMark,
              )),
          10.ph,
          Text(
            "Review Submitted",
            style: AppTextStyles.getLato(24, 7.weight),
          ),
          5.ph,
          Center(
            child: Text(
                "Thanks for your valuable feedback. Your\nreview was submitted successfully.",
                textAlign: TextAlign.center,
                style: AppTextStyles.getLato(16, 5.weight)),
          ),
        ],
      ),
    );
  }
}
