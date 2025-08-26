// lib/screens/shop/views/browse_prosthetics_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/product_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/product_detail_screen.dart';
import 'package:mylimbcoach/screens/home_professional/all_reviews/views/filter_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class BrowseProstheticsScreen extends StatelessWidget {
  BrowseProstheticsScreen({super.key});
  final c = Get.put(ProductController());

  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        autofocus: false,
        onChanged: (val) => c.query.value = val, // ✅ live search
        decoration: InputDecoration(
          hintText: 'Search Here...',
          hintStyle: AppTextStyles.getLato(13, 4.weight, Color(0xffA6A6A6)),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xffA6A6A6),
          ),
          filled: false,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Browse Prosthetics"),
      body: Column(
        children: [
          // 🔍 Search + Filter (your exact pattern)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(child: _buildSearchBar()),
                  10.pw,
                  GestureDetector(
                    onTap: () async {
                      final result = await Get.to(() => ReviewFiltersScreen());
                      if (result != null) {
                        c.selectedRatings.assignAll(result["ratings"] ?? []);
                        c.fromDate.value = result["fromDate"];
                        c.toDate.value = result["toDate"];
                      }
                    },
                    child: Container(
                      height: 48,
                      width: 79,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: AppColors.borderColor, width: 0.5),
                      ),
                      child: Row(
                        children: [
                          Image.asset(Assets.pngIconsFilter, height: 22),
                          5.pw,
                          Text("Filter",
                              style: AppTextStyles.getLato(13, 4.weight)),
                        ],
                      ),
                    ),
                  ),
                  5.pw,
                ],
              ),
            ),
          ),
          10.ph,
          Expanded(
            child: Obx(() {
              final list = c.filtered;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 10,
                    childAspectRatio: .78,
                  ),
                  itemBuilder: (_, i) {
                    final p = list[i];
                    return GestureDetector(
                      onTap: () =>
                          Get.to(() => ProductDetailScreen(product: p)),
                      child: _ProductCard(p: p),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.p});
  final Map<String, dynamic> p;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: (context.width / 2) - 24,
          padding: const EdgeInsets.all(6.0),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.borderColor, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset("${p['image']}", height: 130),
                ),
              ),
              10.ph,
              Text("${p["type"]}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyles.getLato(13, 6.weight)),
              5.ph,
              Row(
                children: [
                  Text("By ", style: AppTextStyles.getLato(10, 4.weight)),
                  Text("${p["vendor"]}",
                      style: AppTextStyles.getLato(
                          10, 4.weight, AppColors.primaryColor)),
                ],
              ),
              10.ph,
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () =>
                          Get.to(() => ProductDetailScreen(product: p)),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.primaryColor),
                        child: Center(
                          child: Text(
                            "Add to Cart",
                            style: AppTextStyles.getLato(
                                12, 6.weight, AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  10.pw,
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.borderColor, width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text("${p['price']}",
                            style: AppTextStyles.getLato(
                                11, 4.weight, AppColors.hintColor)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor.withOpacity(0.05)),
              child: Row(
                children: [
                  Image.asset(
                    Assets.pngIconsStar,
                    height: 18,
                  ),
                  5.pw,
                  Text(
                    "${p['rating']}",
                    style: AppTextStyles.getLato(10, 4.weight),
                  ),
                  5.pw,
                ],
              ),
            ))
      ],
    );
  }
}
