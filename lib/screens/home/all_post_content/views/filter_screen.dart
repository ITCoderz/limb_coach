import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

import '../../../../generated/assets.dart';

class PostFiltersController extends GetxController {
  // Request filter
  RxList<String> selectedStatus = <String>[].obs;

  // Toggle checkbox
  void toggleStatus(String status) {
    if (selectedStatus.contains(status)) {
      selectedStatus.remove(status);
    } else {
      selectedStatus.add(status);
    }
  }

  void applyFilters() {
    // 👇 Send filter data back
    Get.back(result: {
      "statuses": selectedStatus,
    });
  }
}

class PostFiltersScreen extends StatelessWidget {
  PostFiltersScreen({super.key});

  final PostFiltersController c = Get.put(PostFiltersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Filters"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Section 1: Request Status
            Text("Filter By Category/Tag:",
                style: AppTextStyles.getLato(14, 5.weight)),
            10.ph,
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildCheckbox("All Categories")),
                    Expanded(child: _buildCheckbox("Prosthetics")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildCheckbox("Paediatric")),
                    Expanded(child: _buildCheckbox("Lower Limb")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildCheckbox("Upper Limb")),
                    Expanded(child: Text("")),
                  ],
                ),
              ],
            ),

            30.ph,
          ],
        ),
      ),

      /// Bottom Apply Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomButton(
          text: "Apply Filters",
          onPressed: () => c.applyFilters(),
        ),
      ),
    );
  }

  Widget _buildCheckbox(String label) {
    return Obx(() => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: c.selectedStatus.contains(label),
              activeColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              side: BorderSide(
                width: 1,
                color: AppColors.borderColor,
              ),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (_) => c.toggleStatus(label),
            ),
            if (label.contains(".0"))
              Image.asset(
                Assets.pngIconsStar,
                height: 17,
              ),
            if (label.contains(".0")) const SizedBox(width: 5),
            Text(
              label,
              style: AppTextStyles.getLato(12, FontWeight.w400),
            ),
          ],
        ));
  }
}
