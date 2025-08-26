import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/publish_content/controller/publish_content_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

/// ------------------- PUBLISHED CONTENT PREVIEW ----------------------
class PublishedContentScreen extends StatelessWidget {
  final PublishController c = Get.find<PublishController>();

  PublishedContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: Image.asset(Assets.pngIconsBackIcon)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.title.value.capitalizeFirst.toString(),
                    style: AppTextStyles.getLato(18, 6.weight)),
                if (c.selectedTags.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, bottom: 10),
                    child: Wrap(
                      spacing: 6,
                      children: c.selectedTags
                          .map((e) => Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                label: Text(
                                  e,
                                  style: AppTextStyles.getLato(
                                    11,
                                    FontWeight.w500, // instead of 5.weight
                                    AppColors.primaryColor,
                                  ),
                                ),
                                backgroundColor:
                                    AppColors.primaryColor.withOpacity(0.05),
                              ))
                          .toList(),
                    ),
                  ),
                if (c.contentType.value == "Article")
                  Text(c.content.value,
                      style: AppTextStyles.getLato(13, 4.weight)),
                if (c.contentType.value == "Video")
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.black26,
                    child: Center(
                        child: Icon(Icons.play_circle_fill,
                            size: 60, color: Colors.white)),
                  ),
                20.ph,
                Row(
                  children: [
                    Image.asset(
                      Assets.pngIconsCalander,
                      height: 18,
                    ),
                    5.pw,
                    Text(
                      DateFormat("MMMM dd, yyyy | hh:mm a")
                          .format(DateTime.now()),
                      style: AppTextStyles.getLato(12, 4.weight),
                    )
                  ],
                ),
                20.ph,
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      size: 15,
                      color: AppColors.borderColor,
                    ),
                    5.pw,
                    Text(
                      "0 Views",
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
                      "0 Likes",
                      style: AppTextStyles.getLato(11, 4.weight),
                    ),
                    10.pw,
                    Image.asset(
                      Assets.pngIconsComments,
                      height: 18,
                    ),
                    5.pw,
                    Text(
                      "0 Comments",
                      style: AppTextStyles.getLato(11, 4.weight),
                    ),
                    10.pw,
                    Image.asset(
                      Assets.pngIconsSave,
                      height: 18,
                    ),
                    5.pw,
                    Text(
                      "0 Saves",
                      style: AppTextStyles.getLato(11, 4.weight),
                    )
                  ],
                ),
                20.ph,
                Row(
                  children: [
                    Text("All Comments",
                        style: AppTextStyles.getLato(18, 6.weight)),
                    Text(" (0)",
                        style: AppTextStyles.getLato(
                            16, 4.weight, AppColors.hintColor)),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
