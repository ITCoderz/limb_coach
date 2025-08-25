import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home/settings/controllers/settings_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class NotificationSettingsScreen extends StatelessWidget {
  final c = Get.find<SettingsController>();

  Widget _switch(String title, RxBool value) {
    return Obx(() => SwitchListTile(
          title: Text(title, style: AppTextStyles.getLato(14, FontWeight.w500)),
          value: value.value,
          activeColor: AppColors.primaryColor,
          onChanged: (val) => value.value = val,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification Settings")),
      body: ListView(
        children: [
          Text("Patient & Messaging",
              style: AppTextStyles.getLato(16, FontWeight.w600)),
          _switch("New Message from a Patient", c.newMessagePatient),
          _switch("New Patient Request", c.newPatientRequest),
          _switch("Patient Shares a File", c.patientSharesFile),
          10.ph,
          Text("Consultation & Scheduling",
              style: AppTextStyles.getLato(16, FontWeight.w600)),
          _switch("Appointment Reminders", c.appointmentReminders),
          _switch("New Booking Request", c.newBookingRequest),
          _switch("Booking Request Actioned", c.bookingRequestActioned),
          10.ph,
          Text("App & Content",
              style: AppTextStyles.getLato(16, FontWeight.w600)),
          _switch("New Review Received", c.newReviewReceived),
          _switch("Content Engagement", c.contentEngagement),
          _switch("Platform Announcements", c.platformAnnouncements),
        ],
      ),
    );
  }
}
