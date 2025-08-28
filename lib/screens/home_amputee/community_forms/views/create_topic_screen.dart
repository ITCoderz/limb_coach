import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/auth/components/uplaod_box.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/controllers/form_controllers.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';
import 'package:mylimbcoach/widgets/video_post.dart';

class CreateTopicScreen extends StatelessWidget {
  final ForumController controller = Get.find<ForumController>();

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Create New Topic"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Topic Details:",
                style: AppTextStyles.getLato(18, 6.weight),
              ),
              25.ph,
              CustomTextField(
                controller: titleCtrl,
                label: "Title",
                hintText: 'eg., Lorem Ipsum',
              ),
              25.ph,
              CustomTextField(
                controller: descCtrl,
                maxLines: 4,
                label: "Description",
                hintText: 'Write post content here..',
              ),
              SizedBox(height: 20),
              Text(
                "Upload Image/Video",
                style: AppTextStyles.getLato(14, 5.weight),
              ),
              SizedBox(height: 20),
              UploadBox2(
                title: "Image/Video",
                onDelete: controller.deletePic,
                onTap: () => controller.pickAndUploadMedia(),
                progress: controller.uploadProgress,
                isEdit: controller.isEdit,
                desc: 'Supported formats: PNG, JPG, MP4, MOV (Max 200MB)',
                fileName: controller.uploadedFileName,
                imageWidget: Obx(() {
                  if (controller.pickedFilePath.value.isEmpty) {
                    return const SizedBox();
                  } else {
                    return SizedBox(
                      height: 150,
                      width: context.width,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child:
                              controller.pickedFilePath.value.contains("mp4") ||
                                      controller.pickedFilePath.value
                                          .contains("mov")
                                  ? VideoPost(
                                      url: controller.pickedFilePath.value,
                                      network: false,
                                    )
                                  : Image.file(
                                      File(controller.pickedFilePath.value),
                                      fit: BoxFit.cover)),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
          onPressed: () {
            if (titleCtrl.text.isNotEmpty) {
              controller.allTopics.add({
                "id": DateTime.now().millisecondsSinceEpoch,
                "title": titleCtrl.text,
                "tag": "Recent",
                "posts": 0,
                "description": descCtrl.text
              });
              controller.deletePic();
              Get.back();
            }
          },
          text: "Create Topic",
        ),
      )),
    );
  }
}
