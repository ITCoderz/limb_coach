// lib/screens/shop/controllers/checkout_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final step = 1.obs; // 1=Shipping, 2=Payment

  // Text controllers
  final fullNameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final stateCtrl = TextEditingController();
  final postalCtrl = TextEditingController();
  final cardNameCtrl = TextEditingController();
  final cardNumberCtrl = TextEditingController();
  final expiryCtrl = TextEditingController();
  final cvcCtrl = TextEditingController();

  // Reactive values
  final country = "".obs;
  final city = "".obs;
  final shippingOption = "Standard Shipping - €15.00".obs;
  final method = "Credit Card".obs;
  var saveAddress = false.obs;
  var billingAddress = false.obs;

  // Form validation states
  final shippingValid = false.obs;
  final paymentValid = false.obs;

  void toggleSaveAddress(bool? value) {
    saveAddress.value = value ?? false;
    validateShipping();
  }

  void toggleBillingAddress(bool? value) {
    billingAddress.value = value ?? false;
    validatePayment();
  }

  void next() => step.value = 2;
  void back() => step.value = 1;

  // For binding UI directly (optional)
  final fullName = "".obs;
  final address1 = "".obs;
  final state = "".obs;
  final postal = "".obs;

  final cardName = "".obs;
  final cardNumber = "".obs;
  final expiry = "".obs;
  final cvc = "".obs;

  @override
  void onInit() {
    super.onInit();

    // Shipping form listeners
    fullNameCtrl.addListener(validateShipping);
    addressCtrl.addListener(validateShipping);
    stateCtrl.addListener(validateShipping);
    postalCtrl.addListener(validateShipping);

    // Payment form listeners
    cardNameCtrl.addListener(validatePayment);
    cardNumberCtrl.addListener(validatePayment);
    expiryCtrl.addListener(validatePayment);
    cvcCtrl.addListener(validatePayment);

    // Shipping validation
    everAll([fullName, address1, country, city, state, postal], (_) {
      shippingValid.value = fullName.value.isNotEmpty &&
          address1.value.isNotEmpty &&
          country.value.isNotEmpty &&
          city.value.isNotEmpty &&
          state.value.isNotEmpty &&
          postal.value.isNotEmpty;
    });

    // Payment validation
    everAll([method, cardName, cardNumber, expiry, cvc], (_) {
      paymentValid.value = method.value.isNotEmpty &&
          cardName.value.isNotEmpty &&
          _isValidCardNumber(cardNumber.value) &&
          _isValidExpiry(expiry.value) &&
          _isValidCVC(cvc.value);
    });
  }

  // 🔹 Card number: 16 digits with spaces like "0000 0000 0000 0000"
  bool _isValidCardNumber(String input) {
    final cleaned = input.replaceAll(" ", "");
    return RegExp(r'^[0-9]{16}$').hasMatch(cleaned);
  }

  // 🔹 Expiry: MM/YY (01-12 / 2-digit year)
  bool _isValidExpiry(String input) {
    final regex = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
    return regex.hasMatch(input);
  }

  // 🔹 CVC: 3–4 digits
  bool _isValidCVC(String input) {
    return RegExp(r'^[0-9]{3,4}$').hasMatch(input);
  }

  void validateShipping() {
    shippingValid.value = fullNameCtrl.text.isNotEmpty &&
        addressCtrl.text.isNotEmpty &&
        country.isNotEmpty &&
        city.isNotEmpty &&
        stateCtrl.text.isNotEmpty &&
        postalCtrl.text.isNotEmpty;
  }

  void validatePayment() {
    paymentValid.value = method.isNotEmpty &&
        cardNameCtrl.text.isNotEmpty &&
        cardNumberCtrl.text.length >= 12 &&
        expiryCtrl.text.isNotEmpty &&
        cvcCtrl.text.length >= 3;
  }

  @override
  void onClose() {
    // Dispose controllers
    fullNameCtrl.dispose();
    addressCtrl.dispose();
    stateCtrl.dispose();
    postalCtrl.dispose();
    cardNameCtrl.dispose();
    cardNumberCtrl.dispose();
    expiryCtrl.dispose();
    cvcCtrl.dispose();
    super.onClose();
  }
}
