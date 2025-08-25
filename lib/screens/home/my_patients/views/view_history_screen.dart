import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

import '../../homepage/components/custom_app_bar.dart';

class ViewHistoryScreen extends StatelessWidget {
  final Map<String, dynamic> patient;

  const ViewHistoryScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        "View History",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Top Info ----------
            _infoRow("Date & Time:", "July 31, 2025 | 10:00 AM"),
            _infoRow("Patient Name:", patient["name"] ?? "-"),
            _infoRow("Consultation Type:", patient["type"] ?? "-"),
            _infoRow("Sessions:", "03"),
            20.ph,

            // ---------- Patient Summary ----------
            Text("Patient Summary:",
                style: AppTextStyles.getLato(16, 6.weight)),
            10.ph,
            _infoRow("Amputation Type:", "Quad Amputation"),
            _infoRow("Condition:", "Left Transfemoral"),
            _infoRow("Device:", "C-Leg 4"),
            _infoRow("Last Consult:", "August 01, 2025 | 06:00 PM"),
            20.ph,

            // ---------- Consultation History ----------
            Text("Consultation History:",
                style: AppTextStyles.getLato(16, 6.weight)),
            10.ph,
            _sessionTile("Session-01", "July 01, 2025, 08:18 AM", true, false),
            _sessionTile("Session-02", "July 20, 2025, 09:00 AM", true, false),
            _sessionTile("Session-03", "July 31, 2025, 01:00 PM", true, true),
            20.ph,

            // ---------- Notes & Recommendations ----------
            Text("Notes & Recommendations:",
                style: AppTextStyles.getLato(16, 6.weight)),
            10.ph,
            _noteCard(
                "Patient reported increased phantom limb sensations in the evenings.",
                "Suggested daily massage of the residual limb to provide new sensory input."),

            _noteCard(
                "Minor redness observed on the medical distal end of the residual limb.",
                "Advised patient to apply a thin layer of moisturizing cream at night."),

            _noteCard(
                "Patient expressed frustration with the prosthetic due to a recent fall.",
                "Provided encouragement and emphasized that falls are a normal part of the learning process."),

            20.ph,

            // ---------- Shared Resources ----------
            Text("Shared Resources:",
                style: AppTextStyles.getLato(16, 6.weight)),
            10.ph,
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
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTextStyles.getLato(
                13,
                4.weight,
              )),
          Text(value, style: AppTextStyles.getLato(13, 4.weight)),
        ],
      ),
    );
  }

  Widget _sessionTile(String title, String time, bool active, bool last) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Image.asset(Assets.pngIconsCircle, height: 16),
            if (!last)
              SizedBox(
                height: 50,
                child: DottedLine(
                    direction: Axis.vertical,
                    dashLength: 2,
                    dashGapLength: 2,
                    dashColor: AppColors.primaryColor),
              )
          ],
        ),
        10.pw,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.getLato(14, 6.weight)),
            5.ph,
            Text(time,
                style:
                    AppTextStyles.getLato(12, 4.weight, AppColors.hintColor)),
          ],
        ),
      ],
    );
  }

  Widget _noteCard(String report, String advised) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                Assets.pngIconsReport,
                height: 24,
              ),
              5.pw,
              Flexible(
                child: Text(
                  report,
                  style: AppTextStyles.getLato(13, 4.weight, Colors.black),
                ),
              ),
            ],
          ),
          10.ph,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                Assets.pngIconsAdvised,
                height: 24,
              ),
              5.pw,
              Flexible(
                child: Text(
                  advised,
                  style: AppTextStyles.getLato(13, 4.weight, Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fileTile(IconData icon, String fileName, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          10.pw,
          Text(fileName, style: AppTextStyles.getLato(13, 5.weight)),
        ],
      ),
    );
  }
}
