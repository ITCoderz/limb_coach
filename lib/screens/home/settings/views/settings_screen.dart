import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home/settings/controllers/settings_controller.dart';
import 'package:mylimbcoach/screens/home/settings/views/about_screen.dart';
import 'package:mylimbcoach/screens/home/settings/views/contact_support_screen.dart';
import 'package:mylimbcoach/screens/home/settings/views/faq_screen.dart';
import 'package:mylimbcoach/screens/home/settings/views/language_screen.dart';
import 'package:mylimbcoach/screens/home/settings/views/notification_settings_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class SettingsScreen extends StatelessWidget {
  final c = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Settings"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("App Settings:",
                style: AppTextStyles.getLato(16, FontWeight.w600)),
            10.ph,
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.borderColor, width: 0.5)),
              child: Column(
                children: [
                  _buildTile("Language",
                      onTap: () => Get.to(() => LanguageScreen())),
                  _buildTile("Notification Settings",
                      onTap: () => Get.to(() => NotificationSettingsScreen())),
                  _buildTile("About My Limb Coach",
                      onTap: () => Get.to(() => AboutScreen())),
                ],
              ),
            ),
            20.ph,
            Text("Help & Support:",
                style: AppTextStyles.getLato(16, FontWeight.w600)),
            10.ph,
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.borderColor, width: 0.5)),
              child: Column(
                children: [
                  _buildTile("Frequently Asked Questions",
                      onTap: () => Get.to(() => FAQScreen())),
                  _buildTile("Contact Support",
                      onTap: () => Get.to(() => ContactSupportScreen())),
                  _buildTile("Account Deletion",
                      onTap: () => _showDeleteDialog(context)),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () => _showLogoutDialog(context),
              child: Text(
                "Log Out",
                style: AppTextStyles.getLato(16, 6.weight, Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(String title, {VoidCallback? onTap}) {
    return ListTile(
      title: Text(title, style: AppTextStyles.getLato(14, FontWeight.w500)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showDeleteDialog(BuildContext context) {
    Get.dialog(AlertDialog(
      title: const Text("Account Deletion"),
      content: const Text(
          "Are you sure you want to delete this account permanently?"),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => {}, // handle delete
          child: const Text("Delete Account"),
        ),
      ],
    ));
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(AlertDialog(
      title: const Text("Log Out"),
      content: const Text("Are you sure you want to log out this account?"),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
        ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
          onPressed: () => {}, // handle logout
          child: const Text("Log Out"),
        ),
      ],
    ));
  }
}
