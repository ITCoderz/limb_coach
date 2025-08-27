import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class UploadBox extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final RxDouble progress;
  final String? desc;
  final RxString fileName;

  const UploadBox({
    super.key,
    required this.title,
    required this.onTap,
    this.desc,
    required this.progress,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DottedBorder(
        color: AppColors.hintColor.withOpacity(0.4),
        strokeWidth: 1,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 4],
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                progress.value > 0
                    ? Image.asset(Assets.pngIconsPdf)
                    : Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor.withOpacity(0.05),
                        ),
                        child: Center(
                          child: Image.asset(
                            Assets.pngIconsUpload,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                const SizedBox(height: 15),
                title == "Drag & drop your image here, or click to browse"
                    ? Text(
                        progress.value > 0 ? "$title..." : "$title",
                        style: GoogleFonts.lato(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      )
                    : Text(
                        progress.value > 0
                            ? "Uploading $title..."
                            : "Upload $title",
                        style: GoogleFonts.lato(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                const SizedBox(height: 5),
                if (progress.value > 0)
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      fileName.value,
                      style: AppTextStyles.getLato(12, 4.weight, Colors.grey),
                    ),
                  ),
                const SizedBox(height: 5),
                progress.value == 0
                    ? // only show instructions if nothing uploaded
                    desc != null
                        ? Text(
                            desc.toString(),
                            style: GoogleFonts.lato(
                                fontSize: 12, color: Colors.grey),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "PNG, JPG or PDF (Max: 15 MB) ",
                                style: GoogleFonts.lato(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                "Or ",
                                style: GoogleFonts.lato(
                                    fontSize: 12, color: Colors.black),
                              ),
                              Text(
                                "Browse",
                                style: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: AppColors.primaryColor,
                                    decorationColor: AppColors.primaryColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                          Text("  ${(progress * 100).toInt()}% Completed...")
                        ],
                      )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class UploadBoxSlim extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final RxDouble progress;
  final String? desc;
  final File? fileName;

  const UploadBoxSlim({
    super.key,
    required this.title,
    required this.onTap,
    this.desc,
    required this.progress,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(progress);
      return DottedBorder(
        color: AppColors.hintColor.withOpacity(0.4),
        strokeWidth: 1,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 4],
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: progress.value > 0.99 && fileName != null
                ? SizedBox(
                    height: 156,
                    child: Image.file(
                      File(
                        fileName!.path,
                      ),
                      fit: BoxFit.cover,
                    ))
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      progress.value > 0
                          ? Image.asset(Assets.pngIconsUplaodSlim)
                          : Center(
                              child: Image.asset(
                                Assets.pngIconsUplaodSlim,
                                height: 48,
                                width: 48,
                              ),
                            ),
                      const SizedBox(height: 15),
                      Text(
                        progress.value > 0 ? "$title..." : "$title",
                        style: GoogleFonts.lato(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 5),
                      progress.value == 0
                          ? // only show instructions if nothing uploaded
                          desc != null
                              ? Text(
                                  desc.toString(),
                                  style: GoogleFonts.lato(
                                      fontSize: 12, color: Colors.grey),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "(Max file size: 5MB)",
                                      style: GoogleFonts.lato(
                                          fontSize: 12,
                                          color: AppColors.hintColor),
                                    ),
                                  ],
                                )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                Text(
                                    "  ${(progress * 100).toInt()}% Completed...")
                              ],
                            )
                    ],
                  ),
          ),
        ),
      );
    });
  }
}

class UploadBox2 extends StatelessWidget {
  final String title;
  final RxBool? isEdit;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final RxDouble progress;
  final String? desc;
  final Widget? imageWidget;
  final RxString fileName;

  const UploadBox2({
    super.key,
    required this.title,
    required this.onTap,
    this.onDelete,
    this.desc,
    this.imageWidget,
    this.isEdit,
    required this.progress,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isEditing = isEdit?.value ?? false;
      final uploading = progress.value > 0 && progress.value < 1;

      return DottedBorder(
        color: AppColors.hintColor.withOpacity(0.4),
        strokeWidth: 1,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 4],
        child: InkWell(
          onTap: isEditing ? null : onTap,
          child: SizedBox(
            width: double.infinity,
            child: isEditing
                ? Stack(
                    children: [
                      imageWidget ?? const SizedBox(),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: GestureDetector(
                          onTap: onDelete,
                          child: Image.asset(Assets.pngIconsDelete),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (uploading)
                          const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation(AppColors.primaryColor),
                          )
                        else
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor.withOpacity(0.05),
                            ),
                            child: Center(
                              child: Image.asset(
                                Assets.pngIconsUpload,
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        const SizedBox(height: 15),
                        Text(
                          uploading ? "Uploading $title..." : "Upload $title",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (uploading && fileName.value.isNotEmpty) ...[
                          const SizedBox(height: 5),
                          Text(
                            fileName.value,
                            style: AppTextStyles.getLato(
                              12,
                              4.weight,
                              Colors.grey,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
