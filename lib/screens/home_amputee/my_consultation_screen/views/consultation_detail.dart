import 'package:flutter/material.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class ConsultationDetailSummaryScreen extends StatelessWidget {
  final String name;
  final String title;
  final String type;
  final String dateTime;
  final String duration;
  final String notes;
  final List<Map<String, String>>
      resources; // [{name: 'file.pdf', path: '...'}]

  const ConsultationDetailSummaryScreen({
    super.key,
    required this.name,
    required this.type,
    required this.title,
    required this.dateTime,
    required this.duration,
    required this.notes,
    required this.resources,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _rowItem("Date & Time", dateTime),
            _rowItem("Patient", name),
            _rowItem("Consultation Type", type),
            _rowItem("Duration", duration),
            const SizedBox(height: 20),
            Text("Notes:", style: AppTextStyles.getLato(16, FontWeight.w600)),
            const SizedBox(height: 6),
            Text(notes, style: AppTextStyles.getLato(13, FontWeight.w400)),
            const SizedBox(height: 20),
            Text("Shared Resources",
                style: AppTextStyles.getLato(16, FontWeight.w600)),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            Text("Action Items:",
                style: AppTextStyles.getLato(16, FontWeight.w600)),
            15.ph,
            Text(
              "1. Apply padding as discussed",
              style: AppTextStyles.getLato(13, FontWeight.w400),
            ),
            SizedBox(height: 6), // spacing between lines
            Text(
              "2. Continue daily exercises (3 sets)",
              style: AppTextStyles.getLato(13, FontWeight.w400),
            ),
            SizedBox(height: 6),
            Text(
              "3. Schedule follow-up in 2 weeks",
              style: AppTextStyles.getLato(13, FontWeight.w400),
            ),
            const SizedBox(height: 20),
            Text("Follow-up:",
                style: AppTextStyles.getLato(16, FontWeight.w600)),
            5.ph,
            Row(
              children: [
                Text("Next follow-up recommended:",
                    style: AppTextStyles.getLato(13, FontWeight.w400)),
                Text(
                  " Aug 01, 2025:",
                  style: AppTextStyles.getLato(
                      13, FontWeight.w400, AppColors.primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 40),
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
