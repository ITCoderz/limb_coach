import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/controllers/cart_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/browse_prosthetic_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/cart_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/views/forum_screens.dart';
import 'package:mylimbcoach/screens/home_amputee/consultation/views/consultation_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/homepage/controllers/home_page_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/homepage/views/notifications_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/my_order/views/my_order_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/track_order/views/track_order_list.dart';
import 'package:mylimbcoach/screens/home_professional/edit_profile/views/edit_profile_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/drawer.dart';
import 'package:mylimbcoach/screens/home_professional/settings/views/settings_screen.dart';
import 'package:mylimbcoach/screens/home_professional/start_consultation/views/call_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class AmputeeDashboardScreen extends StatelessWidget {
  AmputeeDashboardScreen({super.key});
  final controller = Get.put(AmputeeDashboardController());

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
              _sectionTitle("Recommended Products:", onViewAll: () {}),
              Obx(() => SizedBox(
                    height: 230, // 👈 adjust height based on your card size
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.recommendedProducts.length,
                      itemBuilder: (context, index) {
                        final c = controller.recommendedProducts[index];
                        return Container(
                          width: (context.width / 2) - 24,
                          padding: const EdgeInsets.all(6.0),
                          margin: const EdgeInsets.only(
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.borderColor,
                              width: 0.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset(
                                    "${c['image']}",
                                    width: (context.width / 2) - 24,
                                  )),
                              10.ph,
                              Text(
                                "${c["type"]}",
                                style: AppTextStyles.getLato(13, 6.weight),
                              ),
                              5.ph,
                              Text(
                                "${c["amputation"]}",
                                style: AppTextStyles.getLato(
                                  10,
                                  4.weight,
                                ),
                              ),
                              10.ph,
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: InkWell(
                                      onTap: () {
                                        Get.find<CartController>()
                                            .addToCart(c, "M", 1);

                                        // ✅ Feedback
                                        Get.snackbar(
                                          "Added to Cart",
                                          "${c["type"]} has been added",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          colorText: Colors.white,
                                          margin: const EdgeInsets.all(12),
                                        );
                                      },
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.primaryColor),
                                        child: Center(
                                          child: Text(
                                            "Add to Cart",
                                            style: AppTextStyles.getLato(12,
                                                6.weight, AppColors.whiteColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  10.pw,
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.borderColor,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${c['price']}",
                                          style: AppTextStyles.getLato(
                                            11,
                                            4.weight,
                                            AppColors.hintColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )),
              20.ph,
              _sectionTitle(
                "My Next Consultation:",
              ),
              Obx(() => Column(
                    children: [
                      ...controller.consultations.map((m) => Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColors.borderColor, width: 0.5)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primaryColor
                                          .withOpacity(0.05)),
                                  child: Image.asset(
                                      Assets.pngIconsAllConsultation),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        m["appointment"]!,
                                        style:
                                            AppTextStyles.getLato(12, 6.weight),
                                      ),
                                      Text(
                                        "with ${m["name"]!}",
                                        style: AppTextStyles.getLato(
                                            11, 4.weight, AppColors.hintColor),
                                      ),
                                      5.ph,
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.05),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          "${m["date"]}",
                                          style: AppTextStyles.getLato(
                                              10, 4.weight),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    elevation: 0,
                                    padding: EdgeInsets.zero,
                                    fixedSize: Size(105, 30),
                                    side: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(() => CallScreen(
                                        name: "${m['name']}",
                                        image: Assets.pngIconsDp2));
                                  },
                                  child: Text(
                                    "Join Video Call",
                                    style: AppTextStyles.getLato(
                                        12, 6.weight, Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  )),
              10.ph,
              _sectionTitle(
                "Community Hub:",
              ),
              10.ph,
              SizedBox(
                height: 210,
                width: context.width,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.8,
                  mainAxisSpacing: 12,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  children: controller.communityHub.map((opt) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 0.5, color: AppColors.borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: opt['type'] == "Trend"
                                        ? Color(0xffF4822C).withOpacity(0.05)
                                        : AppColors.primaryColor
                                            .withOpacity(0.05)),
                                child: Center(
                                  child: Text(
                                    opt['type']!,
                                    style: AppTextStyles.getLato(
                                        11,
                                        5.weight,
                                        opt['type'] == "Trend"
                                            ? Color(0xffF4822C)
                                            : AppColors.primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          5.ph,
                          Text(opt["title"]!,
                              style:
                                  AppTextStyles.getLato(12, FontWeight.w600)),
                          5.ph,
                          Text(opt["replies"]!,
                              style: AppTextStyles.getLato(
                                  11, FontWeight.w400, AppColors.hintColor),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              20.ph,
              Center(
                child: CustomButton(
                  width: 90,
                  onPressed: () {},
                  textStyle:
                      AppTextStyles.getLato(12, 6.weight, AppColors.whiteColor),
                  text: "Go to Forms",
                ),
              ),
              20.ph,
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
              child: Icon(
                Icons.menu,
                color: AppColors.primaryColor,
              ),
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
                  color: AppColors.primaryColor.withOpacity(0.05)),
              child: Icon(
                Icons.add,
                size: 30,
                color: AppColors.primaryColor,
              ),
            ),
            onTap: () => _showQuickActions(context)),
        GestureDetector(
            child: Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor.withOpacity(0.05)),
              child: Image.asset(
                Assets.pngIconsBell,
                color: AppColors.primaryColor,
              ),
            ),
            onTap: () => Get.to(() => AmputeeNotificationsScreen())),
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
            Get.to(() => AmputeeDashboardScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsMyOrders,
          title: "My Orders",
          onTap: () {
            Get.back();
            Get.to(() => MyOrderListScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsMyCart,
          title: "My Cart",
          onTap: () {
            Get.back();
            Get.to(() => CartScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsMyProgress,
          title: "My Progress & Resources",
          onTap: () {
            Get.back();
            // Get.to(() => InboxListScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsMySchedule,
          title: "My Schedule",
          onTap: () {
            Get.back();
            // Get.to(() => AllReviewsScreen());
          },
        ),
        DrawerItem(
          icon: Assets.pngIconsAllConsultation,
          title: "My Consultations",
          onTap: () {
            Get.back();
            Get.to(() => ConsultationFlow());
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
                  Assets.pngIconsBrowseProsthetic, "Browse Prosthetics", () {
                Get.off(() => BrowseProstheticsScreen());
              }),
              _quickAction(Assets.pngIconsBookConsultation, "Book Consultation",
                  () {
                Get.off(() => ConsultationFlow());
              }),
              _quickAction(Assets.pngIconsTrackOrder, "Track Orders", () {
                Get.off(() => TrackOrderListScreen());
              }),
              _quickAction(Assets.pngIconsCommunityForms, "Community Forms",
                  () {
                Get.off(() => ForumScreen());
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
            border: Border.all(color: AppColors.borderColor, width: 0.5)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(icon, height: 35),
              SizedBox(height: 8),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primaryColor.withOpacity(0.05)),
                    child: Icon(Icons.chevron_left,
                        size: 18, color: AppColors.primaryColor)),
                5.pw,
                Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primaryColor),
                    child: Icon(Icons.chevron_right,
                        size: 18, color: AppColors.whiteColor)),
              ],
            )
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
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xffA6A6A6),
          ),
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
