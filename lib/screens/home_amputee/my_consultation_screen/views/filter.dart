import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/screens/home_amputee/my_consultation_screen/controllers/my_consultation_controller.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class ConsultationFilterPage extends StatelessWidget {
  final MyConsultationController c = Get.find();

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
                c.filterFrom.value = picked;
              } else {
                c.filterTo.value = picked;
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildCheckbox(
      String label, RxSet<String> selectedSet, String allLabel) {
    return Obx(() => Row(
          children: [
            Checkbox(
              value: selectedSet.contains(label),
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
              onChanged: (_) => c.toggleSelection(label, selectedSet, allLabel),
            ),
            Text(
              label,
              style: AppTextStyles.getLato(12, FontWeight.w400),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Filters"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Section 1: Date Range
            Text("Filter By Date Range:",
                style: AppTextStyles.getLato(14, 5.weight)),
            20.ph,
            Row(
              children: [
                _datePickerField("From", c.filterFrom, true),
                10.pw,
                _datePickerField("To", c.filterTo, false),
              ],
            ),

            30.ph,

            /// Section 2: Consultation Type
            Text("Filter By Consultation Type",
                style: AppTextStyles.getLato(14, 5.weight)),
            20.ph,
            // Consultation Type
            Row(
              children: [
                Expanded(
                    child: _buildCheckbox(
                        "All Type", c.selectedTypes, "All Type")),
                Expanded(
                    child: _buildCheckbox(
                        "Video Call", c.selectedTypes, "All Type")),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: _buildCheckbox(
                        "Phone Call", c.selectedTypes, "All Type")),
                Expanded(
                    child: _buildCheckbox(
                        "In-Person", c.selectedTypes, "All Type")),
              ],
            ),

// Status

            30.ph,

            /// Section 3: Status
            Text("Filter By Status",
                style: AppTextStyles.getLato(14, 5.weight)),
            20.ph,
            Row(
              children: [
                Expanded(
                    child: _buildCheckbox(
                        "All Status", c.selectedStatus, "All Status")),
                Expanded(
                  child: _buildCheckbox(
                      "Completed", c.selectedStatus, "All Status"),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: _buildCheckbox(
                        "Pending", c.selectedStatus, "All Status")),
                Expanded(
                    child: _buildCheckbox(
                        "Cancelled", c.selectedStatus, "All Status")),
              ],
            ),

            const Spacer(),

            CustomButton(
              onPressed: () {
                c.applyFilters();
                Get.back();
              },
              text: "Apply Filter",
            ),
          ],
        ),
      ),
    );
  }
}
