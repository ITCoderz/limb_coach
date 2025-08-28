import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/my_order/views/view_receipt_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/track_order/views/track_order_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  final bool isActive;
  const OrderDetailScreen(
      {super.key, required this.order, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final items = List<Map<String, dynamic>>.from(order["items"] ?? []);
    final shipping = Map<String, dynamic>.from(order["shipping"] ?? {});
    final payment = Map<String, dynamic>.from(order["payment"] ?? {});

    return Scaffold(
      appBar: customAppBar("Order Detail"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoRow('Order ID:', order["id"]),
            5.ph,
            infoRow('Estimated Delivery:', order["estimatedDelivery"]),
            5.ph,
            Row(
              children: [
                Text("Current Status:",
                    style: AppTextStyles.getLato(
                      13,
                      4.weight,
                    )),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => TrackOrderScreen(
                          isActive: isActive,
                        ));
                  },
                  child: Text(
                    order["status"],
                    style: AppTextStyles.getLato(
                        13,
                        4.weight,
                        order["status"] != "Delivered"
                            ? AppColors.primaryColor
                            : Colors.green),
                  ),
                ),
              ],
            ),
            26.ph,

            /// Items Section
            _Section(
              title: "Items in Your Order:",
              child: Column(
                children: items
                    .map(
                      (it) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                color: AppColors.borderColor, width: 0.5),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: SizedBox(
                              height: 42,
                              width: 42,
                              child: Image.asset(Assets.pngIconsLegTransparent),
                            ),
                          ),
                          title: Text(it["name"] ?? "",
                              style: AppTextStyles.getLato(13, 6.weight)),
                          subtitle: Text(
                            "Qty: ${it["qty"]}  |  €${it["price"].toStringAsFixed(2)}",
                            style: AppTextStyles.getLato(
                                11, 4.weight, AppColors.hintColor),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            26.ph,

            /// Shipping Section
            _Section(
              title: "Shipping Details:",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  infoRow("Address:", shipping["address"]),
                  4.ph,
                  infoRow("Method:", shipping["method"]),
                  4.ph,
                  Row(
                    children: [
                      Text("Tracking #: ",
                          style: AppTextStyles.getLato(
                            13,
                            4.weight,
                          )),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => TrackOrderScreen(
                                isActive: isActive,
                              ));
                        },
                        child: Text(
                          shipping["tracking"] ?? "-",
                          style: AppTextStyles.getLato(
                              13, 4.weight, AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            26.ph,

            /// Payment Section
            _Section(
              title: "Payment Details:",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  infoRow("Method:", payment["method"]),
                  4.ph,
                  infoRow("Total Paid:",
                      "€${(payment["total"] ?? 0).toStringAsFixed(2)}"),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Bottom Buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 45,
                child: OutlinedButton(
                  onPressed: () {
                    Get.to(() => ViewReceiptScreen(order: order));
                  },
                  style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                      side: WidgetStatePropertyAll(BorderSide(
                          color: AppColors.primaryColor, width: 0.5))),
                  child: Center(
                    child: Text(
                      "View Receipt",
                      style: AppTextStyles.getLato(
                          16, 6.weight, AppColors.primaryColor),
                    ),
                  ),
                ),
              ),
            ),
            10.pw,
            Expanded(
              child: CustomButton(
                text: "Track Order",
                onPressed: () => Get.to(() => TrackOrderScreen(
                      isActive: isActive,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Section Wrapper
class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.getLato(16, 6.weight)),
        14.ph,
        child,
      ],
    );
  }
}
