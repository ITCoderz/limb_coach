import 'package:get/get.dart';
import 'package:mylimbcoach/models/notification_model.dart';

/// 🔹 Controller with GetX
class AmputeeNotificationsController extends GetxController {
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
        title: "New Order Confirmed!",
        message:
            "Your Order (Order ID: #12345) for Lightweight Running Leg has been shipped",
        timeAgo: "15 Min Ago",
      ),
      NotificationModel(
        title: "Consultation Reminder!",
        message:
            "This is your reminder that your video call session with Dr. Smith is in next 30 minutes",
        timeAgo: "1 Hour Ago",
        isConsultationRequest: true,
      ),
      NotificationModel(
        title: "New Reply!",
        message:
            "You’ve a New Reply in 'Device Maintenance’. User A replied to your post",
        timeAgo: "2 Hours Ago",
      ),
      NotificationModel(
        title: "New Order Confirmed!",
        message:
            "Your Order (Order ID: #12345) for Lightweight Running Leg has been shipped",
        timeAgo: "15 Min Ago",
      ),
      NotificationModel(
        title: "Consultation Reminder!",
        message:
            "This is your reminder that your video call session with Dr. Smith is in next 30 minutes",
        timeAgo: "1 Hour Ago",
        isConsultationRequest: true,
      ),
      NotificationModel(
        title: "New Reply!",
        message:
            "You’ve a New Reply in 'Device Maintenance’. User A replied to your post",
        timeAgo: "2 Hours Ago",
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
