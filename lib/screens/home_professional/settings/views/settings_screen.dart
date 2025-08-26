import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home_professional/settings/controllers/settings_controller.dart';
import 'package:mylimbcoach/screens/home_professional/settings/views/about_screen.dart';
import 'package:mylimbcoach/screens/home_professional/settings/views/contact_support_screen.dart';
import 'package:mylimbcoach/screens/home_professional/settings/views/faq_screen.dart';
import 'package:mylimbcoach/screens/home_professional/settings/views/language_screen.dart';
import 'package:mylimbcoach/screens/home_professional/settings/views/notification_settings_screen.dart';
import 'package:mylimbcoach/screens/welcome/views/onboarding_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

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
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.borderColor, width: 0.5)),
              child: Column(
                children: [
                  _buildTile(Assets.pngIconsLanguage, "Language",
                      onTap: () => Get.to(() => LanguageScreen())),
                  _buildTile(Assets.pngIconsBell2, "Notification Settings",
                      onTap: () => Get.to(() => NotificationSettingsScreen())),
                  _buildTile(Assets.pngIconsIii, "About My Limb Coach",
                      onTap: () => Get.to(() => AboutScreen())),
                ],
              ),
            ),
            20.ph,
            Text("Help & Support:",
                style: AppTextStyles.getLato(16, FontWeight.w600)),
            10.ph,
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.borderColor, width: 0.5)),
              child: Column(
                children: [
                  _buildTile(Assets.pngIconsFaq, "Frequently Asked Questions",
                      onTap: () => Get.to(() => FAQScreen())),
                  _buildTile(Assets.pngIconsContactSupport, "Contact Support",
                      onTap: () => Get.to(() => ContactSupportScreen())),
                  _buildTile(Assets.pngIconsDeletion, "Account Deletion",
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
              onPressed: () => showLogoutDialog(context),
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

  Widget _buildTile(String imagePath, String title, {VoidCallback? onTap}) {
    return ListTile(
      title: Text(title, style: AppTextStyles.getLato(14, FontWeight.w500)),
      leading: Image.asset(
        imagePath,
        height: 35,
        width: 35,
      ),
      minLeadingWidth: 35,
      visualDensity: VisualDensity.compact,
      trailing: Icon(Icons.arrow_forward_ios_rounded,
          size: 16, color: AppColors.textBlackColor),
      onTap: onTap,
    );
  }

  void _showDeleteDialog(BuildContext context) {
    Get.dialog(AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            15.ph,
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: AppColors.redColor.withOpacity(0.08),
                  shape: BoxShape.circle),
              child: Center(
                child: Image.asset(
                  Assets.pngIconsDeletion,
                  height: 35,
                  color: AppColors.redColor,
                ),
              ),
            ),
            15.ph,
            Text(
              "Account Deletion?",
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(16, 6.weight),
            ),
            10.ph,
            Text(
              "Are you sure that you want to delete\nthis account permanently?",
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(13, 4.weight),
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(bottom: 20),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    fixedSize: Size(162, 45),
                    side: BorderSide(color: AppColors.borderColor, width: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style: AppTextStyles.getLato(
                        16, 4.weight, AppColors.hintColor),
                  ),
                ),
              ),
              10.pw,
              Expanded(
                child: CustomButton(
                  backgroundColor: AppColors.redColor,
                  borderColor: AppColors.redColor,
                  onPressed: () {
                    Get.offAll(() => OnBoardingScreen());
                  },
                  text: "Delete Account",
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

void showLogoutDialog(BuildContext context) {
  Get.dialog(AlertDialog(
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          15.ph,
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle),
            child: Center(
              child: Image.asset(
                Assets.pngIconsLogout,
                height: 35,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          15.ph,
          Text(
            "Log Out",
            textAlign: TextAlign.center,
            style: AppTextStyles.getLato(16, 6.weight),
          ),
          10.ph,
          Text(
            "Are you sure that you want to log out\nthis account?",
            textAlign: TextAlign.center,
            style: AppTextStyles.getLato(13, 4.weight),
          ),
        ],
      ),
    ),
    actionsPadding: EdgeInsets.only(bottom: 20),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  fixedSize: Size(162, 45),
                  side: BorderSide(color: AppColors.borderColor, width: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style:
                      AppTextStyles.getLato(16, 4.weight, AppColors.hintColor),
                ),
              ),
            ),
            10.pw,
            Expanded(
              child: CustomButton(
                backgroundColor: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,
                onPressed: () {
                  Get.offAll(() => OnBoardingScreen());
                },
                text: "Log Out",
              ),
            ),
          ],
        ),
      ),
    ],
  ));
}
