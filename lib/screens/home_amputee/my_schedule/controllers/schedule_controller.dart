import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  // Calendar
  Rx<DateTime> selectedDate = DateTime.now().obs;
// Already present
  RxSet<String> repeatDays = <String>{}.obs;

  // Time slots
  final availableSlots = <String>[
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
  RxString selectedTime = "".obs;
  void setTime(String v) => selectedTime.value = v;

  // Event store (very simple for demo)
  // each event: {title,type,date,time,with,location,link,notes,duration,status}
  RxList<Map<String, dynamic>> events = <Map<String, dynamic>>[
    {
      "title": "Prosthetist Appointment",
      "type": "Consultation",
      "date": DateTime.now(),
      "time": "10:00 AM",
      "with": "Dr. Smith (Video Call)",
      "location": "Online",
      "link": "https://zoom.us/j/123456789",
      "notes": "Discuss new prosthetic socket",
      "duration": "30 Min",
      "status": "upcoming"
    },
    {
      "title": "Morning Walking Routine",
      "type": "Training Plan",
      "date": DateTime.now(),
      "time": "05:00 PM",
      "with": "Self",
      "location": "Park",
      "link": "",
      "notes": "Focus on cadence",
      "duration": "30 Min",
      "status": "upcoming"
    },
  ].obs;

  // Filtering events for selected day
  List<Map<String, dynamic>> eventsForDay(DateTime day) {
    return events.where((e) {
      final d = e["date"] as DateTime;
      return d.year == day.year && d.month == day.month && d.day == day.day;
    }).toList();
  }

  // Radios & selections (used across add/edit screens)
  RxString consultationType = "Video Call".obs; // Video Call / In-Person Visit
  RxString reminderWhen = "At Time of Event".obs; // many options in UI
  RxString frequency = "Once".obs; // Once / Daily / Weekly / Specific Days

  // Pricing-type example radio (you provided snippet)
  RxString selectedPricingType = "hour".obs;
  final priceControllers = {
    "Per Hour": TextEditingController(text: "50"),
  };

  // Media quick actions
  Rx<File?> pickedPhoto = Rx<File?>(null);
  Rx<File?> pickedVideo = Rx<File?>(null);

  // Professionals (for Add Consultation list)
  final professionals = <Map<String, dynamic>>[
    {
      "name": "Dr. Emily White",
      "spec": "Prosthetist",
      "reviews": "500 Reviews"
    },
    {"name": "Dr. John Smith", "spec": "Orthotist", "reviews": "120 Reviews"},
    {
      "name": "Dr. Mark Hay",
      "spec": "Rehab Specialist",
      "reviews": "80 Reviews"
    },
    {"name": "Dr. Susan Pat", "spec": "Prosthetist", "reviews": "210 Reviews"},
    {"name": "Dr. Karen Davies", "spec": "PT", "reviews": "60 Reviews"},
  ].obs;

  // Create/Update helpers
  void addEvent(Map<String, dynamic> e) {
    events.add(e);
  }

  void updateEvent(int index, Map<String, dynamic> e) {
    events[index] = e;
  }

  void deleteEvent(int index) {
    events.removeAt(index);
  }
}
