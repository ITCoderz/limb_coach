import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/auth/components/uplaod_box.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home/publish_content/controller/publish_content_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_dropdown.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

/// ------------------- PUBLISH CONTENT SCREEN ----------------------
class PublishContentScreen extends StatelessWidget {
  PublishContentScreen({super.key});
  final PublishController c = Get.put(PublishController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Publish Content"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Content Type:",
                    style: AppTextStyles.getLato(16, 6.weight)),
                10.ph,
                Row(
                  children: [
                    Radio(
                      value: "Article",
                      groupValue: c.contentType.value,
                      activeColor: AppColors.primaryColor,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      onChanged: (val) => c.contentType.value = val.toString(),
                    ),
                    Text("Article"),
                  ],
                ),
                10.ph,
                Row(
                  children: [
                    Radio(
                      value: "Video",
                      groupValue: c.contentType.value,
                      activeColor: AppColors.primaryColor,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      onChanged: (val) => c.contentType.value = val.toString(),
                    ),
                    Text("Video"),
                  ],
                ),
                25.ph,
                CustomTextField(
                  label: c.contentType.value == "Article"
                      ? "Article Title"
                      : "Video Title",
                  onChanged: (val) => c.title.value = val,
                  hintText: c.contentType.value == "Article"
                      ? 'eg., Latest Advances in Prosthetic Liners'
                      : 'eg., Daily Exercises for Above-Knee Amputees',
                  controller: c.titleController,
                ),
                16.ph,
                Obx(
                  () => Stack(
                    children: [
                      Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 12),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(horizontal: 12),
                          childrenPadding: EdgeInsets.zero,
                          title: c.selectedTags.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text(
                                    "Select Tags",
                                    style: AppTextStyles.getLato(13, 4.weight),
                                  ),
                                )
                              : SizedBox(
                                  height:
                                      40, // fixed height for horizontal list
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: c.selectedTags.length,
                                    itemBuilder: (context, index) {
                                      final tag = c.selectedTags[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            right: 6), // spacing between chips
                                        child: Chip(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          label: Text(
                                            tag,
                                            style: AppTextStyles.getLato(
                                              11,
                                              FontWeight
                                                  .w500, // instead of 5.weight
                                              AppColors.primaryColor,
                                            ),
                                          ),
                                          backgroundColor: AppColors
                                              .primaryColor
                                              .withOpacity(0.05),
                                          deleteIcon: const Icon(Icons.clear,
                                              color: Colors.black, size: 18),
                                          onDeleted: () => c.removeTag(tag),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 200), // fixed dropdown height
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: c.allTags.length,
                                itemBuilder: (context, index) {
                                  final tag = c.allTags[index];
                                  final isSelected =
                                      c.selectedTags.contains(tag);

                                  return GestureDetector(
                                    onTap: () => c.toggleTag(tag),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : Colors.white,
                                      ),
                                      child: Text(
                                        tag,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Container(
                          color: Colors.white,
                          child: Text(
                            "Category/Tags*",
                            style: AppTextStyles.getLato(12, 6.weight),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                25.ph,
                if (c.contentType.value == "Article")
                  CustomTextField(
                    maxLines: 6,
                    label: "Article Content",
                    onChanged: (val) => c.content.value = val,
                    hintText: 'Write your article here...',
                    controller: c.contentController,
                  ),
                if (c.contentType.value == "Video")
                  UploadBox(
                    title: "Video",
                    desc: "Supported formats: MP4, MOV (Max 200MB)",
                    onTap: () => c.pickVideo(),
                    progress: c.uploadProgress,
                    fileName: c.uploadedFileName,
                  ),
                24.ph,
                Text("Publishing Options:",
                    style: AppTextStyles.getLato(16, 6.weight)),
                20.ph,
                CustomDropdownField(
                  value: c.visibility.value,
                  items: ["Public", "Private"],
                  onChanged: (val) => c.visibility.value = val!,
                  fieldLabel: 'Visibility',
                ),
                20.ph,
                Row(
                  children: [
                    Text(
                      "Allow Comments",
                      style: AppTextStyles.getLato(13, 5.weight),
                    ),
                    Spacer(),
                    Transform.scale(
                      scale: 0.7, // adjust between 0.5 - 1.0 for smaller size
                      child: CupertinoSwitch(
                        value: c.allowComments.value,
                        activeColor: AppColors.primaryColor,
                        onChanged: (val) => c.allowComments.value = val,
                      ),
                    ),
                  ],
                ),
                20.ph,
                CustomButton(
                  onPressed: c.isPublishEnabled.value ? c.publish : () {},
                  backgroundColor: c.isPublishEnabled.value
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(0.4),
                  borderColor: c.isPublishEnabled.value
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(0.4),
                  text: "Publish Content",
                ),
              ],
            )),
      ),
    );
  }
}
