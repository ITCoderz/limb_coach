import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/homepage/views/home_page.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

import '../../../../generated/assets.dart';

class ViewReceiptScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  const ViewReceiptScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final items = List<Map<String, dynamic>>.from(order["items"] ?? []);
    final shipping = Map<String, dynamic>.from(order["shipping"] ?? {});
    final payment = Map<String, dynamic>.from(order["payment"] ?? {});

    final subtotal = items.fold<num>(0, (s, it) => s + (it["price"] ?? 0));
    final shippingCost = (payment["shipping"] ?? 15.0) as num;
    final total = payment["total"] ?? (subtotal + shippingCost);

    return Scaffold(
      appBar: customAppBar("Receipt"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Receipt Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage(Assets.pngIconsReceiptBG),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Summary",
                    style: AppTextStyles.getLato(16, 6.weight),
                  ),

                  /// Order Rows
                  12.ph,
                  _buildRow("Shop Name", "My Limb Coach"),
                  _buildRow("Customer", order["customer"] ?? "Rameen Zafar"),
                  _buildRow("Contact", "+31 20 7893895"),
                  5.ph,
                  _buildRow("Total Items", items.length.toString()),

                  ...items.map(
                    (it) => _buildRow(
                      it["name"] ?? "-",
                      "€${(it["price"] ?? 0).toStringAsFixed(2)}",
                    ),
                  ),

                  _buildRow("Shipping", "€${shippingCost.toStringAsFixed(2)}"),
                  _divider(),

                  /// Total Highlight
                  6.ph,
                  _buildRow(
                    "Total",
                    "€${(total as num).toStringAsFixed(2)}",
                    bold: true,
                    highlight: true,
                    size: 17,
                  ),
                  15.ph,

                  /// Shipping Details
                  _sectionCard(
                    title: "Shipping Details",
                    children: [
                      _buildRow("Shipping Method", shipping["address"] ?? "-"),
                      _buildRow("Shipping Address", shipping["method"] ?? "-"),
                    ],
                  ),
                  15.ph,

                  /// Payment Details
                  _sectionCard(
                    title: "Payment Details",
                    children: [
                      _buildRow("Payment Method", payment["method"] ?? "-"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: CustomButton(
          text: "Download Receipt",
          onPressed: () {
            Get.offAll(() => AmputeeDashboardScreen());
          },
        ),
      ),
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTextStyles.getLato(
              16,
              6.weight,
            )),
        12.ph,
        ...children,
      ],
    );
  }

  Widget _buildRow(String label, String value,
      {bool bold = false, bool highlight = false, double size = 14}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.getLato(
              size,
              4.weight,
              AppColors.hintColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.getLato(
                bold ? 24 : size,
                bold ? 7.weight : 5.weight,
                highlight ? AppColors.primaryColor : AppColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Divider(color: AppColors.borderColor, height: 1),
      );
}
