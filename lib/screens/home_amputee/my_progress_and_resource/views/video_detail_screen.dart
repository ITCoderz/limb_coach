import 'package:flutter/material.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/video_post.dart';

class VideoDetailScreen extends StatelessWidget {
  final String title;
  final String videoPath; // works for file path or URL
  final String description;
  final bool network; // true = URL, false = File

  const VideoDetailScreen({
    Key? key,
    required this.title,
    required this.videoPath,
    required this.description,
    this.network = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("", widgets: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(Assets.pngIconsShare),
        ),
        10.pw,
      ]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Video Player
            SizedBox(
              height: 300,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: VideoPost(
                    url: videoPath,
                    network: network,
                  ),
                ),
              ),
            ),

            16.ph,

            /// Title
            Text(
              title,
              style: AppTextStyles.getLato(16, 5.weight),
            ),
            10.ph,

            /// Description
            Text(
              description,
              style: AppTextStyles.getLato(12, 4.weight, AppColors.hintColor),
            ),
          ],
        ),
      ),
    );
  }
}
