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

class AddCustomEventScreen extends StatelessWidget {
  AddCustomEventScreen({super.key});
  final c = Get.find<ScheduleController>();
  final nameCtrl = TextEditingController();
  final notesCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Add Custom Event"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tf("Event Name*", nameCtrl, "Event Name"),
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
            _tf(
              "Notes*",
              notesCtrl,
              "Type here...",
              maxLines: 4,
            ),
            10.ph,
            Text("Set Reminder:", style: AppTextStyles.getLato(16, 6.weight)),
            6.ph,
            _freqRadios(),
            20.ph,
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: "Add Event",
          onPressed: () {
            c.addEvent({
              "title": nameCtrl.text.isEmpty ? "Custom Event" : nameCtrl.text,
              "type": "Custom",
              "date": c.selectedDate.value,
              "time": c.selectedTime.value.isEmpty
                  ? "10:00 AM"
                  : c.selectedTime.value,
              "with": "",
              "location": "",
              "notes": notesCtrl.text,
              "duration": "",
              "status": "upcoming",
            });
            Get.back();
          },
        ),
      ),
    );
  }

  Widget _dropdown(String label, List<String> items, RxString value) {
    return Obx(() => CustomDropdownField(
          fieldLabel: label,
          items: items,
          value: value.value,
          onChanged: (val) {
            value.value = val!;
          },
        ));
  }

  Widget _tf(String label, TextEditingController ctrl, String hint,
      {int maxLines = 1}) {
    return CustomTextField(
      controller: ctrl,
      maxLines: maxLines,
      hintText: hint,
      label: label,
    );
  }

  Widget _freqRadios() {
    final c = Get.find<ScheduleController>();
    final opts = ["Once", "Daily", "Weekly", "Specific Days"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
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

  String _fmtDate(DateTime d) => "${d.year}-${d.month}-${d.day}";
}
