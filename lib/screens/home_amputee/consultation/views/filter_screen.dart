// filter_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

import '../../../../generated/assets.dart';
import '../controllers/consultation_controller.dart';

class ConsultationFiltersScreen extends StatelessWidget {
  ConsultationFiltersScreen({super.key});

  // ✅ grab the SAME instance
  final AmputeeConsultationController c =
      Get.find<AmputeeConsultationController>();

  final categories = const [
    "All Categories",
    "Prosthetists",
    "Orthotists",
    "Occupational Therapist",
    "Physical Therapists / Physiotherapists",
    "Rehabilitation Physicians / Physiatrists",
    "Surgeons (Orthopedic / Vascular)",
    "Pain Management Specialists",
    "Psychologists / Counselors (specializing in amputation adjustment)",
    "Nurses (specialized in wound care and post-amputation care)",
    "Social Workers (disability support)",
    "Mobility Specialists / Assistive Technology Experts",
    "Certified Amputee Peer Counselors",
    "Sports Therapists / Exercise Physiologists (for amputee fitness)",
    "Vocational Rehabilitation Specialists",
  ];

  final ratings = const ["5.0", "4.0", "3.0", "2.0", "1.0"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filters")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Filter By Category:",
                style: AppTextStyles.getLato(14, 5.weight)),
            10.ph,
            Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 6,
                  children: categories
                      .take(4)
                      .map((cat) =>
                          _cb(cat, c.selectedCategories, c.toggleCategory))
                      .toList(),
                ),
                10.ph,
                ...categories.skip(4).map(
                    (cat) => _cb(cat, c.selectedCategories, c.toggleCategory)),
              ],
            ),
            30.ph,
            Text("Filter By Ratings:",
                style: AppTextStyles.getLato(14, 5.weight)),
            10.ph,
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3,
              children: ratings
                  .map((r) =>
                      _cb(r, c.selectedRatings, c.toggleRating, showStar: true))
                  .toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomButton(
          text: "Apply Filter",
          onPressed: () {
            // ✅ return plain lists
            Get.back(result: {
              "categories": c.selectedCategories.toList(),
              "ratings": c.selectedRatings.toList(),
            });
          },
        ),
      ),
    );
  }

  Widget _cb(String label, RxList<String> list, Function(String) onTap,
      {bool showStar = false}) {
    return Obx(() => InkWell(
          onTap: () => onTap(label),
          child: Row(
            children: [
              Checkbox(
                value: list.contains(label),
                onChanged: (_) => onTap(label),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                activeColor: AppColors.primaryColor,
                side: BorderSide(color: AppColors.borderColor, width: 0.5),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              if (showStar) ...[
                Image.asset(Assets.pngIconsStar, height: 16),
                5.pw,
              ],
              Expanded(
                  child:
                      Text(label, style: AppTextStyles.getLato(12, 4.weight))),
            ],
          ),
        ));
  }
}
