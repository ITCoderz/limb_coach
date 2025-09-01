import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home_professional/settings/controllers/settings_controller.dart';
import 'package:mylimbcoach/screens/welcome/controllers/welcome_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class NotificationSettingsScreen extends StatelessWidget {
  final c = Get.find<SettingsController>();

  Widget _switch(String title, RxBool value) {
    return Obx(() => Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.borderColor, width: 0.5)),
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.getLato(14, FontWeight.w400),
                ),
              ),
              Transform.scale(
                scale: 0.7, // adjust between 0.5 - 1.0 for size
                child: CupertinoSwitch(
                  value: value.value,
                  activeColor: AppColors.primaryColor,
                  onChanged: (val) => value.value = val,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Notification Settings"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Get.find<UserTypeController>().isAmputee()
            ? ListView(
                children: [
                  _switch("Order Updates", c.newMessagePatient),
                  _switch("Consultation Reminders", c.newPatientRequest),
                  _switch("Forum Activity", c.patientSharesFile),
                  _switch("App Announcement", c.newBookingRequest),
                ],
              )
            : ListView(
                children: [
                  20.ph,
                  Text("Patient & Messaging",
                      style: AppTextStyles.getLato(16, FontWeight.w600)),
                  10.ph,
                  _switch("New Message from a Patient", c.newMessagePatient),
                  _switch("New Patient Request", c.newPatientRequest),
                  _switch("Patient Shares a File", c.patientSharesFile),
                  20.ph,
                  Text("Consultation & Scheduling",
                      style: AppTextStyles.getLato(16, FontWeight.w600)),
                  10.ph,
                  _switch("Appointment Reminders", c.appointmentReminders),
                  _switch("New Booking Request", c.newBookingRequest),
                  _switch("Booking Request Actioned", c.bookingRequestActioned),
                  20.ph,
                  Text("App & Content",
                      style: AppTextStyles.getLato(16, FontWeight.w600)),
                  10.ph,
                  _switch("New Review Received", c.newReviewReceived),
                  _switch("Content Engagement", c.contentEngagement),
                  _switch("Platform Announcements", c.platformAnnouncements),
                ],
              ),
      ),
    );
  }
}
