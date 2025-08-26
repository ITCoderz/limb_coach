import 'package:get/get.dart';
import 'package:mylimbcoach/models/notification_model.dart';

/// 🔹 Controller with GetX
class NotificationsController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyNotifications();
  }

  void loadDummyNotifications() {
    notifications.value = [
      NotificationModel(
        title: "Profile Verification Status!",
        message:
            "Great News! Your My Limb Coach professional profile has been verified and is now live!",
        timeAgo: "15 Min Ago",
      ),
      NotificationModel(
        title: "New Consultation Request!",
        message:
            "New Appointment Request from Eion Morgan for July 25, 2025 | 12:00 PM",
        timeAgo: "1 Hour Ago",
        isConsultationRequest: true,
      ),
      NotificationModel(
        title: "New Review Received!",
        message: "You’ve received a new review on your profile/content",
        timeAgo: "2 Hours Ago",
      ),
      NotificationModel(
        title: "Consultation Confirmed!",
        message:
            "Appointment with Rameen Zafar on July 20, 2025 | 12:00 PM is confirmed!",
        timeAgo: "5 Days Ago",
      ),
      NotificationModel(
        title: "Consultation Reminder!",
        message: "Your consultation with Rameen Zafar is in next 15 Minutes.",
        timeAgo: "5 Days Ago",
      ),
    ];
  }

  List<NotificationModel> get filteredNotifications {
    if (searchText.value.isEmpty) return notifications;
    return notifications
        .where((n) =>
            n.title.toLowerCase().contains(searchText.value.toLowerCase()) ||
            n.message.toLowerCase().contains(searchText.value.toLowerCase()))
        .toList();
  }
}
