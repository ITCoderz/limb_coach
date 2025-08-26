// lib/screens/shop/views/write_review_submitted_screen.dart
import 'package:flutter/material.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class WriteReviewSubmittedScreen extends StatelessWidget {
  const WriteReviewSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Review Submitted"),
      body: Center(
        child: Text(
            "Thanks for your valuable feedback.\nYour review was submitted successfully.",
            textAlign: TextAlign.center,
            style: AppTextStyles.getLato(16, 5.weight)),
      ),
    );
  }
}
