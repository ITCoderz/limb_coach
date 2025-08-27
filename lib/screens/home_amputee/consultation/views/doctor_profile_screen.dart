import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/models/chat_user.dart';
import 'package:mylimbcoach/screens/home_professional/chat/controllers/inbox_controller.dart';
import 'package:mylimbcoach/screens/home_professional/chat/views/chat.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

import '../controllers/consultation_controller.dart';

class DoctorProfileScreen extends StatelessWidget {
  final c = Get.find<AmputeeConsultationController>();

  @override
  Widget build(BuildContext context) {
    final doc = c.selectedDoctor.value!;

    return Scaffold(
      appBar: customAppBar(""),
      body: Column(
        children: [
          20.ph,
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(Assets.pngIconsDr),
          ),
          12.ph,
          Text(
            doc["name"],
            style: AppTextStyles.getLato(20, 7.weight),
          ),
          Text(
            doc["category"] ?? "Prosthetist",
            style: AppTextStyles.getLato(13, 4.weight, AppColors.hintColor),
          ),
          5.ph,

          // ⭐ Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                5,
                (index) => Image.asset(
                  Assets.pngIconsStar,
                  color: index < (doc["rating"] as num).round()
                      ? Colors.amber
                      : Colors.grey.withOpacity(0.4),
                  height: 19,
                ),
              ),
              6.pw,
              Text(
                "(${doc["reviews"]} Reviews)",
                style: AppTextStyles.getLato(13, 4.weight),
              ),
            ],
          ),
          20.ph,

          // 🟢 Custom Tabs with controller
          Row(
            children: [
              _buildTab("ABOUT", 0),
              _buildTab("REVIEWS", 1),
            ],
          ),

          // Tab Views
          Expanded(
            child: Obx(() {
              if (c.selectedTab.value == 0) {
                return _aboutTab(doc);
              } else {
                return _reviewsTab();
              }
            }),
          ),

          // Bottom buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        final c = Get.put(InboxController());

                        Get.to(() => ChatScreen(
                            user: ChatUser(
                                doc["name"], '', '', Assets.pngIconsDr)));
                      },
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(context.width, 45),
                        side: BorderSide(
                            color: AppColors.primaryColor, width: .8),
                      ),
                      child: Text("Contact Doctor",
                          style: AppTextStyles.getLato(
                              16, 6.weight, AppColors.primaryColor)),
                    ),
                  ),
                  10.pw,
                  Expanded(
                      child: CustomButton(
                          text: "Book Now",
                          onPressed: () {
                            Get.back();
                            c.nextStep();
                          })),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// ✅ Custom Tab Builder
  Widget _buildTab(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => c.changeTab(index),
        child: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            margin: EdgeInsets.only(
                left: index == 0 ? 16 : 0, right: index == 0 ? 0 : 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: c.selectedTab.value == index
                      ? AppColors.primaryColor
                      : Colors.grey
                          .withOpacity(0.4), // grey indicator for unselected
                  width: c.selectedTab.value == index ? 2 : 0.5,
                ),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: AppTextStyles.getLato(
                  13,
                  c.selectedTab.value == index ? 7.weight : 4.weight,
                  c.selectedTab.value == index
                      ? AppColors.primaryColor
                      : AppColors.hintColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// (Your existing _aboutTab and _reviewsTab stay the same)

  Widget _aboutTab(Map<String, dynamic> doc) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text("About:",
              style: AppTextStyles.getLato(16, 6.weight, AppColors.blackColor)),
          8.ph,
          Text(
            doc["about"] ??
                "Focuses on rehabilitation and mobility training. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            style: AppTextStyles.getLato(
              13,
              4.weight,
            ),
          ),
          20.ph,
          Text("Specialties:",
              style: AppTextStyles.getLato(16, 6.weight, AppColors.blackColor)),
          8.ph,
          ...((doc["specialties"] ?? ["Physical Therapist", "Rehabilitation"])
              .map<Widget>((s) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("•  $s",
                        style: AppTextStyles.getLato(
                          13,
                          4.weight,
                        )),
                  ))),
          20.ph,
          Text("Credentials:",
              style: AppTextStyles.getLato(16, 6.weight, AppColors.blackColor)),
          8.ph,
          ...((doc["specialties"] ??
                  ["Certified by [Board Name]", "[University Name] - [Degree]"])
              .map<Widget>((s) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("•  $s",
                        style: AppTextStyles.getLato(
                          13,
                          4.weight,
                        )),
                  )))
        ],
      ),
    );
  }

  Widget _reviewsTab() {
    final reviews = [
      {
        "name": "Patricia Wilson",
        "rating": 5,
        "text":
            "Dr. Emily was incredibly helpful and knowledgeable. Highly recommend!",
        "date": "July 12, 2025",
        "count": 10
      },
      {
        "name": "Patricia Wilson",
        "rating": 5,
        "text":
            "Dr. Emily was incredibly helpful and knowledgeable. Highly recommend!",
        "date": "July 12, 2025",
        "count": 10
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Reviews",
            style: AppTextStyles.getLato(16, 6.weight),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reviews.length,
            itemBuilder: (_, i) {
              final r = reviews[i];
              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.borderColor, width: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.1),
                        child: Text(
                          r["name"]
                              .toString()
                              .split(" ")
                              .map((e) => e[0])
                              .take(2)
                              .join(), // initials
                          style: AppTextStyles.getLato(
                            14,
                            6.weight,
                            AppColors.primaryColor,
                          ),
                        ),
                      ),
                      10.pw,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  r["name"].toString(),
                                  style: AppTextStyles.getLato(14, 6.weight),
                                ),
                                Row(
                                  children: [
                                    ...List.generate(
                                      5,
                                      (index) => Image.asset(
                                        Assets.pngIconsStar,
                                        color:
                                            index < (r["rating"] as num).round()
                                                ? Colors.amber
                                                : Colors.grey.withOpacity(0.4),
                                        height: 14,
                                      ),
                                    ),
                                    6.pw,
                                    Text(
                                      "(${r["count"]} Reviews)",
                                      style: AppTextStyles.getLato(
                                        11,
                                        4.weight,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            10.ph,
                            Text(
                              r["text"].toString(),
                              style: AppTextStyles.getLato(13, 4.weight),
                            ),
                            6.ph,
                            Text(
                              r["date"].toString(),
                              style: AppTextStyles.getLato(
                                11,
                                4.weight,
                                AppColors.hintColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
