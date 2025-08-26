import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/screens/home_professional/consultation/controllers/consultation_controller.dart';
import 'package:mylimbcoach/screens/home_professional/requests/controller/requests_controller.dart';
import 'package:mylimbcoach/screens/home_professional/requests/views/reschedule_requests.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

import 'reschedule_consultation_screen.dart';

class ConsultationDetailsDialog extends StatelessWidget {
  final Consultation consultation;
  const ConsultationDetailsDialog(this.consultation, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "Consultation Details:",
            style: AppTextStyles.getLato(16, 6.weight),
          ),
          20.ph,
          // Title
          Text(
            "${consultation.type} Appointment",
            textAlign: TextAlign.center,
            style: AppTextStyles.getLato(16, 6.weight),
          ),
          Text(
            "With ${consultation.patientName} (${consultation.type})",
            style: AppTextStyles.getLato(11, 4.weight, AppColors.hintColor),
          ),
          const SizedBox(height: 12),

          const SizedBox(height: 8),

          // Date
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryColor.withOpacity(0.05)),
            child: Text(
              "Date & Time: ${DateFormat("MMMM dd, yyyy | hh:mm a").format(consultation.dateTime)}  ${consultation.mode}",
              style: AppTextStyles.getLato(10, 4.weight),
            ),
          ),
          20.ph,

          // Link
          if (consultation.link.isNotEmpty) ...[
            Text(
              "Link:",
              style: AppTextStyles.getLato(13, 6.weight),
            ),
            const SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor.withOpacity(0.05)),
              child: Text(
                consultation.link,
                textAlign: TextAlign.left,
                style:
                    AppTextStyles.getLato(11, 4.weight, AppColors.primaryColor),
              ),
            ),
            const SizedBox(height: 8),
          ],
          20.ph,
          // Notes
          if (consultation.notes.isNotEmpty) ...[
            Text(
              "Notes:",
              style: AppTextStyles.getLato(13, 6.weight),
            ),
            const SizedBox(height: 4),
            Text(
              consultation.notes,
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(13, 4.weight, Colors.black54),
            ),
          ],
        ],
      ),
      actionsPadding: const EdgeInsets.only(bottom: 20),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // Cancel Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    fixedSize: const Size(162, 45),
                    side: BorderSide(color: AppColors.borderColor, width: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style: AppTextStyles.getLato(
                      16,
                      4.weight,
                      AppColors.hintColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Re-Schedule Button
              Expanded(
                child: CustomButton(
                  text: "Re-Schedule",
                  onPressed: () {
                    Get.back();
                    Get.to(() => RescheduleConsultationScreen(consultation));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RequestConsultationDetailsDialog extends StatelessWidget {
  final RequestsConsultation consultation;
  const RequestConsultationDetailsDialog(this.consultation, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "Consultation Details:",
            style: AppTextStyles.getLato(16, 6.weight),
          ),
          20.ph,
          // Title
          Text(
            "${consultation.type} Appointment",
            textAlign: TextAlign.center,
            style: AppTextStyles.getLato(16, 6.weight),
          ),
          Text(
            "With ${consultation.patientName} (${consultation.type})",
            style: AppTextStyles.getLato(11, 4.weight, AppColors.hintColor),
          ),
          const SizedBox(height: 12),

          const SizedBox(height: 8),

          // Date
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryColor.withOpacity(0.05)),
            child: Text(
              "Date & Time: ${DateFormat("MMMM dd, yyyy | hh:mm a").format(consultation.dateTime)}  ${consultation.mode}",
              style: AppTextStyles.getLato(10, 4.weight),
            ),
          ),
          20.ph,

          // Link
          if (consultation.link.isNotEmpty) ...[
            Text(
              "Link:",
              style: AppTextStyles.getLato(13, 6.weight),
            ),
            const SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor.withOpacity(0.05)),
              child: Text(
                consultation.link,
                textAlign: TextAlign.left,
                style:
                    AppTextStyles.getLato(11, 4.weight, AppColors.primaryColor),
              ),
            ),
            const SizedBox(height: 8),
          ],
          20.ph,
          // Notes
          if (consultation.notes.isNotEmpty) ...[
            Text(
              "Notes:",
              style: AppTextStyles.getLato(13, 6.weight),
            ),
            const SizedBox(height: 4),
            Text(
              consultation.notes,
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(13, 4.weight, Colors.black54),
            ),
          ],
        ],
      ),
      actionsPadding: const EdgeInsets.only(bottom: 20),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // Cancel Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    fixedSize: const Size(162, 45),
                    side: BorderSide(color: AppColors.borderColor, width: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style: AppTextStyles.getLato(
                      16,
                      4.weight,
                      AppColors.hintColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Re-Schedule Button
              Expanded(
                child: CustomButton(
                  text: "Re-Schedule",
                  onPressed: () {
                    Get.back();
                    Get.to(() =>
                        RescheduleRequestsConsultationScreen(consultation));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
