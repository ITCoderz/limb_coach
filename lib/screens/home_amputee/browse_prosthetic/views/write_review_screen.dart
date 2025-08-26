// lib/screens/shop/views/write_review_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/review_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/review_submitted_screen.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

import '../../../home_professional/homepage/components/custom_app_bar.dart';

class WriteReviewScreen extends StatelessWidget {
  WriteReviewScreen({super.key});
  final rc = Get.find<ReviewController>();
  final rating = 0.0.obs;
  final textCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Write Review"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) {
                    final filled = i < rating.value;
                    return IconButton(
                      icon: Icon(filled ? Icons.star : Icons.star_border),
                      onPressed: () => rating.value = (i + 1).toDouble(),
                    );
                  }),
                )),
            10.ph,
            CustomTextField(
              label: "Your Review",
              maxLines: 6,
              controller: textCtrl,
              hintText: '',
            ),
            const Spacer(),
            CustomButton(
              text: "Submit Review",
              onPressed: () {
                rc.addReview(rating.value, textCtrl.text);
                Get.off(() => const WriteReviewSubmittedScreen());
              },
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}
