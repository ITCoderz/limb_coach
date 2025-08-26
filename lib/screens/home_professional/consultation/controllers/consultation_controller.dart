import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/widgets/custom_snackbar.dart';

class Consultation {
  final String id;
  final String patientName;
  final String type;
  final String image;
  late final DateTime dateTime;
  final String mode; // "Video Call", "In-Person", "Voice Call"
  final String notes;
  final String link;

  Consultation({
    required this.id,
    required this.patientName,
    required this.type,
    required this.image,
    required this.dateTime,
    required this.mode,
    this.notes = "",
    this.link = "",
  });
}

class ConsultationController extends GetxController {
  var todayConsultations = <Consultation>[].obs;
  var upcomingConsultations = <Consultation>[].obs;

  var selectedTab = 0.obs; // 0 = Today, 1 = Upcoming
  var searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();

    // Mock Data
    todayConsultations.assignAll([
      Consultation(
        id: "1",
        patientName: "Elon Morgan",
        type: "Video Call",
        image: Assets.pngIconsDp,
        dateTime: DateTime(2025, 7, 31, 10, 0),
        mode: "Morning",
        link: "https://videocall.example.com/join/meeting1234567890",
        notes: "Discuss about the precautions",
      ),
      Consultation(
        id: "2",
        patientName: "Rameen Zafar",
        type: "In-Person Visit",
        image: Assets.pngIconsDp2,
        dateTime: DateTime(2025, 7, 31, 15, 0),
        mode: "Afternoon",
        link: "https://videocall.example.com/join/meeting1234567890",
        notes: "Discuss about the precautions",
      ),
    ]);

    upcomingConsultations.assignAll([
      Consultation(
        id: "3",
        patientName: "Juliet Johns",
        image: Assets.pngIconsDp,
        type: "Voice Call",
        dateTime: DateTime(2025, 8, 1, 10, 0),
        mode: "Morning",
        link: "https://videocall.example.com/join/123",
        notes: "Discuss about the precautions",
      ),
      Consultation(
        id: "4",
        patientName: "Amiya Yusha",
        image: Assets.pngIconsDp2,
        type: "In-Person Visit",
        dateTime: DateTime(2025, 8, 1, 15, 0),
        mode: "Afternoon",
      ),
    ]);
  }

  void cancelConsultation(String id) {
    todayConsultations.removeWhere((c) => c.id == id);
    upcomingConsultations.removeWhere((c) => c.id == id);
    Get.back();
  }

  void rescheduleConsultation(String id, DateTime newDate) {
    // Search in todayConsultations
    final todayIndex = todayConsultations.indexWhere((e) => e.id == id);
    if (todayIndex != -1) {
      todayConsultations[todayIndex].dateTime = newDate;
      update();
      return;
    }

    // Search in upcomingConsultations
    final upcomingIndex = upcomingConsultations.indexWhere((e) => e.id == id);
    if (upcomingIndex != -1) {
      upcomingConsultations[upcomingIndex].dateTime = newDate;
      update();
      return;
    }
  }

  var availableSlots = <String>[
    "09:00 AM",
    "10:00 AM",
    "12:00 PM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "05:00 PM",
    "07:00 PM",
    "08:00 PM",
  ].obs;
  // List of consultations (dummy for now)
  var consultations = <Map<String, dynamic>>[].obs;

  // Reschedule fields
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  RxString selectedSlot = "".obs;
  TextEditingController reasonController = TextEditingController();

  // Method to select a date
  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  // Method to select a slot
  void setSlot(String slot) {
    selectedSlot.value = slot;
  }

  // Method to send reschedule request
  void sendRescheduleRequest(String consultationId) {
    if (selectedDate.value == null || selectedSlot.isEmpty) {
      AppSnackbar.error("Error", "Please select date and slot");
      return;
    }

    final formattedDate =
        DateFormat("MMMM dd, yyyy | hh:mm a").format(selectedDate.value!);

    final requestData = {
      "consultationId": consultationId,
      "newDate": formattedDate,
      "slot": selectedSlot.value,
      "reason": reasonController.text,
    };

    // For now just log/print (later integrate with API)
    print("📩 Reschedule Request: $requestData");

    // Clear after sending
    selectedDate.value = null;
    selectedSlot.value = "";
    reasonController.clear();
    Get.back();
    AppSnackbar.success("Success", "Reschedule request sent successfully");
  }
}
