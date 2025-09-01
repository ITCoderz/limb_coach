import 'package:get/get.dart';

class MyConsultationController extends GetxController {
  // Tabs
  RxInt selectedTab = 0.obs; // 0 = upcoming, 1 = past
// Date filters
  Rx<DateTime?> filterFrom = Rx<DateTime?>(null);
  Rx<DateTime?> filterTo = Rx<DateTime?>(null);

  // Checkbox filters
  RxSet<String> selectedTypes = <String>{"All Type"}.obs; // default
  RxSet<String> selectedStatus = <String>{"All Status"}.obs; // default

  void toggleSelection(String label, RxSet<String> set, String allLabel) {
    if (set.contains(label)) {
      set.remove(label);
    } else {
      // If selecting "All"
      if (label == allLabel) {
        set.clear();
        set.add(allLabel);
      } else {
        set.add(label);
        set.remove(allLabel); // remove "All" if another selected
      }
    }

    // If nothing left, fallback to "All"
    if (set.isEmpty) {
      set.add(allLabel);
    }
  }

  void applyFilters() {
    print("Filter Types: $selectedTypes");
    print("Filter Status: $selectedStatus");
    print("Date Range: ${filterFrom.value} - ${filterTo.value}");
  }

  // Filter State
  RxString searchText = "".obs; // All, Completed, Pending

  // Consultation List
  RxList<Map<String, dynamic>> consultations = <Map<String, dynamic>>[
    {
      "title": "Prosthetist Appointment",
      "with": "Dr. Smith (Video Call)",
      "date": DateTime(2025, 7, 18, 10, 0),
      "status": "upcoming",
      "type": "Video Call",
      "link": "https://videocall.example.com/meeting/123456789",
      "notes": "Discuss new prosthetic socket",
      "duration": "30 Min",
      "resources": []
    },
    {
      "title": "Medication Review",
      "with": "Dr. Emily White (Phone Call)",
      "date": DateTime(2025, 7, 10, 10, 0),
      "status": "completed",
      "type": "Phone Call",
      "notes": "Reviewed dosage",
      "duration": "20 Min",
      "resources": []
    },
    {
      "title": "Gait Analysis",
      "with": "Dr. John Smith (Video Call)",
      "date": DateTime(2025, 7, 5, 10, 0),
      "status": "cancelled",
      "type": "Video Call",
      "notes": "Cancelled by patient",
      "duration": "30 Min",
      "resources": []
    },
  ].obs;

  // Filtered list
  List<Map<String, dynamic>> get upcomingConsultations =>
      consultations.where((e) => e["status"] == "upcoming").toList();

  List<Map<String, dynamic>> get pastConsultations =>
      consultations.where((e) => e["status"] != "upcoming").toList();

  void cancelConsultation(int index) {
    consultations[index]["status"] = "cancelled";
    consultations.refresh();
  }

  void markCompleted(int index) {
    consultations[index]["status"] = "completed";
    consultations.refresh();
  }
}
