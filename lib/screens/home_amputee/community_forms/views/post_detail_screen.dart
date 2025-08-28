import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/controllers/form_controllers.dart';
import 'package:mylimbcoach/screens/home_professional/all_reviews/views/all_reviews_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

import '../controllers/post_controller.dart';

class PostDetailScreen extends StatelessWidget {
  final Map<String, dynamic> post;
  final PostController controller = Get.put(PostController());
  final c = Get.find<ForumController>();

  final TextEditingController commentCtrl = TextEditingController();

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(''),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  post["title"]!,
                  style: AppTextStyles.getLato(18, 6.weight),
                ),
              ],
            ),
            5.ph,
            Row(
              children: [
                Text("By", style: AppTextStyles.getLato(13, 4.weight)),
                5.pw,
                Text(
                  post["author"]!,
                  style: AppTextStyles.getLato(
                      13, 5.weight, AppColors.primaryColor),
                )
              ],
            ),
            5.ph,
            Text(
              post["content"]!,
              style: AppTextStyles.getLato(13, 4.weight),
            ),
            5.ph,
            Row(
              children: [
                Image.asset(
                  Assets.pngIconsCalander,
                  height: 15,
                ),
                5.pw,
                Text(
                  "July 18, 2025 | 03:39 PM",
                  style:
                      AppTextStyles.getLato(12, 4.weight, AppColors.hintColor),
                ),
              ],
            ),
            5.ph,
            Divider(),
            5.ph,
            Row(
              children: [
                Icon(Icons.remove_red_eye,
                    size: 15, color: AppColors.borderColor),
                5.pw,
                Text(
                  "${post["shares"]} Views",
                  style: AppTextStyles.getLato(11, 4.weight),
                ),
                10.pw,
                Icon(Icons.favorite, size: 15, color: AppColors.borderColor),
                5.pw,
                Text(
                  "${post["likes"]} Likes",
                  style: AppTextStyles.getLato(11, 4.weight),
                ),
                10.pw,
                Image.asset(
                  Assets.pngIconsComments,
                  height: 18,
                ),
                5.pw,
                Text(
                  "${post["comments"]} Comments",
                  style: AppTextStyles.getLato(11, 4.weight),
                ),
                10.pw,
                Image.asset(
                  Assets.pngIconsSave,
                  height: 18,
                ),
                5.pw,
                Text(
                  "${post["comments"]} Saves",
                  style: AppTextStyles.getLato(11, 4.weight),
                )
              ],
            ),
            5.ph,
            Divider(),
            5.ph,
            Row(
              children: [
                Text("All Reviews", style: AppTextStyles.getLato(18, 6.weight)),
                Text(" (${c.reviews.length})",
                    style: AppTextStyles.getLato(
                        16, 4.weight, AppColors.hintColor)),
              ],
            ),
            20.ph,
            Expanded(
              child: ListView.builder(
                itemCount: c.reviews.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) {
                  final r = c.reviews[i];
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    r.userName,
                                    style: AppTextStyles.getLato(14, 6.weight),
                                  ),
                                  Row(
                                    children: List.generate(
                                        5,
                                        (index) => Image.asset(
                                              Assets.pngIconsStar,
                                              color: index < r.rating
                                                  ? Colors.amber
                                                  : Colors.grey,
                                              height: 16,
                                            )),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${r.date.day}/${r.date.month}/${r.date.year}",
                              style: AppTextStyles.getLato(
                                  11, 4.weight, AppColors.hintColor),
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
                              onTap: () => c.startReply(r.id),
                              child: Image.asset(
                                Assets.pngIconsComments,
                                height: 20,
                              ),
                            ),
                            5.pw,
                            GestureDetector(
                              onTap: () => c.startReply(r.id),
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
                          if (c.replyingToId.value != r.id) {
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
                                controller: c.replyController,
                                onChanged: (val) => c.replyText.value = val,
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
                                    onPressed: c.cancelReply,
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
                                        onPressed: c.replyText.value.isEmpty
                                            ? () {}
                                            : () => c.submitReply(
                                                r.id, c.replyText.value),
                                        backgroundColor:
                                            c.replyText.value.isEmpty
                                                ? AppColors.primaryColor
                                                    .withOpacity(0.45)
                                                : AppColors.primaryColor,
                                        borderColor: c.replyText.value.isEmpty
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
            ),
          ],
        ),
      ),
    );
  }
}
