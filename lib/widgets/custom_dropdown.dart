import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/utils/responsive.dart';

class CustomDropdownField extends StatelessWidget {
  final String fieldLabel;
  final List<String> items;
  final String? value;
  final Function(String?)? onChanged;
  final String selectText;
  final bool isViewMode;

  const CustomDropdownField({
    super.key,
    required this.fieldLabel,
    required this.items,
    this.value,
    this.onChanged,
    this.selectText = "Select Tags",
    this.isViewMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      style: AppTextStyles.getLato(
        Responsive.isMobile(Get.context!) ? 13 : 14,
        4.weight,
        AppColors.blackColor,
      ),
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        labelText: "$fieldLabel*",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: AppTextStyles.getLato(16, 6.weight),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(4), // 🔹 Square corners like screenshot
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
        ),
      ),
      hint: Text(
        selectText,
        style: AppTextStyles.getLato(
          Responsive.isMobile(Get.context!) ? 13 : 14,
          4.weight,
          Colors.black.withOpacity(0.7),
        ),
      ),
      onChanged: isViewMode ? null : onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: AppTextStyles.getLato(
              Responsive.isMobile(Get.context!) ? 13 : 14,
              4.weight,
              AppColors.blackColor,
            ),
          ),
        );
      }).toList(),
    );
  }
}
