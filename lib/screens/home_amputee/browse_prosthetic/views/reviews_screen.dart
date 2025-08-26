// lib/screens/shop/views/reviews_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/review_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/write_review_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

import '../../../home_professional/homepage/components/custom_app_bar.dart';

class ReviewsScreen extends StatelessWidget {
  ReviewsScreen({super.key, required this.product});
  final Map<String, dynamic> product;
  final rc = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("All Reviews"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => _Header(avg: rc.avg, count: rc.reviews.length)),
            10.ph,
            Expanded(
              child: Obx(() => ListView.separated(
                    itemCount: rc.reviews.length,
                    separatorBuilder: (_, __) => const Divider(height: 24),
                    itemBuilder: (_, i) {
                      final r = rc.reviews[i];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(r["name"],
                            style: AppTextStyles.getLato(13, 6.weight)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            4.ph,
                            Text("★" * (r["rating"] as double).round()),
                            6.ph,
                            Text(r["text"],
                                style: AppTextStyles.getLato(12, 4.weight)),
                            4.ph,
                            Text(r["date"],
                                style: AppTextStyles.getLato(
                                    11, 4.weight, AppColors.hintColor)),
                          ],
                        ),
                      );
                    },
                  )),
            ),
            10.ph,
            ElevatedButton(
              onPressed: () => Get.to(() => WriteReviewScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0,
                side: BorderSide(color: AppColors.primaryColor, width: .8),
              ),
              child: Text("Write a Review",
                  style: AppTextStyles.getLato(
                      14, 5.weight, AppColors.primaryColor)),
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.avg, required this.count});
  final double avg;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(avg.toStringAsFixed(1),
            style: AppTextStyles.getLato(36, 7.weight)),
        10.pw,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Average", style: AppTextStyles.getLato(12, 4.weight)),
            Text("$count Reviews",
                style:
                    AppTextStyles.getLato(12, 4.weight, AppColors.hintColor)),
          ],
        ),
      ],
    );
  }
}
