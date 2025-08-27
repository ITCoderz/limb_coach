import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/controllers/form_controllers.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class ForumFiltersScreen extends StatelessWidget {
  ForumFiltersScreen({super.key});

  final ForumController c = Get.put(ForumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Filters"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Topics
            Text("Filter By Topic:",
                style: AppTextStyles.getLato(14, 5.weight)),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "All Topics", c.selectedTopics, c.toggleTopic),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "New Amputee Support", c.selectedTopics, c.toggleTopic),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox("Device Maintenance & Care",
                      c.selectedTopics, c.toggleTopic),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "Living with Limb Loss", c.selectedTopics, c.toggleTopic),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "Sports & Fitness", c.selectedTopics, c.toggleTopic),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),

            30.ph,

            /// Use Case
            Text("Filter By Use-Case:",
                style: AppTextStyles.getLato(14, 5.weight)),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "All Use Cases", c.selectedUseCases, c.toggleUseCase),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "Trending", c.selectedUseCases, c.toggleUseCase),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "Recent", c.selectedUseCases, c.toggleUseCase),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),

      /// Bottom Apply Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomButton(
          text: "Apply Filter",
          onPressed: () => c.applyFilters(),
        ),
      ),
    );
  }

  Widget _buildCheckbox(
      String label, RxList<String> list, Function(String) onTap) {
    return Obx(() => InkWell(
          onTap: () => onTap(label),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: list.contains(label),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                side: BorderSide(color: AppColors.borderColor, width: 0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                activeColor: AppColors.primaryColor,
                onChanged: (_) => onTap(label),
              ),
              Text(label, style: AppTextStyles.getLato(12, 4.weight)),
            ],
          ),
        ));
  }
}
