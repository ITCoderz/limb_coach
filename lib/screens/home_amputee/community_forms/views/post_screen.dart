import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/controllers/form_controllers.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/views/create_post_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/views/post_detail_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class PostScreen extends StatelessWidget {
  final Map<String, dynamic> topic;
  final controller = Get.find<ForumController>();

  PostScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(topic["title"]), // show topic title
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(height: 10),
            Obx(() {
              final posts = controller.getPostsByTopic(topic["id"]);
              return Row(
                children: [
                  Text("Total Posts",
                      style: AppTextStyles.getLato(16, 6.weight)),
                  Text(
                    " (${posts.length})",
                    style: AppTextStyles.getLato(
                        16, 4.weight, AppColors.hintColor),
                  )
                ],
              );
            }),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                final posts = controller.getPostsByTopic(topic["id"]);

                if (posts.isEmpty) {
                  return Center(
                    child: Text(
                      "No posts found.",
                      style: AppTextStyles.getLato(
                          14, FontWeight.w500, AppColors.hintColor),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: posts.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, i) {
                    final p = posts[i];
                    return GestureDetector(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  p["title"]!,
                                  style: AppTextStyles.getLato(12, 6.weight),
                                ),
                                Text(
                                  "July 18, 2025",
                                  style: AppTextStyles.getLato(
                                      11, 4.weight, AppColors.hintColor),
                                ),
                              ],
                            ),
                            5.ph,
                            Row(
                              children: [
                                Text("By",
                                    style: AppTextStyles.getLato(12, 4.weight)),
                                5.pw,
                                Text(
                                  p["author"]!,
                                  style: AppTextStyles.getLato(
                                      12, 4.weight, AppColors.primaryColor),
                                )
                              ],
                            ),
                            5.ph,
                            Text(
                              p["content"]!,
                              style: AppTextStyles.getLato(11, 4.weight),
                            ),
                            5.ph,
                            Row(
                              children: [
                                Icon(Icons.remove_red_eye,
                                    size: 15, color: AppColors.borderColor),
                                5.pw,
                                Text(
                                  "${p["shares"]} Views",
                                  style: AppTextStyles.getLato(11, 4.weight),
                                ),
                                10.pw,
                                Icon(Icons.favorite,
                                    size: 15, color: AppColors.borderColor),
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
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
            onPressed: () {
              Get.to(() => CreatePostScreen(topic: topic));
            },
            text: "Create New Post"),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        autofocus: false,
        onChanged: (val) => controller.searchText.value = val, // ✅ live search
        decoration: InputDecoration(
          hintText: 'Search posts...',
          hintStyle: AppTextStyles.getLato(13, 4.weight, AppColors.hintColor),
          prefixIcon: Icon(Icons.search, color: Color(0xffA6A6A6)),
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
}
