import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/cart_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/checkout_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/checkout_payment_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_dropdown.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class CheckoutShippingScreen extends StatelessWidget {
  CheckoutShippingScreen({super.key});
  final cc = Get.put(CheckoutController());
  final cart = Get.find<CartController>();

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
                _stepIndicator(1),
                20.ph,
                Text("Shipping Details:",
                    style: AppTextStyles.getLato(16, 6.weight)),
                10.ph,
                CustomTextField(
                  label: "Full Name",
                  onChanged: (v) => cc.fullName.value = v,
                  hintText: '',
                  controller: TextEditingController(),
                ),
                10.ph,
                CustomTextField(
                  label: "Address",
                  onChanged: (v) => cc.address1.value = v,
                  hintText: '',
                  controller: TextEditingController(),
                ),
                10.ph,
                Row(
                  children: [
                    Expanded(
                        child: CustomDropdownField(
                            fieldLabel: "Country",
                            items: ["USA", "UK"],
                            onChanged: (v) => cc.country.value = v!)),
                    10.pw,
                    Expanded(
                        child: CustomDropdownField(
                            fieldLabel: "City",
                            items: ["NEW YORK", "PUNJAB"],
                            onChanged: (v) => cc.city.value = v!)),
                  ],
                ),
                10.ph,
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      label: "State/Province",
                      onChanged: (v) => cc.state.value = v,
                      hintText: '',
                      controller: TextEditingController(),
                    )),
                    10.pw,
                    Expanded(
                        child: CustomTextField(
                      label: "Postal Code",
                      onChanged: (v) => cc.postal.value = v,
                      hintText: '',
                      controller: TextEditingController(),
                    )),
                  ],
                ),
                20.ph,
                Text("Shipping Options:",
                    style: AppTextStyles.getLato(16, 6.weight)),
                8.ph,
                _shipOption("Standard Shipping - €15.00"),
                _shipOption("Express Shipping - €35.00"),
                20.ph,
                _SummaryBox(
                    subtotal: cart.subtotal,
                    shipping:
                        cc.shippingOption.value.contains("Express") ? 35 : 15),
                20.ph,
                CustomButton(
                  text: "Proceed to Payment",
                  onPressed: cc.shippingValid
                      ? () => Get.to(() => CheckoutPaymentScreen())
                      : () {},
                  backgroundColor: cc.shippingValid
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(.4),
                  borderColor: cc.shippingValid
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(.4),
                ),
              ],
            )),
      ),
    );
  }

  Widget _shipOption(String label) {
    return Obx(() => RadioListTile<String>(
          value: label,
          groupValue: cc.shippingOption.value,
          onChanged: (v) => cc.shippingOption.value = v!,
          title: Text(label, style: AppTextStyles.getLato(13, 4.weight)),
          dense: true,
          contentPadding: EdgeInsets.zero,
        ));
  }
}

class _SummaryBox extends StatelessWidget {
  const _SummaryBox({required this.subtotal, required this.shipping});
  final double subtotal;
  final double shipping;

  @override
  Widget build(BuildContext context) {
    final est = subtotal + shipping;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor, width: .5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _row("Subtotal", "€${subtotal.toStringAsFixed(2)}"),
          _row("Shipping", "€${shipping.toStringAsFixed(2)}"),
          const Divider(),
          _row("Estimated Total", "€${est.toStringAsFixed(2)}", bold: true),
        ],
      ),
    );
  }

  Widget _row(String l, String r, {bool bold = false}) => Row(
        children: [
          Text(l, style: AppTextStyles.getLato(13, bold ? 6.weight : 4.weight)),
          const Spacer(),
          Text(r, style: AppTextStyles.getLato(13, bold ? 7.weight : 5.weight)),
        ],
      );
}
