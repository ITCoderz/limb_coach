import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailabilityController extends GetxController {
  var selectedDate = DateTime.now().obs;

  var allSlots = <String>[
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
    "06:00 PM",
    "07:00 PM",
    "08:00 PM",
  ].obs;

  // Only these are available initially
  var availableSlots = <String>[
    "09:00 AM",
    "10:00 AM",
    "12:00 PM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "05:00 PM",
    "07:00 PM",
  ].obs;

  var selectedConsultation = "Standard Consultation".obs;

  var consultationPrices = {
    "Standard Consultation": 20.0,
    "Follow Up": 10.0,
    "In-Person Visit": 100.0,
    "Video Call": 15.0,
  }.obs;

  final priceControllers = <String, TextEditingController>{};

  @override
  void onInit() {
    super.onInit();
    // initialize text controllers
    consultationPrices.forEach((key, value) {
      priceControllers[key] =
          TextEditingController(text: value.toStringAsFixed(2));
    });
  }

  @override
  void onClose() {
    // dispose controllers
    for (final c in priceControllers.values) {
      c.dispose();
    }
    super.onClose();
  }

  // ✅ Update price when user edits
  void updatePrice(String type, String val) {
    consultationPrices[type] =
        double.tryParse(val) ?? consultationPrices[type]!;
  }

  // ✅ Helper to toggle slot
  void removeFromAvailable(String slot) {
    availableSlots.remove(slot);
  }

  void addToAvailable(String slot) {
    if (!availableSlots.contains(slot)) {
      availableSlots.add(slot);
      availableSlots.sort(
        (a, b) => allSlots.indexOf(a).compareTo(allSlots.indexOf(b)),
      ); // keep order
    }
  }

  void saveChanges() {
    // sync controllers back to map
    consultationPrices.forEach((type, _) {
      final text = priceControllers[type]?.text ?? "";
      consultationPrices[type] =
          double.tryParse(text) ?? consultationPrices[type]!;
    });
    print("Saved prices: $consultationPrices");
    Get.back();
  }
}
