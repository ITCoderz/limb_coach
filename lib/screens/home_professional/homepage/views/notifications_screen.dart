import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/models/notification_model.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/controllers/notification_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_snackbar.dart';

/// 🔹 Notifications Screen
class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});
  final NotificationsController controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Image.asset(Assets.pngIconsBackIcon),
        ),
        title: Text(
          "Notifications",
          style: AppTextStyles.getLato(18, 6.weight),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            10.ph,
            _buildSearchBar(),
            20.ph,
            Obx(() {
              final count = controller.filteredNotifications.length;
              return Row(
                children: [
                  Text(
                    "Total Notifications",
                    style: AppTextStyles.getLato(16, 6.weight),
                  ),
                  Text(
                    " ($count)",
                    style: AppTextStyles.getLato(
                        14, 6.weight, AppColors.borderColor),
                  ),
                ],
              );
            }),
            10.ph,
            Expanded(
              child: Obx(() {
                if (controller.filteredNotifications.isEmpty) {
                  return const NoNotificationWidget();
                }
                return ListView.builder(
                  itemCount: controller.filteredNotifications.length,
                  itemBuilder: (context, index) {
                    final notification =
                        controller.filteredNotifications[index];
                    return _buildNotificationCard(notification);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Search Bar
  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        onChanged: (value) => controller.searchText.value = value,
        decoration: InputDecoration(
          hintText: 'Search Here...',
          hintStyle:
              AppTextStyles.getLato(13, 4.weight, const Color(0xffA6A6A6)),
          prefixIcon: const Icon(Icons.search, color: Color(0xffA6A6A6)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
        ),
      ),
    );
  }

  /// 🔹 Notification Card
  Widget _buildNotificationCard(NotificationModel notification) {
    return GestureDetector(
      onTap: () {
        if (notification.isConsultationRequest) {
          _showConsultationDialog(notification);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xffDEDEDE), width: 0.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor.withOpacity(0.05),
              ),
              child: Image.asset(Assets.pngIconsBell,
                  color: AppColors.primaryColor),
            ),
            10.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.title,
                      style: AppTextStyles.getLato(14, 6.weight)),
                  5.ph,
                  Text(
                    notification.message,
                    style: AppTextStyles.getLato(12, 4.weight, Colors.black87),
                  ),
                ],
              ),
            ),
            Text(
              notification.timeAgo,
              style:
                  AppTextStyles.getLato(11, 4.weight, const Color(0xffA6A6A6)),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Consultation Request Dialog
  void _showConsultationDialog(NotificationModel notification) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor.withOpacity(0.05),
          ),
          child:
              Image.asset(Assets.pngIconsBell, color: AppColors.primaryColor),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              notification.title,
              style: AppTextStyles.getLato(16, 6.weight),
              textAlign: TextAlign.center,
            ),
            10.ph,
            Text(
              "${notification.message}\nDo you want to accept it?",
              style: AppTextStyles.getLato(13, 4.weight, Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    fixedSize: Size(162, 45),
                    side: BorderSide(color: AppColors.hintColor, width: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
                  onPressed: () {
                    Get.back();
                    AppSnackbar.success(
                        "Confirmed", "You accepted the consultation request");
                  },
                  text: "Confirm",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 🔹 Empty State Widget
class NoNotificationWidget extends StatelessWidget {
  const NoNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 69,
            width: 69,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.primaryColor.withOpacity(0.05),
            ),
            child:
                Image.asset(Assets.pngIconsBell, color: AppColors.primaryColor),
          ),
          10.ph,
          Text("No New Notifications!",
              style: AppTextStyles.getLato(18, 6.weight)),
          5.ph,
          Text(
            "You're All Caught Up! Check back later for updates",
            style: AppTextStyles.getLato(12, 5.weight, const Color(0xffa6a6a6)),
          ),
        ],
      ),
    );
  }
}
