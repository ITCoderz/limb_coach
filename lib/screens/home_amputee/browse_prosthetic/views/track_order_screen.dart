// lib/screens/shop/views/track_order_screen.dart
import 'package:flutter/material.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Track Order"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Section(title: "Timeline", child: _Timeline()),
            16.ph,
            _Section(
              title: "Items in Your Order",
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset("assets/png/demo_leg.png",
                      height: 42, width: 42, fit: BoxFit.cover),
                ),
                title: Text("Lightweight Running Leg",
                    style: AppTextStyles.getLato(13, 6.weight)),
                subtitle: Text("Qty: 1  •  €520.00",
                    style: AppTextStyles.getLato(
                        11, 4.weight, AppColors.hintColor)),
              ),
            ),
            16.ph,
            _Section(
              title: "Shipping Details",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Max Mustermann",
                      style: AppTextStyles.getLato(13, 5.weight)),
                  4.ph,
                  Text("123, Berlin, Germany • 10115",
                      style: AppTextStyles.getLato(
                          12, 4.weight, AppColors.hintColor)),
                  6.ph,
                  Text("Tracking ID: ABC123XYZ",
                      style: AppTextStyles.getLato(12, 5.weight)),
                ],
              ),
            ),
            16.ph,
            _Section(
              title: "Payment Details",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Method: Credit Card ending **2349",
                      style: AppTextStyles.getLato(12, 4.weight)),
                  4.ph,
                  Text("Tax: €32.00",
                      style: AppTextStyles.getLato(12, 4.weight)),
                  4.ph,
                  Text("Total Paid: €552.00",
                      style: AppTextStyles.getLato(13, 6.weight)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor, width: .5),
          borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: AppTextStyles.getLato(14, 6.weight)),
        8.ph,
        child,
      ]),
    );
  }
}

class _Timeline extends StatelessWidget {
  final steps = const [
    ["Order Placed", "Mar 24, 2025 • 10:08 PM"],
    ["Processing", "Mar 24, 2025 • 11:30 PM"],
    ["Out for Delivery", "Mar 25, 2025 • 8:30 AM"],
    ["Delivered", "Mar 25, 2025 • 3:14 PM"]
  ];

  const _Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps
          .map((s) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: Text(s[0], style: AppTextStyles.getLato(13, 6.weight)),
                subtitle: Text(s[1],
                    style: AppTextStyles.getLato(
                        11, 4.weight, AppColors.hintColor)),
              ))
          .toList(),
    );
  }
}
