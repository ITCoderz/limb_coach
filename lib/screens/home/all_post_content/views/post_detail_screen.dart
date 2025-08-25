import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home/all_post_content/controllers/all_post_controller.dart';
import 'package:mylimbcoach/screens/home/all_reviews/views/all_reviews_screen.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/read_more.dart';
import 'package:mylimbcoach/widgets/video_post.dart';

class PostDetailScreen extends StatelessWidget {
  final Map<String, dynamic> post; // passed from AllPostScreen
  PostDetailScreen({super.key, required this.post});
  final controller = Get.put(AllPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(""),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title + Category
            if (post["videoUrl"] != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: VideoPost(url: post["videoUrl"]),
              ),
              15.ph,
            ],
            Text(
              post["title"] ?? "",
              style: AppTextStyles.getLato(18, 6.weight),
            ),
            8.ph,
            Chip(
              label: Text(
                post["category"] ?? "",
                style:
                    AppTextStyles.getLato(11, 5.weight, AppColors.primaryColor),
              ),
              backgroundColor: AppColors.primaryColor.withOpacity(0.05),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            12.ph,

            /// Description
            ReadMoreText(
              text: post["desc"] ?? "",
              style: AppTextStyles.getLato(13, 4.weight),
              trimLines: 4, // show first 4 lines only
            ),

            15.ph,

            /// Date & Time
            Row(
              children: [
                Image.asset(
                  Assets.pngIconsCalander,
                  height: 18,
                ),
                5.pw,
                Text(
                  post["date"] ?? "July 18, 2025 | 03:39 PM",
                  style: AppTextStyles.getLato(12, 4.weight, Colors.black54),
                ),
              ],
            ),
            5.ph,
            Divider(),
            5.ph,

            /// Stats Row
            Row(
              children: [
                Icon(Icons.remove_red_eye,
                    size: 16, color: AppColors.hintColor),
                5.pw,
                Text("${post["views"] ?? 0} Views",
                    style: AppTextStyles.getLato(12, 4.weight)),
                15.pw,
                Icon(Icons.favorite, size: 16, color: AppColors.hintColor),
                5.pw,
                Text("${post["likes"] ?? 0} Likes",
                    style: AppTextStyles.getLato(12, 4.weight)),
                15.pw,
                Image.asset(Assets.pngIconsComments, height: 22),
                5.pw,
                Obx(
                  () => Text("${controller.comments.length} Comments",
                      style: AppTextStyles.getLato(12, 4.weight)),
                ),
                15.pw,
                Icon(Icons.bookmark, size: 16, color: AppColors.hintColor),
                5.pw,
                Text("${post["saves"] ?? 0} Saves",
                    style: AppTextStyles.getLato(12, 4.weight)),
              ],
            ),
            5.ph,
            Divider(),
            20.ph,

            /// Comments Section
            Obx(
              () => Row(
                children: [
                  Text("All Comments",
                      style: AppTextStyles.getLato(16, 6.weight)),
                  Text(" (${controller.comments.length})",
                      style: AppTextStyles.getLato(
                          14, 4.weight, AppColors.hintColor)),
                ],
              ),
            ),
            15.ph,
            Expanded(
                child: Obx(
              () => ListView.builder(
                itemCount: controller.comments.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) {
                  final r = controller.comments[i];
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.borderColor, width: 0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                r.image,
                                height: 49,
                              ),
                            ),
                            10.pw,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r.userName,
                                  style: AppTextStyles.getLato(14, 6.weight),
                                ),
                                5.ph,
                                Text(
                                  "${r.date.day}/${r.date.month}/${r.date.year}",
                                  style: AppTextStyles.getLato(
                                      11, 4.weight, AppColors.hintColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                        10.ph,
                        Text(
                          r.comment,
                          style: AppTextStyles.getLato(12, 4.weight),
                        ),
                        20.ph,
                        Row(
                          children: [
                            10.pw,
                            Icon(
                              Icons.favorite,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                            5.pw,
                            Text(
                              "Like",
                              style: AppTextStyles.getLato(11, 4.weight),
                            ),
                            10.pw,
                            GestureDetector(
                              onTap: () => controller.startReply(r.id),
                              child: Image.asset(
                                Assets.pngIconsComments,
                                height: 22,
                              ),
                            ),
                            5.pw,
                            GestureDetector(
                              onTap: () => controller.startReply(r.id),
                              child: Text(
                                "Reply",
                                style: AppTextStyles.getLato(11, 4.weight),
                              ),
                            ),
                            10.pw,
                            GestureDetector(
                              onTap: () {
                                openReportDialog(r.id);
                              },
                              child: Image.asset(
                                Assets.pngIconsReportReview,
                                height: 14,
                              ),
                            ),
                            5.pw,
                            GestureDetector(
                              onTap: () {
                                openReportDialog(r.id);
                              },
                              child: Text(
                                "Report",
                                style: AppTextStyles.getLato(11, 4.weight),
                              ),
                            )
                          ],
                        ),

                        // 🔹 Reply Box (only for the active review)
                        Obx(() {
                          if (controller.replyingToId.value != r.id) {
                            return SizedBox.shrink();
                          }
                          return Column(children: [
                            10.ph,
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.borderColor,
                                      width: 0.5)),
                              child: TextField(
                                controller: controller.replyController,
                                onChanged: (val) =>
                                    controller.replyText.value = val,
                                decoration: InputDecoration(
                                  hintText: "Type your reply...",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                ),
                              ),
                            ),
                            10.ph,
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      fixedSize: Size(162, 45),
                                      side: BorderSide(
                                          color: AppColors.borderColor,
                                          width: 0.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    onPressed: controller.cancelReply,
                                    child: Text(
                                      "Cancel",
                                      style: AppTextStyles.getLato(
                                          16, 4.weight, AppColors.hintColor),
                                    ),
                                  ),
                                ),
                                10.pw,
                                Expanded(
                                  child: Obx(() => CustomButton(
                                        onPressed:
                                            controller.replyText.value.isEmpty
                                                ? () {}
                                                : () => controller.submitReply(
                                                    r.id,
                                                    controller.replyText.value),
                                        backgroundColor:
                                            controller.replyText.value.isEmpty
                                                ? AppColors.primaryColor
                                                    .withOpacity(0.45)
                                                : AppColors.primaryColor,
                                        borderColor:
                                            controller.replyText.value.isEmpty
                                                ? AppColors.primaryColor
                                                    .withOpacity(0.45)
                                                : AppColors.primaryColor,
                                        text: "Reply",
                                      )),
                                ),
                              ],
                            )
                          ]);
                        })
                      ],
                    ),
                  );
                },
              ),
            ))
          ],
        ),
      ),

      /// Add Comment Input
    );
  }
}
