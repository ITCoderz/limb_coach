import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/community_forms/controllers/form_controllers.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

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
            OutlinedButton.icon(
              onPressed: () {
                // handle image upload
              },
              icon: Icon(Icons.upload),
              label: Text("Upload Image/Video"),
            ),
            Spacer(),
            CustomButton(
              onPressed: () {
                if (titleCtrl.text.isNotEmpty) {
                  controller.allTopics.add({
                    "id": DateTime.now().millisecondsSinceEpoch,
                    "title": titleCtrl.text,
                    "tag": "Recent",
                    "posts": 0,
                    "description": descCtrl.text
                  });
                  Get.back();
                }
              },
              text: "Create Topic",
            )
          ],
        ),
      ),
    );
  }
}
