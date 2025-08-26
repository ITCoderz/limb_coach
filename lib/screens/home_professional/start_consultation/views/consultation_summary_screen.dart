import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class ConsultationSummaryScreen extends StatelessWidget {
  final String name;
  final String type;
  final String dateTime;
  final String duration;
  final String notes;
  final List<Map<String, String>>
      resources; // [{name: 'file.pdf', path: '...'}]

  const ConsultationSummaryScreen({
    super.key,
    required this.name,
    required this.type,
    required this.dateTime,
    required this.duration,
    required this.notes,
    required this.resources,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Consultation Summary'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _rowItem("Date & Time", dateTime),
            _rowItem("Patient", name),
            _rowItem("Consultation Type", type),
            _rowItem("Duration", duration),
            const SizedBox(height: 20),
            Text("Consultation Notes",
                style: AppTextStyles.getLato(16, FontWeight.w600)),
            const SizedBox(height: 6),
            Text(notes, style: AppTextStyles.getLato(13, FontWeight.w400)),
            const SizedBox(height: 20),
            Text("Shared Resources",
                style: AppTextStyles.getLato(16, FontWeight.w600)),
            const SizedBox(height: 8),
            // ...resources.map((r) => ListTile(
            //       leading: const Icon(Icons.insert_drive_file,
            //           color: AppColors.primaryColor),
            //       title: Text(r["name"] ?? ""),
            //       onTap: () {
            //         // open resource
            //       },
            //     )),
            Container(
              height: 45,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.borderColor, width: 0.5)),
              child: Row(
                children: [
                  Image.asset(Assets.pngIconsPdfSources),
                  10.pw,
                  Text(
                    "Home_Exercise_Plan.pdf",
                    style: AppTextStyles.getLato(13, 4.weight),
                  )
                ],
              ),
            ),
            10.ph,
            Container(
              height: 45,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.borderColor, width: 0.5)),
              child: Row(
                children: [
                  Image.asset(Assets.pngIconsPhotoSources),
                  10.pw,
                  Text(
                    "Before_Adjustment.jpg",
                    style: AppTextStyles.getLato(13, 4.weight),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      fixedSize: Size(162, 45),
                      side:
                          BorderSide(color: AppColors.primaryColor, width: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                    child: Text(
                      "Discard",
                      style: AppTextStyles.getLato(
                          16, 4.weight, AppColors.primaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      // Save & Finish logic
                      Get.back();
                      Get.back();
                    },
                    text: "Save & Finish",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _rowItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 130,
              child: Text(label,
                  style: AppTextStyles.getLato(13, FontWeight.w400))),
          Text(value, style: AppTextStyles.getLato(13, FontWeight.w400)),
        ],
      ),
    );
  }
}
