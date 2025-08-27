// consultation_controller.dart
import 'package:get/get.dart';

class AmputeeConsultationController extends GetxController {
  // stepper
  final step = 0.obs;

  // search + filters
  final query = "".obs;
  final selectedCategories = <String>[].obs;
  final selectedRatings = <String>[].obs;

  /// Slot Booking
  var selectedDate = DateTime.now().obs;
  var selectedTime = "09:00 AM".obs;
  var addToCalendar = false.obs;

  void toggleCalendar(bool? value) {
    addToCalendar.value = value ?? false;
  }

  /// Dummy slots
  var availableSlots = <String>[
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
    "06:00 PM",
    "07:00 PM",
    "08:00 PM",
  ].obs;

  /// Booking Options
  var consultationType = "Video Call".obs;
  var reminder = "At Time of Event".obs;
  var note = "".obs;
  // data (include category)
  final doctors = <Map<String, dynamic>>[
    {
      "name": "Dr. Emily White",
      "rating": 5.0,
      "reviews": 120,
      "category": "Prosthetists",
    },
    {
      "name": "Dr. John Smith",
      "rating": 4.8,
      "reviews": 89,
      "category": "Orthotists",
    },
    {
      "name": "Dr. Mark Hay",
      "rating": 3.6,
      "reviews": 56,
      "category": "Physical Therapists / Physiotherapists",
    },
  ];

  // computed
  List<Map<String, dynamic>> get filteredDoctors {
    final q = query.value.toLowerCase();

    return doctors.where((d) {
      final nameMatch = d["name"].toString().toLowerCase().contains(q);

      // category logic
      final category = (d["category"] ?? "").toString();
      final categoryMatch = selectedCategories.isEmpty ||
          selectedCategories.contains("All Categories") ||
          selectedCategories.contains(category);

      // rating logic
      final rating = (d["rating"] as num?)?.toDouble() ?? 0.0;
      final ratingMatch = selectedRatings.isEmpty ||
          selectedRatings.any((r) {
            final min = double.tryParse(r) ?? 0.0;
            return rating >= min;
          });

      return nameMatch && categoryMatch && ratingMatch;
    }).toList();
  }

  // actions
  void setFilters(List<String> categories, List<String> ratings) {
    selectedCategories.assignAll(categories);
    selectedRatings.assignAll(ratings);
  }

  void toggleCategory(String cat) {
    if (cat == "All Categories") {
      selectedCategories
        ..clear()
        ..add("All Categories");
      return;
    }
    if (selectedCategories.contains(cat)) {
      selectedCategories.remove(cat);
    } else {
      selectedCategories
        ..add(cat)
        ..remove("All Categories");
    }
  }

  void toggleRating(String r) {
    selectedRatings.contains(r)
        ? selectedRatings.remove(r)
        : selectedRatings.add(r);
  }

  // booking stuff (unchanged)
  final selectedDoctor = Rxn<Map<String, dynamic>>();

  void selectDoctor(Map<String, dynamic> doctor) {
    selectedDoctor.value = doctor;
    // step.value = 1;
  }

  var selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void setDate(DateTime d) => selectedDate.value = d;
  void setTime(String t) => selectedTime.value = t;

  void nextStep() {
    if (step.value < 2) step.value++;
  }

  void prevStep() {
    if (step.value > 0) step.value--;
  }

  bool get canConfirm =>
      selectedDoctor.value != null && selectedTime.value.isNotEmpty;
}
