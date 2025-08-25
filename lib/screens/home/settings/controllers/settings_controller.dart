import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Language
  var selectedLanguage = "English (USA)".obs;

  // Notification toggles
  var newMessagePatient = true.obs;
  var newPatientRequest = true.obs;
  var patientSharesFile = true.obs;

  var appointmentReminders = true.obs;
  var newBookingRequest = false.obs;
  var bookingRequestActioned = true.obs;

  var newReviewReceived = true.obs;
  var contentEngagement = true.obs;
  var platformAnnouncements = false.obs;

  // FAQ expansion tracking
  var expandedFaq = RxnInt();
}
