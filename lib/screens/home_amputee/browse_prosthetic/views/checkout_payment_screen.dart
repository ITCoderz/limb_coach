// lib/screens/shop/views/checkout_payment_screen.dart
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/checkout_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/order_placed_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

import '../../../home_professional/homepage/components/custom_app_bar.dart';

class CheckoutPaymentScreen extends StatelessWidget {
  CheckoutPaymentScreen({super.key});
  final cc = Get.find<CheckoutController>();

  Widget _stepIndicator(int step) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: AppColors.primaryColor, size: 28),
        Expanded(
          child: DottedLine(
            dashLength: 1,
            dashGapLength: 1,
            lineThickness: 1,
            dashColor: step == 1
                ? AppColors.hintColor.withOpacity(0.4)
                : AppColors.primaryColor,
          ),
        ),
        Icon(Icons.check_circle,
            size: 28,
            color: step == 2 ? AppColors.primaryColor : AppColors.hintColor),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Checkout"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _stepIndicator(2),
                20.ph,
                Text("Payment Details:",
                    style: AppTextStyles.getLato(16, 6.weight)),
                10.ph,
                _methodTile("Visa"),
                _methodTile("Mastercard"),
                _methodTile("Stripe"),
                10.ph,
                CustomTextField(
                  label: "Cardholder Name",
                  onChanged: (v) => cc.cardName.value = v,
                  controller: TextEditingController(),
                  hintText: '',
                ),
                10.ph,
                CustomTextField(
                  label: "Card Number",
                  type: TextInputType.number,
                  onChanged: (v) => cc.cardNumber.value = v,
                  hintText: '',
                  controller: TextEditingController(),
                ),
                10.ph,
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      label: "Expiry (MM/YY)",
                      onChanged: (v) => cc.expiry.value = v,
                      hintText: '',
                      controller: TextEditingController(),
                    )),
                    10.pw,
                    Expanded(
                        child: CustomTextField(
                      label: "CVC",
                      type: TextInputType.number,
                      onChanged: (v) => cc.cvc.value = v,
                      hintText: '',
                      controller: TextEditingController(),
                    )),
                  ],
                ),
                20.ph,
                CustomButton(
                  text: "Place Order",
                  onPressed: cc.paymentValid
                      ? () => Get.off(() => const OrderPlacedScreen())
                      : () {},
                  backgroundColor: cc.paymentValid
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(.4),
                  borderColor: cc.paymentValid
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(.4),
                ),
              ],
            )),
      ),
    );
  }

  Widget _methodTile(String label) {
    return Obx(() => RadioListTile<String>(
          value: label,
          groupValue: cc.method.value,
          onChanged: (v) => cc.method.value = v!,
          title: Text(label, style: AppTextStyles.getLato(13, 4.weight)),
          dense: true,
          contentPadding: EdgeInsets.zero,
        ));
  }
}
