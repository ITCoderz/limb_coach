// lib/screens/shop/controllers/product_controller.dart
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';

class ProductController extends GetxController {
  // Product catalog (mock)
  final products = <Map<String, dynamic>>[
    {
      "id": 1,
      "image": Assets.pngIconsLegTransparent,
      "type": "Lightweight Running Leg",
      "amputation": "Lower Limb • Transtibial",
      "price": "€520.00",
      "vendor": "ProV Prosthetics",
      "rating": 4.5,
      "reviewsCount": 120,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Lightweight running leg engineered for control and performance on tracks & roads.",
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
      "price": "€1,280.00",
      "vendor": "NeuroGrip",
      "rating": 4.7,
      "reviewsCount": 86,
      "sizes": ["Small", "Medium", "Large"],
      "about": "Multi-grip myoelectric hand with customizable patterns.",
      "compatibility": "Myoelectric compatible; consult vendor for EMG specs.",
      "warranty": "3-year coverage incl. controller board & motor assembly.",
    },
    {
      "id": 3,
      "image": Assets.pngIconsHandTransparent,
      "type": "Carbon Fiber Prosthetic Arm",
      "amputation": "Upper Limb • Transhumeral",
      "price": "€980.00",
      "vendor": "FlexTech Ortho",
      "rating": 4.6,
      "reviewsCount": 142,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Durable carbon-fiber prosthetic arm designed for strength and daily use.",
      "compatibility": "Compatible with body-powered & hybrid control systems.",
      "warranty": "2-year structural warranty.",
    },
    {
      "id": 4,
      "image": Assets.pngIconsLegTransparent,
      "type": "Energy-Return Prosthetic Foot",
      "amputation": "Lower Limb • Transtibial",
      "price": "€430.00",
      "vendor": "Stride Dynamics",
      "rating": 4.4,
      "reviewsCount": 99,
      "sizes": ["Small", "Medium", "Large"],
      "about": "High-energy return foot optimized for walking & light jogging.",
      "compatibility": "Standard pyramid adapter system supported.",
      "warranty": "18-month limited warranty.",
    },
    {
      "id": 5,
      "image": Assets.pngIconsLegTransparent,
      "type": "Microprocessor Knee",
      "amputation": "Lower Limb • Transfemoral",
      "price": "€3,200.00",
      "vendor": "BioMotion",
      "rating": 4.8,
      "reviewsCount": 65,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Intelligent microprocessor knee with stumble recovery & adaptive motion.",
      "compatibility": "Compatible with modular lower limb prosthetics.",
      "warranty": "3-year warranty including electronics.",
    },
    {
      "id": 6,
      "image": Assets.pngIconsHandTransparent,
      "type": "Silicone Socket Liner",
      "amputation": "Universal",
      "price": "€120.00",
      "vendor": "OrthoComfort",
      "rating": 4.3,
      "reviewsCount": 210,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Medical-grade silicone liner for secure fit and reduced skin friction.",
      "compatibility": "Fits most transtibial & transfemoral socket systems.",
      "warranty": "6-month durability guarantee.",
    },
    {
      "id": 7,
      "image": Assets.pngIconsHandTransparent,
      "type": "Pediatric Prosthetic Leg",
      "amputation": "Lower Limb • Pediatric",
      "price": "€450.00",
      "vendor": "KidzMotion",
      "rating": 4.6,
      "reviewsCount": 52,
      "sizes": ["Small", "Medium", "Large"],
      "about": "Lightweight prosthetic leg designed specifically for children.",
      "compatibility": "Adjustable socket compatibility for growing children.",
      "warranty": "1-year warranty with growth adjustments.",
    },
    {
      "id": 8,
      "image": Assets.pngIconsLegTransparent,
      "type": "Myoelectric Prosthetic Arm",
      "amputation": "Upper Limb • Transradial/Transhumeral",
      "price": "€2,450.00",
      "vendor": "NeuroFlex Systems",
      "rating": 4.7,
      "reviewsCount": 73,
      "sizes": ["Small", "Medium", "Large"],
      "about":
          "Advanced myoelectric arm with adaptive grip strength and smooth motion.",
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
  final selectedRatings = <String>[].obs;
  final fromDate = Rx<DateTime?>(null);
  final toDate = Rx<DateTime?>(null);

  // Detail selections
  final qty = 1.obs;

  void incQty() => qty.value++;
  void decQty() => qty.value = qty.value > 1 ? qty.value - 1 : 1;

  List<Map<String, dynamic>> get filtered {
    final q = query.value.trim().toLowerCase();
    var list = products.where((p) {
      if (q.isEmpty) return true;
      return p["type"].toString().toLowerCase().contains(q) ||
          p["amputation"].toString().toLowerCase().contains(q);
    }).toList();

    if (selectedRatings.isNotEmpty) {
      final allowed = selectedRatings
          .map((e) => double.tryParse(e.replaceAll(".0", "")) ?? 0)
          .toList();
      list = list
          .where((p) => allowed.any((min) =>
              (p["rating"] as double) >= min &&
              (p["rating"] as double) < min + 1))
          .toList();
    }
    // (Dates would filter by product meta if present)
    return list;
  }
}
