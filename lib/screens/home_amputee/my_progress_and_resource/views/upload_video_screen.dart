import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class UploadVideoScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Upload Video"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Video picker placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Icon(Icons.video_library,
                    size: 60, color: AppColors.hintColor),
              ),
            ),
            20.ph,

            // Title
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Video Title",
                border: OutlineInputBorder(),
              ),
            ),
            15.ph,

            // Description
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            20.ph,

            // Upload button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                // TODO: implement video upload logic
                Get.back();
              },
              child: Text("Upload",
                  style: AppTextStyles.getLato(14, 6.weight, Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
