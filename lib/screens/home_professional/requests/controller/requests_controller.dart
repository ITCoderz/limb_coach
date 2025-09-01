import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/widgets/custom_snackbar.dart';

class RequestsConsultation {
  final String id;
  final String patientName;
  final String type;
  final String image;
  late final DateTime dateTime;
  final String mode; // "Video Call", "In-Person", "Voice Call"
  final String notes;
  final String link;
  final String status;

  RequestsConsultation({
    required this.id,
    required this.patientName,
    required this.type,
    required this.dateTime,
    required this.mode,
    required this.image,
    this.notes = "",
    this.link = "",
    this.status = "Completed",
  });
}

class RequestsController extends GetxController {
  var allConsultationsRequests = <RequestsConsultation>[].obs;
  var filteredConsultations = <RequestsConsultation>[].obs;

  var searchQuery = "".obs;
  var selectedStatuses = <String>[].obs; // ✅ filter by status
  var selectedTypes = <String>[].obs; // ✅ filter by type

  @override
  void onInit() {
    super.onInit();

    // Mock Data
    allConsultationsRequests.assignAll([
      RequestsConsultation(
        id: "1",
        image: Assets.pngIconsDp,
        patientName: "Elon Morgan",
        type: "Video Call",
        status: "Completed",
        dateTime: DateTime(2025, 7, 31, 10, 0),
        mode: "Morning",
        link: "https://videocall.example.com/join/meeting1234567890",
        notes: "Discuss about the precautions",
      ),
      RequestsConsultation(
        id: "2",
        patientName: "Rameen Zafar",
        image: Assets.pngIconsDp2,
        type: "In-Person Visit",
        status: "Pending",
        dateTime: DateTime(2025, 7, 31, 15, 0),
        mode: "Afternoon",
        link: "https://videocall.example.com/join/meeting1234567890",
        notes: "Discuss about the precautions",
      ),
      RequestsConsultation(
        id: "3",
        patientName: "Zafar",
        image: Assets.pngIconsDp,
        type: "In-Person Visit",
        status: "Pending",
        dateTime: DateTime(2025, 7, 31, 15, 0),
        mode: "Afternoon",
        link: "https://videocall.example.com/join/meeting1234567890",
        notes: "Discuss about the precautions",
      ),
    ]);

    // Initially all
    filteredConsultations.assignAll(allConsultationsRequests);

    // Listen to search
    ever(searchQuery, (_) => applyFilters());
  }

  void applyFilters() {
    var list = allConsultationsRequests.toList();

    // Search filter
    if (searchQuery.value.isNotEmpty) {
      list = list
          .where((c) => c.patientName
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    // Status filter
    if (selectedStatuses.isNotEmpty &&
        !selectedStatuses.contains("All Requests")) {
      list = list.where((c) => selectedStatuses.contains(c.status)).toList();
    }

    filteredConsultations.assignAll(list);
  }

  // 🔹 Update search
  void setSearch(String query) {
    searchQuery.value = query;
  }

  // 🔹 From FiltersScreen
  void setFilters(
    List<String> statuses,
  ) {
    selectedStatuses.assignAll(statuses);
    // selectedTypes.assignAll(types);
    applyFilters();
  }

  void cancelConsultation(String id) {
    allConsultationsRequests.removeWhere((c) => c.id == id);
    Get.back();
  }

  void acceptConsultation(String id) {
    int index = allConsultationsRequests.indexWhere((e) => e.id == id);
    if (index != -1) {
      allConsultationsRequests[index] = RequestsConsultation(
        id: allConsultationsRequests[index].id,
        image: allConsultationsRequests[index].image,
        patientName: allConsultationsRequests[index].patientName,
        type: allConsultationsRequests[index].type,
        dateTime: allConsultationsRequests[index].dateTime,
        mode: allConsultationsRequests[index].mode,
        notes: allConsultationsRequests[index].notes,
        link: allConsultationsRequests[index].link,
        status: "Completed", // ✅ update status
      );
      Get.back();
      AppSnackbar.success(
        "Success",
        "Consultation accepted successfully",
      );
    }
    // Initially all
    filteredConsultations.assignAll(allConsultationsRequests);

    // Listen to search
    ever(searchQuery, (_) => applyFilters());
  }

  void rescheduleConsultation(String id, DateTime newDate) {
    final index = allConsultationsRequests.indexWhere((e) => e.id == id);
    if (index != -1) {
      allConsultationsRequests[index].dateTime = newDate;
    }
    // Initially all
    filteredConsultations.assignAll(allConsultationsRequests);

    // Listen to search
    ever(searchQuery, (_) => applyFilters());
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
