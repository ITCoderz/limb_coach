import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/all_post_content/views/all_post_content_screen.dart';
import 'package:mylimbcoach/screens/home_professional/all_post_content/views/post_detail_screen.dart';
import 'package:mylimbcoach/screens/home_professional/all_reviews/views/all_reviews_screen.dart';
import 'package:mylimbcoach/screens/home_professional/chat/views/inbox_list.dart';
import 'package:mylimbcoach/screens/home_professional/consultation/views/all_consultation.dart';
import 'package:mylimbcoach/screens/home_professional/edit_profile/views/edit_profile_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/drawer.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/controllers/home_page_controller.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/views/notifications_screen.dart';
import 'package:mylimbcoach/screens/home_professional/manage_availability/views/manage_availability_screen.dart';
import 'package:mylimbcoach/screens/home_professional/my_patients/views/my_patients.dart';
import 'package:mylimbcoach/screens/home_professional/publish_content/views/publish_content.dart';
import 'package:mylimbcoach/screens/home_professional/requests/views/request_screen.dart';
import 'package:mylimbcoach/screens/home_professional/settings/views/settings_screen.dart';
import 'package:mylimbcoach/screens/home_professional/start_consultation/views/call_screen.dart';
import 'package:mylimbcoach/screens/home_professional/start_consultation/views/start_consultation.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class ProfessionalDashboardScreen extends StatelessWidget {
  ProfessionalDashboardScreen({super.key});
  final controller = Get.put(ProfessionalDashboardController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show confirmation before exiting app
        bool exitApp = await _showExitDialog(context);
        return exitApp;
      },
      child: Scaffold(
        drawer: buildSideMenu(context),
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              10.ph,
              _sectionTitle("Today's Consultations:", onViewAll: () {}),
              Obx(
                () => Column(
                  children: List.generate(controller.consultations.length, (
                    index,
                  ) {
                    final c = controller.consultations[index];
                    return Container(
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset("${c['image']}", height: 59),
                              ),
                              10.pw,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${c["name"]} (${c["type"]})",
                                      style: AppTextStyles.getLato(
                                        13,
                                        6.weight,
                                      ),
                                    ),
                                    5.ph,
                                    Text(
                                      "Amputation Type: ${c["amputation"]}",
                                      style: AppTextStyles.getLato(
                                        10,
                                        4.weight,
                                        Color(0xffa6a6a6),
                                      ),
                                    ),
                                    5.ph,
                                    Text(
                                      "Date & Time: ${c["date"]}",
                                      style: AppTextStyles.getLato(
                                        10,
                                        4.weight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          10.ph,
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.zero,
                                    elevation: 0,
                                    fixedSize: Size(172, 45),
                                    side: BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 0.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.cancelConsultation(index);
                                  },
                                  child: Text(
                                    "Cancel Consultation",
                                    style: AppTextStyles.getLato(
                                      14,
                                      6.weight,
                                      AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              10.pw,
                              Expanded(
                                child: CustomButton(
                                  onPressed: () => Get.to(
                                    () => CallScreen(
                                      name: "${c["name"]}",
                                      image: "${c['image']}",
                                    ),
                                  ),
                                  textStyle: AppTextStyles.getLato(
                                    14,
                                    6.weight,
                                    AppColors.whiteColor,
                                  ),
                                  text: "Start Consultation",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              _sectionTitle("New Messages & Reviews:", onViewAll: () {}),
              Obx(
                () => Column(
                  children: [
                    ...controller.messages.map(
                      (m) => Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.borderColor,
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.primaryColor.withOpacity(0.05),
                              ),
                              child: Image.asset(Assets.pngIconsMessage),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    m["title"]!,
                                    style: AppTextStyles.getLato(12, 6.weight),
                                  ),
                                  Text(
                                    m["desc"]!,
                                    style: AppTextStyles.getLato(11, 4.weight),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                fixedSize: Size(59, 30),
                                side: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 0.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "View",
                                style: AppTextStyles.getLato(
                                  12,
                                  6.weight,
                                  Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ...controller.reviews.map(
                      (m) => Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.borderColor,
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffFEBD17).withOpacity(0.11),
                              ),
                              child: Image.asset(Assets.pngIconsStar),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    m["title"]!,
                                    style: AppTextStyles.getLato(12, 6.weight),
                                  ),
                                  Text(
                                    m["desc"]!,
                                    style: AppTextStyles.getLato(11, 4.weight),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                fixedSize: Size(59, 30),
                                side: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 0.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "View",
                                style: AppTextStyles.getLato(
                                  12,
                                  6.weight,
                                  Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _sectionTitle("Trending Post Content:"),
              Obx(
                () => Column(
                  children: controller.posts.map((p) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => PostDetailScreen(post: p));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.borderColor,
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Chip(
                              label: Text(
                                p["category"]!,
                                style: AppTextStyles.getLato(
                                  11,
                                  5.weight,
                                  AppColors.primaryColor,
                                ),
                              ),
                              backgroundColor: AppColors.primaryColor
                                  .withOpacity(0.05),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Text(
                              p["title"]!,
                              style: AppTextStyles.getLato(12, 6.weight),
                            ),
                            5.ph,
                            Text(
                              p["desc"]!,
                              style: AppTextStyles.getLato(11, 4.weight),
                            ),
                            5.ph,
                            Row(
                              children: [
                                Icon(
                                  Icons.remove_red_eye,
                                  size: 15,
                                  color: AppColors.borderColor,
                                ),
                                5.pw,
                                Text(
                                  "${p["shares"]} Views",
                                  style: AppTextStyles.getLato(11, 4.weight),
                                ),
                                10.pw,
                                Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: AppColors.borderColor,
                                ),
                                5.pw,
                                Text(
                                  "${p["likes"]} Likes",
                                  style: AppTextStyles.getLato(11, 4.weight),
                                ),
                                10.pw,
                                Image.asset(
                                  Assets.pngIconsComments,
                                  height: 18,
                                ),
                                5.pw,
                                Text(
                                  "${p["comments"]} Comments",
                                  style: AppTextStyles.getLato(11, 4.weight),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 60,
      leading: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer(); // ✅ Opens Drawer
            },
            child: Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(left: 18, top: 8, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryColor.withOpacity(0.05),
              ),
              child: Icon(Icons.menu, color: AppColors.primaryColor),
            ),
          );
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hello, Welcome", style: AppTextStyles.getLato(12, 4.weight)),
          Text("Dr. Emily White", style: AppTextStyles.getLato(18, 6.weight)),
        ],
      ),
      actions: [
        GestureDetector(
          child: Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.primaryColor.withOpacity(0.05),
            ),
            child: Icon(Icons.add, size: 30, color: AppColors.primaryColor),
          ),
          onTap: () => _showQuickActions(context),
        ),
        GestureDetector(
          child: Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.primaryColor.withOpacity(0.05),
            ),
            child: Image.asset(
              Assets.pngIconsBell,
              color: AppColors.primaryColor,
            ),
          ),
          onTap: () => Get.to(() => NotificationsScreen()),
        ),
        10.pw,
      ],
    );
  }

  Widget buildSideMenu(context) {
    return sideMenu(
      items: [
        DrawerItem(
          icon: Assets.pngIconsHome,
          title: "Home",
          onTap: () {
            Get.back();
            Get.to(() => ProfessionalDashboardScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsAllConsultation,
          title: "All Consultations",
          onTap: () {
            Get.back();
            Get.to(() => AllConsultationsScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsAllRequests,
          title: "All Requests",
          onTap: () {
            Get.back();
            Get.to(() => RequestConsultationScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsMessages,
          title: "Inbox Messages",
          onTap: () {
            Get.back();
            Get.to(() => InboxListScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsAllReviews,
          title: "All Reviews",
          onTap: () {
            Get.back();
            Get.to(() => AllReviewsScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsAllPostContent,
          title: "All Post Content",
          onTap: () {
            Get.back();
            Get.to(() => AllPostContentScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsProfile,
          title: "Profile",
          onTap: () {
            Get.back();
            Get.to(() => EditProfileScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsSettings,
          title: "Settings",
          onTap: () {
            Get.back();
            Get.to(() => SettingsScreen());
          },
        ),
      ],
      onLogout: () => showLogoutDialog(context),
      // Logout logic here
    );
  }

  // 🔹 Quick Actions Popup
  void _showQuickActions(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Quick Actions:"),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            childAspectRatio: 1,
            children: [
              _quickAction(
                Assets.pngIconsManageAvailability,
                "Manage Availability",
                () {
                  Get.off(() => ManageAvailabilityScreen());
                },
              ),
              _quickAction(
                Assets.pngIconsStartConsultation,
                "Start Consultation",
                () {
                  Get.off(() => StartConsultation());
                },
              ),
              _quickAction(Assets.pngIconsPublicContent, "Publish Content", () {
                Get.off(() => PublishContentScreen());
              }),
              _quickAction(Assets.pngIconsMyPatients, "My Patients", () {
                Get.off(() => MyPatients());
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickAction(String icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.borderColor, width: 0.5),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(icon, height: 35),
              SizedBox(height: 5),
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.getLato(12, 5.weight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, {VoidCallback? onViewAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.getLato(16, 6.weight)),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                "View All",
                style:
                    AppTextStyles.getLato(
                      12,
                      5.weight,
                      AppColors.primaryColor,
                    ).copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                    ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Here...',
          hintStyle: AppTextStyles.getLato(13, 4.weight, Color(0xffA6A6A6)),
          prefixIcon: Icon(Icons.search, color: Color(0xffA6A6A6)),
          filled: false,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Exit App?"),
            content: Text("Are you sure you want to exit the app?"),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("Cancel"),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("Exit"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false;
  }
}
