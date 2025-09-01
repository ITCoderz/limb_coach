import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/screens/home_amputee/my_schedule/controllers/schedule_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/my_schedule/views/edit_event_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class ConsultationDialog extends StatelessWidget {
  final Map<String, dynamic> e;
  const ConsultationDialog(this.e, {super.key});

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
            "${e['title']}",
            textAlign: TextAlign.center,
            style: AppTextStyles.getLato(16, 6.weight),
          ),
          Text(
            "With ${e['with']}",
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
              "Date & Time: ${DateFormat("MMMM dd, yyyy | hh:mm a").format(e['date'])}  ${e['time']}",
              style: AppTextStyles.getLato(10, 4.weight),
            ),
          ),
          20.ph,

          // Link
          if (e['link'] != null && e['link'].toString().isNotEmpty) ...[
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
                e['link'],
                textAlign: TextAlign.left,
                style:
                    AppTextStyles.getLato(11, 4.weight, AppColors.primaryColor),
              ),
            ),
            const SizedBox(height: 8),
          ],
          20.ph,
          // Notes
          if (e['notes'].isNotEmpty) ...[
            Text(
              "Notes:",
              style: AppTextStyles.getLato(13, 6.weight),
            ),
            const SizedBox(height: 4),
            Text(
              e['notes'],
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(13, 4.weight, Colors.black54),
            ),
          ],
          20.ph,
          if (e['duration'].isNotEmpty) ...[
            Text(
              "Set Reminder:",
              style: AppTextStyles.getLato(13, 6.weight),
            ),
            const SizedBox(height: 4),
            Text(
              e['duration'] + " Before ",
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
                    if (Get.find<ScheduleController>().events.contains(e)) {
                      Get.find<ScheduleController>().events.remove(e);
                    }
                    Get.back();
                  },
                  child: Text(
                    "Cancel Event",
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
                  text: "Edit Event",
                  onPressed: () {
                    Get.back();
                    Get.to(() => EditEventScreen(
                          event: e,
                        ));
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
