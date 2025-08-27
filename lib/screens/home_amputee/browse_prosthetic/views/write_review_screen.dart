// lib/screens/shop/views/write_review_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/auth/components/uplaod_box.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/review_submitted_screen.dart';
import 'package:mylimbcoach/screens/home_professional/all_reviews/controllers/review_controllers.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

import '../../../home_professional/homepage/components/custom_app_bar.dart';

class WriteReviewScreen extends StatelessWidget {
  WriteReviewScreen({super.key});
  final rc = Get.find<ReviewsController>();
  final rating = 0.0.obs;
  final textCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Write Review"),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            CustomButton(
              text: "Submit Review",
              onPressed: () {
                rc.addReview(rating.value, textCtrl.text);
                Get.off(() => const WriteReviewSubmittedScreen());
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Ratings:",
                style: AppTextStyles.getLato(16, 6.weight),
              ),
              10.ph,
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(5, (i) {
                      final filled = i < rating.value;
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () => rating.value = (i + 1).toDouble(),
                          child: Image.asset(
                            color: filled
                                ? Color(0xffFEBD17)
                                : Colors.amber.withOpacity(0.3),
                            height: 35,
                            width: 35,
                            Assets.pngIconsBigStar,
                          ),
                        ),
                      );
                    }),
                  )),
              20.ph,
              Text(
                "Add Photo:",
                style: AppTextStyles.getLato(16, 6.weight),
              ),
              10.ph,
              UploadBoxSlim(
                title: "Drag & drop your image here, or click to browse",
                onTap: rc.pickAndUploadImage,
                progress: rc.progress,
                fileName: rc.fileName, // no !
              ),
              20.ph,
              Text(
                "Write Your Review:",
                style: AppTextStyles.getLato(16, 6.weight),
              ),
              10.ph,
              CustomTextField(
                label: "",
                maxLines: 6,
                controller: textCtrl,
                hintText: 'Type here',
              ),
              10.ph,
            ],
          ),
        ),
      ),
    );
  }
}
