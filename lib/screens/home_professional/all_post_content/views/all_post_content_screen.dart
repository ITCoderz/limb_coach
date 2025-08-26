import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/all_post_content/controllers/all_post_controller.dart';
import 'package:mylimbcoach/screens/home_professional/all_post_content/views/filter_screen.dart';
import 'package:mylimbcoach/screens/home_professional/all_post_content/views/post_detail_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/video_post.dart';

class AllPostContentScreen extends StatelessWidget {
  AllPostContentScreen({super.key});
  final controller = Get.put(AllPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar("All Post Content"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                children: [
                  20.ph,
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: [
                        Expanded(child: _buildSearchBar()),
                        10.pw,
                        GestureDetector(
                          onTap: () async {
                            var result =
                                await Get.to(() => PostFiltersScreen());
                            if (result != null) {
                              controller.applyFilters(
                                categories:
                                    List<String>.from(result["statuses"] ?? []),
                              );
                            }
                          },
                          child: Container(
                            height: 48,
                            width: 79,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColors.borderColor, width: 0.5)),
                            child: Row(
                              children: [
                                Image.asset(
                                  Assets.pngIconsFilter,
                                  height: 22,
                                ),
                                5.pw,
                                Text(
                                  "Filter",
                                  style: AppTextStyles.getLato(13, 4.weight),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  20.ph,
                  Row(
                    children: [
                      Text("Total Post Content",
                          style: AppTextStyles.getLato(18, 6.weight)),
                      Text(" (${controller.posts.length})",
                          style: AppTextStyles.getLato(
                              16, 4.weight, AppColors.hintColor)),
                    ],
                  ),
                  20.ph,
                  Obx(() => Column(
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
                                      width: 0.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Chip(
                                        label: Text(
                                          p["category"]!,
                                          style: AppTextStyles.getLato(11,
                                              5.weight, AppColors.primaryColor),
                                        ),
                                        backgroundColor: AppColors.primaryColor
                                            .withOpacity(0.05),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      Text(
                                        "July 18, 2025",
                                        style: AppTextStyles.getLato(
                                            12, 4.weight, AppColors.hintColor),
                                      )
                                    ],
                                  ),
                                  Text(
                                    p["title"]!,
                                    style: AppTextStyles.getLato(12, 6.weight),
                                  ),
                                  5.ph,
                                  Text(
                                    p["desc"]!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.getLato(11, 4.weight),
                                  ),
                                  5.ph,
                                  if (p["videoUrl"] != null)
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: VideoPost(url: p["videoUrl"]!)),
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
                                        style:
                                            AppTextStyles.getLato(11, 4.weight),
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
                                        style:
                                            AppTextStyles.getLato(11, 4.weight),
                                      ),
                                      10.pw,
                                      Image.asset(
                                        Assets.pngIconsComments,
                                        height: 18,
                                      ),
                                      5.pw,
                                      Text(
                                        "${p["comments"]} Comments",
                                        style:
                                            AppTextStyles.getLato(11, 4.weight),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                  30.ph,
                  CustomButton(text: "Create New Content", onPressed: () {}),
                  20.ph,
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        autofocus: false,
        onChanged: (val) => controller.searchPosts(val), // ✅ live search

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
}
