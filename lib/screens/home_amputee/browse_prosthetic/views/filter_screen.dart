import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/product_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/custom_thumb_shape.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

import '../../../../generated/assets.dart';

class ProductFiltersScreen extends StatelessWidget {
  ProductFiltersScreen({super.key});

  final ProductController c = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Filters"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Category
            Text("Filter By Category:",
                style: AppTextStyles.getLato(14, 5.weight)),
            10.ph,

            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "All Categories", c.selectedCategories, c.toggleCategory),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "Lower Limb", c.selectedCategories, c.toggleCategory),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "Upper Limb", c.selectedCategories, c.toggleCategory),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "Cosmetic", c.selectedCategories, c.toggleCategory),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "Sports", c.selectedCategories, c.toggleCategory),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "Accessories", c.selectedCategories, c.toggleCategory),
                ),
              ],
            ),

            30.ph,

            /// Price Range
            Text("Filter By Price Range:",
                style: AppTextStyles.getLato(14, 5.weight)),
            Obx(() => Theme(
                  data: ThemeData(
                    sliderTheme: SliderThemeData(
                      rangeThumbShape: CustomRangeThumbShape(thumbRadius: 8),
                    ),
                  ),
                  child: RangeSlider(
                    values: c.priceRange.value,
                    min: 0,
                    max: 1000,
                    divisions: 100,
                    inactiveColor: AppColors.primaryColor.withOpacity(0.3),
                    activeColor: AppColors.primaryColor,
                    onChanged: (values) {
                      c.updatePriceRange(values);
                    },
                  ),
                )),

            20.ph,
            Obx(
              () => Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                    label: "From (€)",
                    type: TextInputType.number,
                    readOnly: true,
                    controller: TextEditingController(
                        text: "€${c.minPrice.value.toStringAsFixed(2)}"),
                    hintText: '',
                  )),
                  10.pw,
                  Expanded(
                      child: CustomTextField(
                    label: "To (€)",
                    readOnly: true,
                    type: TextInputType.number,
                    controller: TextEditingController(
                        text: "€${c.maxPrice.value.toStringAsFixed(2)}"),
                    hintText: '',
                  )),
                ],
              ),
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
                      "Daily Wear", c.selectedUseCases, c.toggleUseCase),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "High Activity", c.selectedUseCases, c.toggleUseCase),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "Waterproof", c.selectedUseCases, c.toggleUseCase),
                ),
              ],
            ),

            30.ph,

            /// Brands
            Text("Filter By Brand:",
                style: AppTextStyles.getLato(14, 5.weight)),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "All Brands", c.selectedBrands, c.toggleBrand),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "ActiveProsthetics", c.selectedBrands, c.toggleBrand),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "FutureTech", c.selectedBrands, c.toggleBrand),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "ComfortFit", c.selectedBrands, c.toggleBrand),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "AquaTech", c.selectedBrands, c.toggleBrand),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "MobilityPlus", c.selectedBrands, c.toggleBrand),
                ),
              ],
            ),
            Wrap(
              spacing: 10,
              children: [
                _buildCheckbox("BioFlex", c.selectedBrands, c.toggleBrand),
              ],
            ),

            30.ph,

            /// Ratings
            Text("Filter By Ratings:",
                style: AppTextStyles.getLato(14, 5.weight)),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "5.0", c.selectedRatings, c.toggleRatings,
                      showStar: true),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "4.0", c.selectedRatings, c.toggleRatings,
                      showStar: true),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "3.0", c.selectedRatings, c.toggleRatings,
                      showStar: true),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildCheckbox(
                      "2.0", c.selectedRatings, c.toggleRatings,
                      showStar: true),
                ),
                Expanded(
                  child: _buildCheckbox(
                      "1.0", c.selectedRatings, c.toggleRatings,
                      showStar: true),
                ),
                Expanded(
                  child: Text(""),
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

  Widget _buildCheckbox(
      String label, RxList<String> list, Function(String) onTap,
      {bool showStar = false}) {
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
              if (showStar) ...[
                Image.asset(Assets.pngIconsStar, height: 16),
                5.pw,
              ],
              Text(label, style: AppTextStyles.getLato(12, 4.weight)),
            ],
          ),
        ));
  }
}
