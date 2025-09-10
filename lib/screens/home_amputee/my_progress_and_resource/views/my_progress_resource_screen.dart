import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/my_progress_and_resource/controllers/my_progress_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/my_progress_and_resource/views/add_training_plan.dart';
import 'package:mylimbcoach/screens/home_amputee/my_progress_and_resource/views/video_detail_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/video_post.dart';

import 'photo_detail_screen.dart';
import 'training_detail_screen.dart';

class MyProgressResourcesScreen extends StatelessWidget {
  final ProgressController c = Get.put(ProgressController());

  MyProgressResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        "My Progress & Resources",
        widgets: [
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
          10.pw,
        ],
      ),
      body: Column(
        children: [
          // Tabs
          // Tabs Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(child: _tabButton("Photos", 0)),
                Expanded(child: _tabButton("Videos", 1)),
                Expanded(child: _tabButton("Training Plans", 2)),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              if (c.selectedTab.value == 0) return _photosTab();
              if (c.selectedTab.value == 1) return _videosTab();
              return _trainingPlansTab();
            }),
          ),
        ],
      ),
    );
  }

  /// ---------------- Tabs ----------------
  Widget _tabButton(String title, int index) {
    return GestureDetector(
      onTap: () => c.changeTab(index),
      child: Obx(
        () => Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: c.selectedTab.value == index
                    ? AppColors.primaryColor
                    : AppColors.borderColor,
                width: c.selectedTab.value == index ? 2 : 0.5,
              ),
            ),
          ),
          child: Text(
            title.toUpperCase(),
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
    );
  }

  /// ---------------- Photos ----------------
  Widget _photosTab() {
    return Column(
      children: [
        10.ph,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text("My Photos", style: AppTextStyles.getLato(18, 6.weight)),
              Obx(
                () => Text(
                  " (${c.pickedPhoto.value != null ? 1 + 4 : 4})", // count dynamic
                  style: AppTextStyles.getLato(
                    16,
                    4.weight,
                    AppColors.hintColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            final hasPhoto = c.pickedPhoto.value != null;

            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: hasPhoto ? 1 + 4 : 4, // 1 uploaded + 4 sample
              itemBuilder: (_, i) {
                // Show uploaded photo at index 0
                if (hasPhoto && i == 0) {
                  return GestureDetector(
                    onTap: () => Get.to(
                      () => PhotoDetailScreen(
                        imagePath: c.pickedPhoto.value!.path,
                        dateTime: "Uploaded just now",
                        isFile: true,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.file(
                                c.pickedPhoto.value!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          5.ph,
                          Row(
                            children: [
                              Text(
                                "Uploaded just now",
                                style: AppTextStyles.getLato(12, 5.weight),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Show default sample photos
                return GestureDetector(
                  onTap: () => Get.to(
                    () => PhotoDetailScreen(
                      imagePath: Assets.pngIconsLegTransparent,
                      dateTime: "July 27, 2025 | 05:30 PM",
                      isFile: false,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              Assets.pngIconsLegTransparent,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        5.ph,
                        Row(
                          children: [
                            Text(
                              "July 27, 2025 | 05:30 PM",
                              style: AppTextStyles.getLato(12, 5.weight),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  /// ---------------- Videos ----------------
  Widget _videosTab() {
    return Column(
      children: [
        10.ph,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text("My Videos", style: AppTextStyles.getLato(18, 6.weight)),
              Obx(
                () => Text(
                  " (${c.pickedVideo.value != null ? 1 + 4 : 4})", // dynamic count
                  style: AppTextStyles.getLato(
                    16,
                    4.weight,
                    AppColors.hintColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            final hasVideo = c.pickedVideo.value != null;

            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: hasVideo ? 1 + 4 : 4, // uploaded + sample
              itemBuilder: (_, i) {
                // Uploaded video
                if (hasVideo && i == 0) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => VideoDetailScreen(
                          title: "My Uploaded Video",
                          videoPath: c.pickedVideo.value!.path,
                          description: "Uploaded just now",
                          network: false, // because it's a file
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: VideoPost(url: c.pickedVideo.value!.path),
                            ),
                          ),
                          5.ph,
                          Row(
                            children: [
                              Text(
                                "My Uploaded Video",
                                style: AppTextStyles.getLato(12, 5.weight),
                              ),
                            ],
                          ),
                          5.ph,
                          Row(
                            children: [
                              Text(
                                "Uploaded just now",
                                style: AppTextStyles.getLato(
                                  10,
                                  4.weight,
                                  AppColors.hintColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Sample videos
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => VideoDetailScreen(
                        title: "Walking Practice - Day 10",
                        videoPath: "",
                        description: "Uploaded: 20 June 2025",
                        network: true,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: VideoPost(
                              url: "https://example.com/video.mp4",
                            ),
                          ),
                        ),
                        5.ph,
                        Row(
                          children: [
                            Text(
                              "Walking Practice - Day 10",
                              style: AppTextStyles.getLato(12, 5.weight),
                            ),
                          ],
                        ),
                        5.ph,
                        Row(
                          children: [
                            Text(
                              "Uploaded: 20 June 2025",
                              style: AppTextStyles.getLato(
                                10,
                                4.weight,
                                AppColors.hintColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  /// ---------------- Training Plans ----------------
  Widget _trainingPlansTab() {
    return Column(
      children: [
        10.ph,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "My Training Plans",
                style: AppTextStyles.getLato(18, 6.weight),
              ),
              Text(
                " (${10})",
                style: AppTextStyles.getLato(16, 4.weight, AppColors.hintColor),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(12),
            physics: BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: AppColors.borderColor, width: 0.5),
                  ),
                  leading: Image.asset(Assets.pngIconsTrainingPen, height: 24),
                  minLeadingWidth: 25,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Week 1 Mobility Exercises",
                        style: AppTextStyles.getLato(14, 4.weight),
                      ),
                      5.ph,
                      Text(
                        "Created: July 01, 2025",
                        style: AppTextStyles.getLato(
                          10,
                          4.weight,
                          AppColors.hintColor,
                        ),
                      ),
                    ],
                  ),
                  onTap: () => Get.to(() => TrainingDetailScreen()),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showQuickActions(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Quick Actions:"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: _quickAction(
                    Assets.pngIconsUploadPhoto,
                    "Upload Photo",
                    () async {
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        c.pickedPhoto.value = File(image.path);
                        Get.back();
                        Get.snackbar("Success", "Photo uploaded!");
                      }
                    },
                  ),
                ),
                10.pw,
                Expanded(
                  child: _quickAction(
                    Assets.pngIconsUploadVideo,
                    "Upload Video",
                    () async {
                      final XFile? video = await picker.pickVideo(
                        source: ImageSource.gallery,
                      );
                      if (video != null) {
                        c.pickedVideo.value = File(video.path);
                        Get.back();
                        Get.snackbar("Success", "Video uploaded!");
                      }
                    },
                  ),
                ),
              ],
            ),
            _quickAction(
              Assets.pngIconsAddTrainingPlan,
              "Add Training Plan",
              () {
                Get.to(() => AddTrainingPlanScreen());
              },
            ),
          ],
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
}
