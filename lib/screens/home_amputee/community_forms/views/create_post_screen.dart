import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/controllers/form_controllers.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_dropdown.dart';
import 'package:mylimbcoach/widgets/custom_snackbar.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class CreatePostScreen extends StatelessWidget {
  final Map<String, dynamic> topic;
  final ForumController controller = Get.find<ForumController>();

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();

  // ✅ Reactive selected topic
  final selectedTopic = RxnString();

  CreatePostScreen({required this.topic}) {
    selectedTopic.value = topic["title"]; // set default from passed topic
  }

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
            Obx(() => CustomDropdownField(
                  fieldLabel: "Topic",
                  items: [
                    "New Amputee Support",
                    "Sports & Fitness",
                    "Living with Limb Loss",
                  ],
                  value: selectedTopic.value,
                  onChanged: (val) {
                    if (val != null) selectedTopic.value = val;
                  },
                )),
            25.ph,
            CustomTextField(
              controller: titleCtrl,
              label: "Title",
              hintText: 'eg., My journey...',
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
                if (titleCtrl.text.isNotEmpty &&
                    descCtrl.text.isNotEmpty &&
                    selectedTopic.value != null) {
                  controller.addPost(
                    topicId: topic['id'],
                    title: titleCtrl.text,
                    content: descCtrl.text,
                  );
                  Get.back(); // go back to posts screen
                  AppSnackbar.success("Success", "Post created successfully!");
                } else {
                  AppSnackbar.error("⚠ Error", "Please fill all fields");
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
