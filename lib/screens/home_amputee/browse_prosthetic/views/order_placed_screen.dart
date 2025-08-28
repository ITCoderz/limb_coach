// lib/screens/shop/views/order_placed_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/track_order/views/track_order_screen.dart';
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
      appBar: customAppBar(""),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Spacer(),
            Container(
                height: 69,
                width: 69,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.05),
                    shape: BoxShape.circle),
                child: Image.asset(
                  Assets.pngIconsTickMark,
                )),
            10.ph,
            Text(
              "Order Placed Successfully!",
              style: AppTextStyles.getLato(24, 7.weight),
            ),
            12.ph,
            Text(
                // "Thank you for your purchase.\nThe seller will contact you shortly regarding\nshipping and delivery details. Shipping is\nhandled directly by the seller",
                "Thank you for your purchase.\nYour Order ID: #MLC-123456789\nEstimated Delivery: July 25 - July 28, 2025\nTracking ID: #ABC123XYZ",
                style: AppTextStyles.getLato(14, 4.weight),
                textAlign: TextAlign.center),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.to(() => TrackOrderScreen(
                          isActive: true,
                        )),
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(context.width, 45),
                      side:
                          BorderSide(color: AppColors.primaryColor, width: .8),
                    ),
                    child: Text("Track Order",
                        style: AppTextStyles.getLato(
                            16, 6.weight, AppColors.primaryColor)),
                  ),
                ),
                10.pw,
                Expanded(
                    child: CustomButton(
                        text: "Continue Shopping",
                        onPressed: () {
                          Get.back();
                          Get.back();
                          Get.back();
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
