import 'package:dropdown_button2/dropdown_button2.dart';
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
    required this.value,
    this.onChanged,
    this.selectText = "Select",
    this.isViewMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: fieldLabel,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: AppTextStyles.getLato(16, 6.weight),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
        ),
      ),
      hint: Text(
        "$selectText $fieldLabel",
        style: AppTextStyles.getLato(
          Responsive.isMobile(Get.context!) ? 13 : 14,
          4.weight,
        ),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.keyboard_arrow_down_rounded),
      ),
      selectedItemBuilder: (context) {
        return items.map((item) {
          return Text(
            item,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.getLato(
              Responsive.isMobile(Get.context!) ? 13 : 14,
              4.weight,
              AppColors.blackColor, // ✅ white if selected
            ),
          );
        }).toList();
      },
      dropdownStyleData: DropdownStyleData(
        maxHeight: 350,
        elevation: 0,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(color: AppColors.borderColor),
        ),
        offset: const Offset(0, -10),
      ),
      menuItemStyleData: MenuItemStyleData(
        selectedMenuItemBuilder: (context, child) {
          print("<==========================>");

          return Container(
              height: 42, color: AppColors.primaryColor, child: child);
          // fallback if it's not Text
        },
      ),

      onChanged: isViewMode ? null : onChanged,

      /// ✅ Normal items (no background color here)
      items: items.map((String item) {
        // print(item);
        // print(value);
        // print(item == value);
        final bool isSelected = item == value;
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: AppTextStyles.getLato(
              Responsive.isMobile(Get.context!) ? 13 : 14,
              4.weight,
              isSelected ? Colors.white : AppColors.blackColor,
            ),
          ),
        );
      }).toList(),
    );
  }
}
