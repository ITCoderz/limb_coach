import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_dropdown.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

import '../controllers/topic_controller.dart';

class CreatePostScreen extends StatelessWidget {
  final Map<String, dynamic> topic;
  final TopicController controller = Get.find<TopicController>();

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();

  CreatePostScreen({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Create New Post"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Post Details:",
              style: AppTextStyles.getLato(18, 6.weight),
            ),
            25.ph,
            CustomDropdownField(fieldLabel: "Topic", items: [
              "New Amputee Support",
              "Sports & Fitness",
              "Living with Limb Loss"
            ]),
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
            Spacer(),
            CustomButton(
              onPressed: () {
                if (titleCtrl.text.isNotEmpty) {
                  controller.posts.add({
                    "title": titleCtrl.text,
                    "author": "You",
                    "date": "July 20, 2025",
                    "content": descCtrl.text,
                    "views": "0",
                    "likes": 0,
                    "comments": 0,
                  });
                  Get.back();
                }
              },
              text: "Create Post",
            )
          ],
        ),
      ),
    );
  }
}
