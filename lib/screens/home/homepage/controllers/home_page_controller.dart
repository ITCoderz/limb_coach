import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';

class DashboardController extends GetxController {
  // Consultations
  var consultations = [
    {
      "name": "Eion Morgan",
      "image": Assets.pngIconsDp,
      "type": "Video Call",
      "amputation": "Wrist Disarticulation",
      "date": "July 31, 2025 | 10:00 AM (Morning)"
    },
    {
      "name": "Rameen Zafar",
      "image": Assets.pngIconsDp2,
      "type": "In-Person Visit",
      "amputation": "Quad Amputation",
      "date": "July 31, 2025 | 01:00 PM (Afternoon)"
    },
  ].obs;

  // Messages & Reviews
  var messages = [
    {
      "title": "New Message (1): Sarah J.",
      "desc": "Lorem ipsum dolor sit amet..."
    },
  ].obs;

  var reviews = [
    {
      "title": "New Review (1): Profile",
      "desc": "Lorem ipsum dolor sit amet..."
    },
  ].obs;

  // Trending posts
  var posts = [
    {
      "category": "Prosthetics",
      "title": "Understanding Prosthetic Liners",
      "desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
      "likes": "1.5k",
      "comments": "14",
      "shares": "200"
    }
  ].obs;

  // Quick Actions

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
    consultations.removeAt(index);
  }
}
