// lib/screens/shop/controllers/cart_controller.dart
import 'package:get/get.dart';

class CartController extends GetxController {
  // Each item: {product, size, qty, priceNum}
  final items = <Map<String, dynamic>>[].obs;

  double get subtotal => items.fold(
      0.0, (s, it) => s + (it["priceNum"] as double) * (it["qty"] as int));

  void addToCart(Map<String, dynamic> product, String size, int qty) {
    final priceNum = double.tryParse(
            product["price"].toString().replaceAll(RegExp(r"[^\d.]"), "")) ??
        0;
    items.add(
        {"product": product, "size": size, "qty": qty, "priceNum": priceNum});
  }

  void removeAt(int i) => items.removeAt(i);
  void inc(int i) => items[i]["qty"] = (items[i]["qty"] as int) + 1;
  void dec(int i) {
    final q = (items[i]["qty"] as int);
    items[i]["qty"] = q > 1 ? q - 1 : 1;
    items.refresh();
  }

  void clear() => items.clear();
}
