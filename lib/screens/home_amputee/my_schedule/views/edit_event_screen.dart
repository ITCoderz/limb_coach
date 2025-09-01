import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/my_schedule/controllers/schedule_controller.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class EditEventScreen extends StatelessWidget {
  final Map<String, dynamic> event;
  EditEventScreen({super.key, required this.event});
  final c = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    // initialize selected time
    if ((event["time"] ?? "").toString().isNotEmpty) {
      c.selectedTime.value = event["time"];
    }
    return Scaffold(
      appBar: customAppBar("Edit Event"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event["title"] ?? "-",
                style: AppTextStyles.getLato(14, 6.weight)),
            5.ph,
            Text(event["with"] ?? "-",
                style:
                    AppTextStyles.getLato(13, 4.weight, AppColors.hintColor)),
            10.ph,
            Text("Available Slots:",
                style: AppTextStyles.getLato(16, 6.weight)),
            8.ph,
            // ---- Slots Grid (your exact snippet) ----
            Obx(() => GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.8,
                  children: c.availableSlots.map((slot) {
                    final selected = c.selectedTime.value == slot;
                    return GestureDetector(
                      onTap: () => c.setTime(slot),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color:
                              selected ? AppColors.primaryColor : Colors.white,
                          border: Border.all(
                              color: AppColors.borderColor, width: 0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          slot,
                          style: AppTextStyles.getLato(
                            14,
                            FontWeight.w500,
                            selected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )),
            18.ph,
            Text("Consultation Type:",
                style: AppTextStyles.getLato(16, 6.weight)),
            6.ph,
            _typeRadios(),
            16.ph,
            Text("Set Reminder:", style: AppTextStyles.getLato(16, 6.weight)),
            6.ph,
            _reminderRadios(),
            16.ph,
            CustomTextField(
              maxLines: 4,
              hintText: "Add notes...",
              label: 'Notes',
              maxLength: 200,
              controller: TextEditingController(),
            ),
            30.ph,
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: "Save Event",
          onPressed: () {
            final idx = c.events.indexOf(event);
            if (idx != -1) {
              final updated = Map<String, dynamic>.from(event)
                ..["time"] = c.selectedTime.value
                ..["with"] = c.consultationType.value;
              c.updateEvent(idx, updated);
            }
            Get.back();
          },
        ),
      ),
    );
  }

  Widget _typeRadios() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _radio("Video Call", "Convenient online consultation",
            group: c.consultationType),
        14.ph,
        _radio("In-Person Visit", "Visit clinic at professional's location",
            group: c.consultationType),
      ],
    );
  }

  Widget _reminderRadios() {
    final opts = [
      "At Time of Event",
      "5 Mins Before",
      "15 Mins Before",
      "30 Mins Before",
      "1 Hour Before",
      "1 Day Before"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: opts.map((o) => _radio(o, "", group: c.reminderWhen)).toList(),
    );
  }

  Widget _radio(String label, String desc, {required RxString group}) {
    return Obx(() => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              value: label,
              groupValue: group.value,
              onChanged: (v) => group.value = v!,
              activeColor: AppColors.primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            5.pw,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.getLato(14, 5.weight)),
                if (desc.isNotEmpty)
                  Text(desc,
                      style: AppTextStyles.getLato(
                          12, 4.weight, AppColors.hintColor)),
              ],
            ),
          ],
        ));
  }
}
