import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/components/card_formatters.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/cart_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/checkout_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/order_placed_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_dropdown.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});
  final cc = Get.put(CheckoutController());
  final cart = Get.find<CartController>();

  Widget _stepIndicator(int step) {
    return Row(
      children: [
        Icon(Icons.check_circle,
            color: step >= 1 ? AppColors.primaryColor : AppColors.hintColor,
            size: 28),
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
            color: step >= 2 ? AppColors.primaryColor : AppColors.hintColor),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Checkout"),
      // ✅ Fixed Button at Bottom
      bottomNavigationBar: Obx(() {
        final isShippingStep = cc.step.value == 1;
        final valid =
            isShippingStep ? cc.shippingValid.value : cc.paymentValid.value;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: isShippingStep ? "Proceed to Payment" : "Place Order",
              onPressed: valid
                  ? () {
                      if (isShippingStep) {
                        cc.next();
                      } else {
                        Get.off(() => const OrderPlacedScreen());
                      }
                    }
                  : () {},
              backgroundColor: valid
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withOpacity(.4),
              borderColor: valid
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withOpacity(.4),
            ),
          ),
        );
      }),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stepIndicator(cc.step.value),
              20.ph,
              if (cc.step.value == 1) _shippingForm(),
              if (cc.step.value == 2) _paymentForm(),
            ],
          );
        }),
      ),
    );
  }

  // -------------------
  // SHIPPING STEP
  // -------------------
  Widget _shippingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Shipping Details:", style: AppTextStyles.getLato(24, 7.weight)),
        20.ph,
        CustomTextField(
          label: "Full Name",
          onChanged: (v) => cc.fullName.value = v,
          hintText: 'eg., John Doe',
          controller: cc.fullNameCtrl,
        ),
        20.ph,
        CustomTextField(
          label: "Address",
          onChanged: (v) => cc.address1.value = v,
          hintText: 'eg., 123 Main Street, USA',
          controller: cc.addressCtrl,
        ),
        20.ph,
        Row(
          children: [
            Expanded(
              child: CustomDropdownField(
                fieldLabel: "Country",
                value: cc.country.value,
                items: ["USA", "UK", "Germany"],
                onChanged: (v) => cc.country.value = v!,
              ),
            ),
            10.pw,
            Expanded(
              child: CustomDropdownField(
                fieldLabel: "City",
                items: ["New York", "Paris"],
                value: cc.city.value,
                onChanged: (v) => cc.city.value = v!,
              ),
            ),
          ],
        ),
        20.ph,
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: "State/Province",
                onChanged: (v) => cc.state.value = v,
                hintText: 'eg., Hessen',
                controller: cc.stateCtrl,
              ),
            ),
            10.pw,
            Expanded(
              child: CustomTextField(
                label: "Postal Code",
                onChanged: (v) => cc.postal.value = v,
                hintText: 'eg., 660000',
                type: TextInputType.number,
                controller: cc.postalCtrl,
              ),
            ),
          ],
        ),
        10.ph,
        Obx(
          () => buildCheckboxWithLabel(
            value: cc.saveAddress.value,
            label: "Save this address for future purchases",
            onChanged: (val) {
              cc.toggleSaveAddress(val);
            },
          ),
        ),
        20.ph,
        Text("Shipping Options:", style: AppTextStyles.getLato(16, 6.weight)),
        12.ph,
        _shipOption(
            "Standard Shipping - €15.00", "Estimated: 5-7 business days"),
        10.ph,
        _shipOption(
            "Express Shipping - €35.00", "Estimated: 1-2 business days"),
        20.ph,
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking ID:",
                style: AppTextStyles.getLato(12, 4.weight),
              ),
              Text(
                "#ABC123XYZ",
                style:
                    AppTextStyles.getLato(14, 5.weight, AppColors.primaryColor),
              ),
            ],
          ),
        ),
        20.ph,
        _SummaryBox(
          subtotal: cart.subtotal,
          shipping: cc.shippingOption.value.contains("Express") ? 35 : 15,
        ),
        20.ph,
      ],
    );
  }

  // -------------------
  // PAYMENT STEP
  // -------------------
  Widget _paymentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Details:", style: AppTextStyles.getLato(24, 7.weight)),
        20.ph,
        _methodTile("Credit Card"),
        _methodTile("PayPal"),
        _methodTile("Bank Transfer"),
        20.ph,
        if (cc.method.value == "Credit Card")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Credit Card Details:",
                style: AppTextStyles.getLato(16, 6.weight),
              ),
              25.ph,
              CustomTextField(
                label: "Card Number",
                type: TextInputType.number,
                onChanged: (v) => cc.cardNumber.value = v,
                controller: cc.cardNumberCtrl,
                hintText: '0000 0000 0000 0000',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  CardNumberFormatter(),
                ],
              ),
              20.ph,
              CustomTextField(
                label: "Cardholder Name",
                onChanged: (v) => cc.cardName.value = v,
                controller: cc.cardNameCtrl,
                hintText: 'eg., John Doe',
              ),
              20.ph,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: "Expiry (MM/YY)",
                      onChanged: (v) => cc.expiry.value = v,
                      controller: cc.expiryCtrl,
                      type: TextInputType.number,
                      hintText: 'MM/YY',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        ExpiryDateFormatter(),
                      ],
                    ),
                  ),
                  10.pw,
                  Expanded(
                    child: CustomTextField(
                      label: "CVC",
                      type: TextInputType.number,
                      onChanged: (v) => cc.cvc.value = v,
                      controller: cc.cvcCtrl,
                      hintText: '123',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),
                  ),
                ],
              ),
              20.ph,
              Obx(
                () => buildCheckboxWithLabel(
                  value: cc.billingAddress.value,
                  label: "Billing address same as shipping",
                  onChanged: (val) {
                    cc.toggleBillingAddress(val);
                  },
                ),
              ),
            ],
          ),
        20.ph,
      ],
    );
  }

  Widget _shipOption(String label, String desc) {
    return Obx(
      () => InkWell(
        onTap: () => cc.shippingOption.value = label,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<String>(
              value: label,
              groupValue: cc.shippingOption.value,
              activeColor: AppColors.primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              onChanged: (v) => cc.shippingOption.value = v!,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.getLato(14, 5.weight)),
                  5.ph,
                  Text(desc,
                      style: AppTextStyles.getLato(
                          12, 4.weight, AppColors.hintColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _methodTile(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Obx(() => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<String>(
                value: label,
                groupValue: cc.method.value,
                onChanged: (v) => cc.method.value = v!,
                activeColor: AppColors.primaryColor,
                visualDensity: const VisualDensity(
                  horizontal: -4,
                  vertical: -4,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              10.pw,
              Text(
                label,
                style: AppTextStyles.getLato(13, 4.weight),
              ),
              Spacer(),
              if (label == "PayPal")
                Image.asset(
                  Assets.pngIconsPaypal,
                  height: 20,
                )
            ],
          )),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  const _SummaryBox({required this.subtotal, required this.shipping});
  final double subtotal;
  final double shipping;

  @override
  Widget build(BuildContext context) {
    final est = subtotal + shipping;
    return Column(
      children: [
        _row("Subtotal", "€${subtotal.toStringAsFixed(2)}"),
        10.ph,
        _row("Shipping", "€${shipping.toStringAsFixed(2)}"),
        10.ph,
        const Divider(),
        10.ph,
        _row("Estimated Total", "€${est.toStringAsFixed(2)}", bold: true),
      ],
    );
  }

  Widget _row(String l, String r, {bool bold = false}) => Row(
        children: [
          Text(l, style: AppTextStyles.getLato(13, bold ? 6.weight : 4.weight)),
          const Spacer(),
          Text(r,
              style: AppTextStyles.getLato(
                  bold ? 22 : 15, bold ? 7.weight : 5.weight)),
        ],
      );
}

Widget buildCheckboxWithLabel({
  required bool value,
  required String label,
  required ValueChanged<bool?> onChanged,
}) {
  return Row(
    children: [
      Checkbox(
        value: value,
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
        onChanged: onChanged,
      ),
      Expanded(
        child: Text(
          label,
          style: AppTextStyles.getLato(13, 4.weight),
        ),
      ),
    ],
  );
}
