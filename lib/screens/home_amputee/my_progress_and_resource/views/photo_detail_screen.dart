import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class PhotoDetailScreen extends StatelessWidget {
  final String? imagePath; // can be asset path or file path
  final String? dateTime;
  final bool isFile; // tells if it's a file

  const PhotoDetailScreen({
    Key? key,
    this.imagePath,
    this.dateTime,
    this.isFile = false,
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
            /// Photo full view
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: isFile
                  ? Image.file(
                      File(imagePath ?? ""),
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      imagePath ?? Assets.pngIconsLegTransparent,
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
            ),

            16.ph,

            /// Date & Time
            Center(
              child: Text(
                dateTime ?? "July 27, 2025 | 05:30 PM",
                style: AppTextStyles.getLato(
                  13,
                  4.weight,
                ),
              ),
            ),

            20.ph,
          ],
        ),
      ),
    );
  }
}
