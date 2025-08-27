// lib/screens/shop/views/track_order_screen.dart
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/auth/controllers/time_line_controller.dart';
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
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoRow('Order ID:', 'MLC-123456789'),
            7.ph,
            infoRow('Estimated Delivery:', 'July 25 - July 28, 2025'),
            7.ph,
            infoRow('Current Status:', "Order Placed"),
            7.ph,
            _Section(title: "Timeline", child: Timeline()),
            16.ph,
            _Section(
              title: "Items in Your Order",
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: AppColors.borderColor, width: 0.5)),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(Assets.pngIconsLegTransparent,
                      height: 42, width: 42, fit: BoxFit.cover),
                ),
                title: Text("Lightweight Running Leg",
                    style: AppTextStyles.getLato(13, 6.weight)),
                subtitle: Text("Qty: 1  |  €520.00",
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
                  infoRow("Address", 'Max Mustermann'),
                  4.ph,
                  infoRow("Method:", 'Standard Shipping'),
                  4.ph,
                  infoRow("Tracking #:", 'ABC12345XYZ'),
                ],
              ),
            ),
            16.ph,
            _Section(
              title: "Payment Details",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  infoRow("Method:", 'Credit Card ending in ****1234'),
                  4.ph,
                  infoRow("Total Paid: ", '€5365.00'),
                  4.ph,
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      15.ph,
      Text(title, style: AppTextStyles.getLato(16, 6.weight)),
      10.ph,
      child,
    ]);
  }
}

class Timeline extends StatelessWidget {
  final steps = const [
    ["Order Placed", "Mar 24, 2025 • 10:08 PM"],
    ["Processing", "Mar 24, 2025 • 11:30 PM"],
    ["Out for Delivery", "Mar 25, 2025 • 8:30 AM"],
    ["Shipped", "Mar 25, 2025 • 8:30 AM"],
    ["Delivered", "Mar 25, 2025 • 3:14 PM"]
  ];

  Timeline({super.key});

  final TimelineController c = Get.put(TimelineController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: List.generate(
            steps.length,
            (i) => _sessionTile(
              steps[i][0],
              steps[i][1],
              c.activeStepIndex.value == i, // ✅ only current step is active
              i == steps.length - 1,
            ),
          ),
        ));
  }

  Widget _sessionTile(String title, String time, bool active, bool last) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              Icons.check_circle,
              color: active ? AppColors.primaryColor : AppColors.hintColor,
            ),
            if (!last)
              SizedBox(
                height: 50,
                child: DottedLine(
                  direction: Axis.vertical,
                  dashLength: 2,
                  dashGapLength: 2,
                  dashColor: AppColors.primaryColor,
                ),
              )
          ],
        ),
        10.pw,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.getLato(14, 6.weight)),
            5.ph,
            Text(
              time,
              style: AppTextStyles.getLato(12, 4.weight, AppColors.hintColor),
            ),
          ],
        ),
      ],
    );
  }
}

Widget infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: AppTextStyles.getLato(
              13,
              4.weight,
            )),
        Text(value, style: AppTextStyles.getLato(13, 4.weight)),
      ],
    ),
  );
}
