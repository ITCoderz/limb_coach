/// 🔹 Notification Model
class NotificationModel {
  final String title;
  final String message;
  final String timeAgo;
  final bool isConsultationRequest;

  NotificationModel({
    required this.title,
    required this.message,
    required this.timeAgo,
    this.isConsultationRequest = false,
  });
}
