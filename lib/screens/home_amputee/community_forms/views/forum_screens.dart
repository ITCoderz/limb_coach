import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/controllers/form_controllers.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/views/create_topic_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/views/forum_filter_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/views/post_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class ForumScreen extends StatelessWidget {
  final controller = Get.put(ForumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Community Forums"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildSearchBar()),
                10.pw,
                GestureDetector(
                    onTap: () => Get.to(() => ForumFiltersScreen()),
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
                    )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Total Topics",
                    style: AppTextStyles.getLato(16, 6.weight)),
                Obx(() => Text(
                      " (${controller.filteredTopics.length})",
                      style: AppTextStyles.getLato(
                          16, 4.weight, AppColors.hintColor),
                    )),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.filteredTopics.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (_, i) {
                      final topic = controller.filteredTopics[i];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => PostScreen(topic: topic));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.symmetric(vertical: 5),
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
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: topic["tag"] == "Trending"
                                            ? Color(0xffF4822C)
                                                .withOpacity(0.05)
                                            : AppColors.primaryColor
                                                .withOpacity(0.05)),
                                    child: Center(
                                      child: Text(
                                        topic["tag"]!,
                                        style: AppTextStyles.getLato(
                                            11,
                                            5.weight,
                                            topic["tag"] == "Trending"
                                                ? Color(0xffF4822C)
                                                : AppColors.primaryColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              5.ph,
                              Text(topic["title"]!,
                                  style: AppTextStyles.getLato(
                                      12, FontWeight.w600)),
                              Text(topic["description"]!,
                                  style: AppTextStyles.getLato(
                                      12, FontWeight.w400)),
                              5.ph,
                              Row(
                                children: [
                                  Image.asset(
                                    Assets.pngIconsPost,
                                    height: 22,
                                  ),
                                  5.pw,
                                  Text("${topic["posts"]} Posts",
                                      style: AppTextStyles.getLato(11,
                                          FontWeight.w400, AppColors.hintColor),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
            CustomButton(
                onPressed: () {
                  Get.to(() => CreateTopicScreen());
                },
                text: "Create New Topic"),
          ],
        ),
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
          hintText: 'Search Topic...',
          hintStyle: AppTextStyles.getLato(13, 4.weight, AppColors.hintColor),
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
