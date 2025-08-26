// lib/screens/shop/views/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/cart_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/checkout_shipping_screen.dart';
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
      body: Obx(() => cart.items.isEmpty
          ? Center(
              child: Text("Your cart is empty",
                  style: AppTextStyles.getLato(14, 4.weight)))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, i) {
                final it = cart.items[i];
                final p = it["product"] as Map<String, dynamic>;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(value: true, onChanged: (_) {}),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(p["image"],
                          height: 45, width: 45, fit: BoxFit.cover),
                    ),
                    10.pw,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p["type"],
                              style: AppTextStyles.getLato(13, 6.weight)),
                          4.ph,
                          Text("Size: ${it["size"]}",
                              style: AppTextStyles.getLato(
                                  11, 4.weight, AppColors.hintColor)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => cart.dec(i),
                            icon: const Icon(Icons.remove)),
                        Text("${it["qty"]}"),
                        IconButton(
                            onPressed: () => cart.inc(i),
                            icon: const Icon(Icons.add)),
                      ],
                    ),
                    10.pw,
                    Text("€${(it["priceNum"] as double).toStringAsFixed(2)}",
                        style: AppTextStyles.getLato(12, 6.weight)),
                    IconButton(
                        onPressed: () => cart.removeAt(i),
                        icon: const Icon(Icons.delete_outline)),
                  ],
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: cart.items.length,
            )),
      bottomNavigationBar: Obx(() => cart.items.isEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text("Subtotal",
                          style: AppTextStyles.getLato(14, 5.weight)),
                      const Spacer(),
                      Text("€${cart.subtotal.toStringAsFixed(2)}",
                          style: AppTextStyles.getLato(14, 7.weight)),
                    ],
                  ),
                  10.ph,
                  CustomButton(
                    text: "Proceed to Checkout",
                    onPressed: () => Get.to(() => CheckoutShippingScreen()),
                  ),
                ],
              ),
            )),
    );
  }
}
