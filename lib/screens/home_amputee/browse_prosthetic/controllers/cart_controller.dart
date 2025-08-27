import 'package:get/get.dart';

class CartController extends GetxController {
  final items = <Map<String, dynamic>>[].obs;
  final selectedIndexes = <int>[].obs; // track selected item indexes

  double get subtotal => selectedIndexes.fold(
        0.0,
        (s, i) =>
            s + (items[i]["priceNum"] as double) * (items[i]["qty"] as int),
      );

  bool get isAllSelected => selectedIndexes.length == items.length;

  void toggleItem(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
  }

  void toggleSelectAll() {
    if (isAllSelected) {
      selectedIndexes.clear();
    } else {
      selectedIndexes.assignAll(List.generate(items.length, (i) => i));
    }
  }

  void addToCart(Map<String, dynamic> product, String size, int qty) {
    final priceNum = double.tryParse(
            product["price"].toString().replaceAll(RegExp(r"[^\d.]"), "")) ??
        0;
    items.add({
      "product": product,
      "size": size,
      "qty": qty,
      "priceNum": priceNum,
    });
  }

  void removeAt(int i) {
    items.removeAt(i);
    selectedIndexes.remove(i);
  }

  void inc(int i) {
    items[i]["qty"] = (items[i]["qty"] as int) + 1;
    items.refresh(); // 🔥 Force UI update
  }

  void dec(int i) {
    final q = (items[i]["qty"] as int);
    items[i]["qty"] = q > 1 ? q - 1 : 1;
    items.refresh(); // 🔥 Also keep this
  }

  void clear() {
    items.clear();
    selectedIndexes.clear();
  }
}
