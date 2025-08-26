// lib/screens/shop/views/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/cart_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/product_controller.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, required this.product});
  final Map<String, dynamic> product;
  final pc = Get.find<ProductController>();
  final cart = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    pc.selectedSize.value = (product["sizes"] as List).first;
    pc.qty.value = 1;

    return Scaffold(
      appBar: customAppBar(''),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(product["image"], height: 180)),
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(product["type"],
                      style: AppTextStyles.getLato(18, 7.weight)),
                ),
                Text(product["price"],
                    style: AppTextStyles.getLato(
                        20, 7.weight, AppColors.primaryColor)),
              ],
            ),
            6.ph,
            Row(
              children: [
                Text("By ",
                    style: AppTextStyles.getLato(
                        13, 4.weight, AppColors.hintColor)),
                Text("${product["vendor"]}",
                    style: AppTextStyles.getLato(
                        13, 4.weight, AppColors.primaryColor)),
              ],
            ),
            10.ph,
            Row(
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 1),
                      child: Image.asset(
                        index < product["rating"]
                            ? Assets.pngIconsStar // ⭐ yellow star
                            : Assets.pngIconsStar, // ☆ grey star
                        width: 18,
                        color: index < product["rating"].toInt()
                            ? Color(0xffFEBD17)
                            : Color(0xffFEBD17).withOpacity(0.5),
                        height: 18,
                      ),
                    );
                  }),
                ),
                6.pw,
                Text(
                  "(${product["reviewsCount"]} Reviews)",
                ),
              ],
            ),
            16.ph,
            Text(
              "Select Size:",
              style: AppTextStyles.getLato(16, 5.weight),
            ),
            8.ph,
            Obx(() {
              return Wrap(
                spacing: 8,
                children: (product["sizes"] as List<String>).map((size) {
                  final isSelected = pc.selectedSize.value == size;
                  return GestureDetector(
                    onTap: () => pc.setSize(size),
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.borderColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          size,
                          style: AppTextStyles.getLato(
                            13,
                            6.weight,
                            isSelected ? Colors.white : AppColors.hintColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
            16.ph,
            Text(
              "Quantity:",
              style: AppTextStyles.getLato(16, 5.weight),
            ),
            8.ph,
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.borderColor, width: 0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: _QtyBtn(icon: Icons.remove, onTap: pc.decQty),
                ),
                15.pw,
                Obx(
                  () => Text("${pc.qty.value}",
                      style: AppTextStyles.getLato(16, 6.weight)),
                ),
                15.pw,
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.borderColor, width: 0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: _QtyBtn(icon: Icons.add, onTap: pc.incQty),
                ),
              ],
            ),
            16.ph,
            _Tabs(
                about: product["about"],
                comp: product["compatibility"],
                warranty: product["warranty"]),
            16.ph,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {}, // Contact vendor flow
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size.fromHeight(48),
                      side:
                          BorderSide(color: AppColors.primaryColor, width: 0.8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text("Contact Vendor",
                        style: AppTextStyles.getLato(
                            14, 5.weight, AppColors.primaryColor)),
                  ),
                ),
                10.pw,
                Expanded(
                  child: CustomButton(
                    text: "Add to Cart",
                    onPressed: () => cart.addToCart(
                        product, pc.selectedSize.value, pc.qty.value),
                  ),
                ),
              ],
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, this.light = false});
  final String text;
  final bool light;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: light
            ? AppColors.hintColor.withOpacity(.08)
            : AppColors.primaryColor.withOpacity(.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: AppTextStyles.getLato(11, 5.weight)),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, size: 20),
    );
  }
}

class _Tabs extends StatefulWidget {
  const _Tabs(
      {required this.about, required this.comp, required this.warranty});
  final String about, comp, warranty;

  @override
  State<_Tabs> createState() => _TabsState();
}

class _TabsState extends State<_Tabs> with TickerProviderStateMixin {
  late final TabController t;

  @override
  void initState() {
    super.initState();
    t = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: AppColors.borderColor, width: 0.5), // grey line
            ),
          ),
          child: TabBar(
            controller: t,
            indicatorPadding: EdgeInsets.zero,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.hintColor,
            unselectedLabelStyle: AppTextStyles.getLato(13, 4.weight),
            labelStyle: AppTextStyles.getLato(13, 7.weight),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
            ),
            tabs: const [
              Tab(text: "ABOUT"),
              Tab(text: "COMPATIBILITY"),
              Tab(text: "WARRANTY"),
            ],
          ),
        ),
        10.ph,
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: t,
            children: [
              Text(widget.about, style: AppTextStyles.getLato(13, 4.weight)),
              Text(widget.comp, style: AppTextStyles.getLato(13, 4.weight)),
              Text(widget.warranty, style: AppTextStyles.getLato(13, 4.weight)),
            ],
          ),
        ),
      ],
    );
  }
}
