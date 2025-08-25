import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home/publish_content/views/published_content_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

/// ------------------- SUCCESS SCREEN ----------------------
class PublishSuccessScreen extends StatelessWidget {
  const PublishSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(),
            child: Image.asset(Assets.pngIconsBackIcon)),
      ),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        fixedSize: Size(162, 45),
                        side: BorderSide(
                            color: AppColors.primaryColor, width: 0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => PublishedContentScreen());
                      },
                      child: Text(
                        "View Content",
                        style: AppTextStyles.getLato(
                            16, 4.weight, AppColors.primaryColor),
                      ),
                    ),
                  ),
                  10.pw,
                  Expanded(
                    child: CustomButton(
                      onPressed: () => Get.back(),
                      text: "Continue Editing",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.pngIconsPublishSuccess,
            height: 69,
          ),
          SizedBox(height: 16),
          Text("Content Published\nSuccessfully!",
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(24, 7.weight)),
          SizedBox(height: 8),
          Text(
            "Your content has been published successfully.\nYou can see all your published contents in “All\nPost Contents” section",
            style: AppTextStyles.getLato(14, 4.weight),
            textAlign: TextAlign.center,
          ),
          24.ph,
        ],
      )),
    );
  }
}
