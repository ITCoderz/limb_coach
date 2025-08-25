import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';

PreferredSizeWidget customAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: GestureDetector(
      onTap: () => Get.back(),
      child: Image.asset(Assets.pngIconsBackIcon),
    ),
    title: Text(
      title,
      style: AppTextStyles.getLato(18, FontWeight.w600),
    ),
    centerTitle: true,
  );
}
