import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class UploadBox extends StatelessWidget {
  final String title;
  final RxBool? isEdit;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final RxDouble progress;
  final String? desc;
  final Widget? imageWidget;
  final RxString fileName;

  const UploadBox({
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
