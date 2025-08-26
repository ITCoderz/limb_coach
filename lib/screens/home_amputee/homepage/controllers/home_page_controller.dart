import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';

class AmputeeDashboardController extends GetxController {
  // Consultations
  var recommendedProducts = [
    {
      "type": "Prosthetic Leg",
      "image": Assets.pngIconsProstheticLeg,
      "amputation": "Lightweight Running Leg",
      "price": "€520.00"
    },
    {
      "type": "Bionic Hand",
      "image": Assets.pngIconsBionicHand,
      "amputation": "Advanced Bionic Hand",
      "price": "€520.00"
    },
  ].obs;

  var consultations = [
    {
      "name": "Eion Morgan",
      "appointment": "Prosthetist Appointment",
      "image": Assets.pngIconsDp,
      "type": "Video Call",
      "amputation": "Wrist Disarticulation",
      "date": "July 31, 2025 | 10:00 AM (Morning)"
    },
  ].obs;
  // Quick Actions
  final communityHub = [
    {"title": "New Amputee Support", "type": "Trend", "replies": "50+ Replies"},
    {"title": "New Amputee Support", "type": "Recent", "replies": "New Post"},
    {"title": "New Amputee Support", "type": "Trend", "replies": "50+ Replies"},
    {"title": "New Amputee Support", "type": "Recent", "replies": "New Post"},
  ];
  void startConsultation() {
    Get.snackbar("Action", "Start Consultation Clicked");
  }

  void publishContent() {
    Get.snackbar("Action", "Publish Content Clicked");
  }

  void myPatients() {
    Get.snackbar("Action", "My Patients Clicked");
  }

  void cancelConsultation(int index) {
    recommendedProducts.removeAt(index);
  }
}
