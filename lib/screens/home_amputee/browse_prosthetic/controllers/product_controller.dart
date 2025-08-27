// lib/screens/shop/controllers/product_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';

class ProductController extends GetxController {
  // --- Categories ---
  RxList<String> selectedCategories = <String>[].obs;

  // --- Use-Cases ---
  RxList<String> selectedUseCases = <String>[].obs;

  // --- Brands ---
  RxList<String> selectedBrands = <String>[].obs;

  // --- Ratings ---
  RxList<String> selectedRatings = <String>[].obs;

  // --- Price Range ---
// --- Price Range ---
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 1000.0.obs;
  Rx<RangeValues> priceRange = const RangeValues(0, 1000).obs;
  void updatePriceRange(RangeValues values) {
    priceRange.value = values; // make it reactive
    minPrice.value = values.start;
    maxPrice.value = values.end;
  }

  void toggleCategory(String value) => selectedCategories.contains(value)
      ? selectedCategories.remove(value)
      : selectedCategories.add(value);

  void toggleUseCase(String value) => selectedUseCases.contains(value)
      ? selectedUseCases.remove(value)
      : selectedUseCases.add(value);

  void toggleBrand(String value) => selectedBrands.contains(value)
      ? selectedBrands.remove(value)
      : selectedBrands.add(value);

  void toggleRatings(String value) => selectedRatings.contains(value)
      ? selectedRatings.remove(value)
      : selectedRatings.add(value);

  void applyFilters() {
    Get.back(result: {
      "categories": selectedCategories,
      "useCases": selectedUseCases,
      "brands": selectedBrands,
      "ratings": selectedRatings,
      "minPrice": minPrice.value,
      "maxPrice": maxPrice.value,
    });
  }

  final products = <Map<String, dynamic>>[
    {
      "id": 1,
      "image": Assets.pngIconsLegTransparent,
      "type": "Lightweight Running Leg",
      "amputation": "Lower Limb • Transtibial",
      "price": "€520.00",
      "vendor": "ActiveProsthetics",
      "rating": 4.5,
      "reviewsCount": 120,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Focuses on rehabilitation and mobility training. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "compatibility":
          "Compatible with standard socket bases and common pyramid adapters.",
      "warranty":
          "2-year limited warranty covering defects in material and workmanship.",
    },
    {
      "id": 2,
      "image": Assets.pngIconsHandTransparent,
      "type": "Advanced Bionic Hand",
      "amputation": "Upper Limb • Transradial",
      "price": "€280.00",
      "vendor": "ActiveProsthetics",
      "rating": 4.7,
      "reviewsCount": 86,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Focuses on rehabilitation and mobility training. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "compatibility": "Myoelectric compatible; consult vendor for EMG specs.",
      "warranty": "3-year coverage incl. controller board & motor assembly.",
    },
    {
      "id": 3,
      "image": Assets.pngIconsHandTransparent,
      "type": "Carbon Fiber Prosthetic Arm",
      "amputation": "Upper Limb • Transhumeral",
      "price": "€980.00",
      "vendor": "ComfortFit",
      "rating": 4.6,
      "reviewsCount": 142,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Focuses on rehabilitation and mobility training. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "compatibility": "Compatible with body-powered & hybrid control systems.",
      "warranty": "2-year structural warranty.",
    },
    {
      "id": 4,
      "image": Assets.pngIconsLegTransparent,
      "type": "Energy-Return Prosthetic Foot",
      "amputation": "Lower Limb • Transtibial",
      "price": "€430.00",
      "vendor": "AquaTech",
      "rating": 4.4,
      "reviewsCount": 99,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Focuses on rehabilitation and mobility training. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "compatibility": "Standard pyramid adapter system supported.",
      "warranty": "18-month limited warranty.",
    },
    {
      "id": 5,
      "image": Assets.pngIconsLegTransparent,
      "type": "Microprocessor Knee",
      "amputation": "Lower Limb • Transfemoral",
      "price": "€200.00",
      "vendor": "MobilityPlus",
      "rating": 4.8,
      "reviewsCount": 65,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Focuses on rehabilitation and mobility training. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "compatibility": "Compatible with modular lower limb prosthetics.",
      "warranty": "3-year warranty including electronics.",
    },
    {
      "id": 6,
      "image": Assets.pngIconsHandTransparent,
      "type": "Silicone Socket Liner",
      "amputation": "Universal",
      "price": "€120.00",
      "vendor": "ActiveProsthetics",
      "rating": 4.3,
      "reviewsCount": 210,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Focuses on rehabilitation and mobility training. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "compatibility": "Fits most transtibial & transfemoral socket systems.",
      "warranty": "6-month durability guarantee.",
    },
    {
      "id": 7,
      "image": Assets.pngIconsHandTransparent,
      "type": "Pediatric Prosthetic Leg",
      "amputation": "Lower Limb • Pediatric",
      "price": "€450.00",
      "vendor": "ActiveProsthetics",
      "rating": 4.6,
      "reviewsCount": 52,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Focuses on rehabilitation and mobility training. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "compatibility": "Adjustable socket compatibility for growing children.",
      "warranty": "1-year warranty with growth adjustments.",
    },
    {
      "id": 8,
      "image": Assets.pngIconsLegTransparent,
      "type": "Myoelectric Prosthetic Arm",
      "amputation": "Upper Limb • Transradial/Transhumeral",
      "price": "€450.00",
      "vendor": "ActiveProsthetics",
      "rating": 4.7,
      "reviewsCount": 73,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Focuses on rehabilitation and mobility training. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "compatibility":
          "Compatible with EMG sensors and advanced socket systems.",
      "warranty": "3-year manufacturer warranty.",
    },
  ].obs;
  var selectedSize = "".obs;

