import 'package:get/get.dart';

class MyPatientController extends GetxController {
  // Consultations
  var consultations = [
    {
      "name": "Eion Morgan",
      "type": "Video Call",
      "amputation": "Wrist Disarticulation",
      "date": "July 31, 2025 | 10:00 AM (Morning)"
    },
    {
      "name": "Rameen Zafar",
      "type": "In-Person Visit",
      "amputation": "Quad Amputation",
      "date": "July 31, 2025 | 01:00 PM (Afternoon)"
    },
  ].obs;
}
