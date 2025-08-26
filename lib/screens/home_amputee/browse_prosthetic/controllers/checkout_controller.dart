// lib/screens/shop/controllers/checkout_controller.dart
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final step = 1.obs; // 1=Shipping, 2=Payment

  // Shipping form
  final fullName = "".obs;
  final address1 = "".obs;
  final country = "".obs;
  final city = "".obs;
  final state = "".obs;
  final postal = "".obs;

  final shippingOption = "Standard Shipping - €15.00".obs;

  // Payment
  final method = "Visa".obs;
  final cardName = "".obs;
  final cardNumber = "".obs;
  final expiry = "".obs;
  final cvc = "".obs;

  bool get shippingValid =>
      fullName.isNotEmpty &&
      address1.isNotEmpty &&
      country.isNotEmpty &&
      city.isNotEmpty &&
      state.isNotEmpty &&
      postal.isNotEmpty;

  bool get paymentValid =>
      method.isNotEmpty &&
      cardName.isNotEmpty &&
      cardNumber.value.length >= 12 &&
      expiry.isNotEmpty &&
      cvc.value.length >= 3;

  void next() => step.value = 2;
  void back() => step.value = 1;
}
