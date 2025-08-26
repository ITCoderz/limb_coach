// lib/screens/shop/views/order_placed_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/track_order_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Order Placed Successfully!"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Spacer(),
            Icon(Icons.verified, size: 72, color: AppColors.primaryColor),
            12.ph,
            Text("Your order has been placed!",
                style: AppTextStyles.getLato(18, 7.weight),
                textAlign: TextAlign.center),
            6.ph,
            Text("You can track its status in Track Order.",
                style: AppTextStyles.getLato(13, 4.weight),
                textAlign: TextAlign.center),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.offAll(() => const TrackOrderScreen()),
                    style: OutlinedButton.styleFrom(
                      side:
                          BorderSide(color: AppColors.primaryColor, width: .8),
                    ),
                    child: Text("Track Order",
                        style: AppTextStyles.getLato(
                            14, 5.weight, AppColors.primaryColor)),
                  ),
                ),
                10.pw,
                Expanded(
                    child: CustomButton(
                        text: "Continue Shopping",
                        onPressed: () => Get.back())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
