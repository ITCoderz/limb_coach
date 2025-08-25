import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

import '../../../../generated/assets.dart';

class ReviewFiltersController extends GetxController {
  // Request filter
  RxList<String> selectedStatus = <String>[].obs;
  RxList<String> selectedRatings = <String>[].obs;

  // Date range
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);
  Rx<DateTime?> toDate = Rx<DateTime?>(null);

  // Toggle checkbox
  void toggleStatus(String status) {
    if (selectedStatus.contains(status)) {
      selectedStatus.remove(status);
    } else {
      selectedStatus.add(status);
    }
  }

  // Toggle checkbox
  void toggleRatings(String status) {
    if (selectedRatings.contains(status)) {
      selectedRatings.remove(status);
    } else {
      selectedRatings.add(status);
    }
  }

  void applyFilters() {
    // 👇 Send filter data back
    Get.back(result: {
      "statuses": selectedStatus,
      "ratings": selectedRatings,
      "fromDate": fromDate.value,
      "toDate": toDate.value,
    });
  }
}

class ReviewFiltersScreen extends StatelessWidget {
  ReviewFiltersScreen({super.key});

  final ReviewFiltersController c = Get.put(ReviewFiltersController());

  Widget _datePickerField(String label, Rx<DateTime?> date, bool isFrom) {
    return Expanded(
      child: Obx(
        () => CustomTextField(
          hintText: "DD/MM/YYYY",
          label: label,
          readOnly: true,
          controller: TextEditingController(
            text: date.value != null
                ? DateFormat("dd/MM/yyyy").format(date.value!)
                : "",
          ),
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              if (isFrom) {
                c.fromDate.value = picked;
              } else {
                c.toDate.value = picked;
              }
            }
          },
        ),
      ),
    );
  }

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
            Text("Filter By Category:",
                style: AppTextStyles.getLato(14, 5.weight)),
            10.ph,
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildCheckbox("All Categories")),
                    Expanded(child: _buildCheckbox("Lower Limb")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildCheckbox("Upper Limb")),
                    Expanded(child: _buildCheckbox("Cosmetic")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildCheckbox("Sports")),
                    Expanded(child: _buildCheckbox("Accessories")),
                  ],
                ),
              ],
            ),

            30.ph,

            /// Section 2: Date Range
            Text("Filter By Date Range:",
                style: AppTextStyles.getLato(14, 5.weight)),
            20.ph,
            Row(
              children: [
                _datePickerField("From", c.fromDate, true),
                10.pw,
                _datePickerField("To", c.toDate, false),
              ],
            ),
            20.ph,
            Text("Filter By Rating:",
                style: AppTextStyles.getLato(14, 5.weight)),
            10.ph,
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildCheckbox("5.0")),
                    Expanded(child: _buildCheckbox("4.0")),
                    Expanded(child: _buildCheckbox("3.0")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildCheckbox("2.0")),
                    Expanded(child: _buildCheckbox("1.0")),
                  ],
                ),
              ],
            ),
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