  void setSize(String size) {
    selectedSize.value = size;
  }

  // Filtering / searching
  final query = "".obs;
  final fromDate = Rx<DateTime?>(null);
  final toDate = Rx<DateTime?>(null);

  // Detail selections
  final qty = 1.obs;

  void incQty() => qty.value++;
  void decQty() => qty.value = qty.value > 1 ? qty.value - 1 : 1;

  List<Map<String, dynamic>> get filtered {
    final q = query.value.trim().toLowerCase();

    var list = products.where((p) {
      // --- Search ---
      if (q.isNotEmpty &&
          !(p["type"].toString().toLowerCase().contains(q) ||
              p["amputation"].toString().toLowerCase().contains(q) ||
              p["vendor"].toString().toLowerCase().contains(q))) {
        return false;
      }

      // --- Category ---
      if (selectedCategories.isNotEmpty &&
          !selectedCategories.contains("All Categories")) {
        // Example: category is inferred from "amputation"
        final category = p["amputation"].toString().toLowerCase();
        if (!selectedCategories
            .any((c) => category.contains(c.toLowerCase()))) {
          return false;
        }
      }

      // --- Use Case ---
      if (selectedUseCases.isNotEmpty &&
          !selectedUseCases.contains("All Use Cases")) {
        final about = p["about"].toString().toLowerCase();
        if (!selectedUseCases.any((u) => about.contains(u.toLowerCase()))) {
          return false;
        }
      }

      // --- Brands ---
      if (selectedBrands.isNotEmpty && !selectedBrands.contains("All Brands")) {
        final vendor = p["vendor"].toString().toLowerCase();
        if (!selectedBrands.any((b) => vendor.contains(b.toLowerCase()))) {
          return false;
        }
      }

      // --- Ratings ---
      if (selectedRatings.isNotEmpty) {
        final allowed = selectedRatings
            .map((e) => double.tryParse(e.replaceAll(".0", "")) ?? 0)
            .toList();
        if (!allowed.any((min) =>
            (p["rating"] as double) >= min &&
            (p["rating"] as double) < min + 1)) {
          return false;
        }
      }

      // --- Price ---
      final price = double.tryParse(
              p["price"].toString().replaceAll("€", "").replaceAll(",", "")) ??
          0;
      if (price < minPrice.value || price > maxPrice.value) {
        return false;
      }

      return true;
    }).toList();

    return list;
  }
}
