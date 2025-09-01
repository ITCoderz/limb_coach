import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/my_schedule/controllers/schedule_controller.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_dropdown.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class AddMedicationTimingScreen extends StatelessWidget {
  AddMedicationTimingScreen({super.key});
  final c = Get.find<ScheduleController>();

  final medName = TextEditingController();
  final dosage = TextEditingController();
  final instructions = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Add Medication Timing"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tf("Medication Name", medName, "e.g., Paracetamol"),
            20.ph,
            _tf("Dosage", dosage, "e.g., 1 tablet • 500 mg"),
            20.ph,
            Obx(
              () => CustomDropdownField(
                  fieldLabel: 'Frequency',
                  items: ["Once", "Daily", "Weekly", "Specific Days"],
                  onChanged: (v) => c.frequency.value = v!,
                  value: c.frequency.value),
            ),
            20.ph,
            Obx(
              () => Row(
                children: [
                  /// DATE PICKER
                  Expanded(
                    child: CustomTextField(
                      label: "Date",
                      readOnly: true,
                      controller: TextEditingController(
                        text: c.selectedDate.value == null
                            ? ""
                            : "${c.selectedDate.value.day}/${c.selectedDate.value.month}/${c.selectedDate.value.year}",
                      ),
                      hintText: 'DD/MM/YYYY',
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: c.selectedDate.value,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          c.selectedDate.value = picked;
                        }
                      },
                    ),
                  ),
                  10.pw,

                  /// TIME PICKER
                  Expanded(
                    child: CustomTextField(
                      label: "Time",
                      readOnly: true,
                      controller: TextEditingController(
                        text: c.selectedTime.value,
                      ),
                      hintText: 'HH:MM',
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          final formatted = picked.format(context);
                          c.selectedTime.value = formatted;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            20.ph,
            _tf("Instructions*", instructions, "Type here...", maxLines: 4),
            12.ph,
            Text(
              "Set Reminder",
              style: AppTextStyles.getLato(16, 6.weight),
            ),
            10.ph,
            _freqRadios(),
            24.ph,
            Obx(() {
              final days = [
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
                "Sunday"
              ];
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: days.map((day) {
                  final isSelected = c.repeatDays.contains(day);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        c.repeatDays.remove(day);
                      } else {
                        c.repeatDays.add(day);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? AppColors.primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColors.borderColor, width: 0.8),
                      ),
                      child: Text(
                        day,
                        style: AppTextStyles.getLato(
                          14,
                          5.weight,
                          isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: "Add Medication Timings",
          onPressed: () {
            c.addEvent({
              "title": medName.text.isEmpty ? "Medication" : medName.text,
              "type": "Medication",
              "date": c.selectedDate.value,
              "time": c.selectedTime.value,
              "with": "",
              "location": "",
              "notes": instructions.text,
              "duration": "",
              "status": "upcoming",
            });
            Get.back();
          },
        ),
      ),
    );
  }

  Widget _tf(String label, TextEditingController ctrl, String hint,
      {int maxLines = 1}) {
    return CustomTextField(
      controller: ctrl,
      label: label,
      maxLines: maxLines,
      hintText: hint,
    );
  }

  Widget _freqRadios() {
    final opts = ["Once", "Daily", "Weekly", "Specific Days"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: opts
          .map((o) => Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: o,
                    groupValue: c.frequency.value,
                    onChanged: (v) => c.frequency.value = v!,
                    activeColor: AppColors.primaryColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  Text(o, style: AppTextStyles.getLato(12, 4.weight)),
                ],
              )))
          .toList(),
    );
  }
}
