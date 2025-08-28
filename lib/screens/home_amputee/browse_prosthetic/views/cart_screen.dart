// lib/screens/shop/views/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/cart_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/checkout_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final cart = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("My Cart"),
      body: Obx(() {
        if (cart.items.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 69,
                  width: 69,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.05),
                      shape: BoxShape.circle),
                  child: Image.asset(
                    Assets.pngIconsMyCart,
                  )),
              10.ph,
              Text(
                "No Items in cart",
                style: AppTextStyles.getLato(18, 6.weight),
              ),
              5.ph,
              Center(
                child: Text(
                    'Your items will show here once you’ve add to cart them',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.getLato(
                        13, 5.weight, AppColors.hintColor)),
              ),
            ],
          );
        }

        return Column(
          children: [
            // ✅ Select All checkbox
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Checkbox(
                    value: cart.isAllSelected,
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
                    onChanged: (_) => cart.toggleSelectAll(),
                  ),
                  Text("Select All",
                      style: AppTextStyles.getLato(13, 5.weight)),
                ],
              ),
            ),
            10.ph,
            // ✅ Cart items
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (_, i) {
                  final it = cart.items[i];
                  final p = it["product"] as Map<String, dynamic>;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: cart.selectedIndexes.contains(i),
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
                        onChanged: (_) => cart.toggleItem(i),
                      ),
                      10.pw,
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.borderColor)),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(p["image"],
                                    height: 68, width: 68, fit: BoxFit.cover),
                              ),
                              10.pw,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p["type"],
                                      style:
                                          AppTextStyles.getLato(13, 5.weight)),
                                  4.ph,
                                  Text(
                                      "€${(it["priceNum"] as double).toStringAsFixed(2)}",
                                      style:
                                          AppTextStyles.getLato(11, 4.weight)),
                                  10.ph,
                                  Row(
                                    children: [
                                      Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.borderColor,
                                              width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: _QtyBtn(
                                            icon: Icons.remove,
                                            onTap: () {
                                              cart.dec(i);
                                            }),
                                      ),
                                      15.pw,
                                      Text("${it['qty']}",
                                          style: AppTextStyles.getLato(
                                              16, 6.weight)),
                                      15.pw,
                                      Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.borderColor,
                                              width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: _QtyBtn(
                                            icon: Icons.add,
                                            onTap: () {
                                              cart.inc(i);
                                            }),
                                      ),
                                    ],
                                  ),
                                  10.pw,
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () => cart.removeAt(i),
                                  icon: Container(
                                    height: 30,
                                    width: 30,
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        color: AppColors.redColor
                                            .withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Image.asset(
                                      Assets.pngIconsDelete,
                                      color: AppColors.redColor,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: cart.items.length,
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() => cart.selectedIndexes.isEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row(
                  //   children: [
                  //     Text("Subtotal",
                  //         style: AppTextStyles.getLato(14, 5.weight)),
                  //     const Spacer(),
                  //     Text("€${cart.subtotal.toStringAsFixed(2)}",
                  //         style: AppTextStyles.getLato(14, 7.weight)),
                  //   ],
                  // ),
                  10.ph,
                  CustomButton(
                    text: "Proceed to Checkout",
                    onPressed: () => Get.to(() => CheckoutScreen()),
                  ),
                ],
              ),
            )),
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
