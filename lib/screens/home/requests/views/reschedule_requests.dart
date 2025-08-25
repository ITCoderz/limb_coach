import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home/requests/controller/requests_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class RescheduleRequestsConsultationScreen extends StatelessWidget {
  final RequestsConsultation consultation;
  const RescheduleRequestsConsultationScreen(this.consultation, {super.key});

  // Helper widget for Info Row
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.getLato(13, 4.weight)),
          Flexible(
            child: Text(
              value,
              style: AppTextStyles.getLato(13, 4.weight, Colors.black87),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final RequestsController c = Get.put(RequestsController());

    return Scaffold(
      appBar: customAppBar("Reschedule Consultation"),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              /// Submit Button
              CustomButton(
                text: "Send Reschedule Request",
                onPressed: () {
                  c.sendRescheduleRequest(consultation.id);
                },
              ),
            ],
          ),
        ),
      ),
      // important fix: allow resizing when keyboard opens
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Patient & Consultation Info
              _infoRow("Patient Name", consultation.patientName),
              _infoRow(
                  "Date & Time",
                  DateFormat("MMMM dd, yyyy | hh:mm a")
                      .format(consultation.dateTime)),
              _infoRow("Consultation Type", consultation.type),

              const SizedBox(height: 20),

              /// Date Picker Field
              Text("Re-schedule Consultation:",
                  style: AppTextStyles.getLato(16, 6.weight)),
              const SizedBox(height: 20),
              Obx(
                () => CustomTextField(
                  hintText: "DD/MM/YYYY",
                  label: "Date",
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      c.selectedDate.value = pickedDate;
                    }
                  },
                  controller: TextEditingController(
                    text: c.selectedDate.value != null
                        ? "${c.selectedDate.value!.day}/${c.selectedDate.value!.month}/${c.selectedDate.value!.year}"
                        : "",
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Available Slots
              Text("Available Slots:",
                  style: AppTextStyles.getLato(16, 6.weight)),
              const SizedBox(height: 10),
              Obx(
                () => GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.8,
                  children: c.availableSlots.map((slot) {
                    final isSelected = c.selectedSlot.value == slot;
                    return GestureDetector(
                      onTap: () => c.setSlot(slot),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.borderColor,
                            width: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          slot,
                          style: AppTextStyles.getLato(
                            14,
                            FontWeight.w500,
                            isSelected ? AppColors.whiteColor : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              /// Reason
              CustomTextField(
                hintText: "Type your reason here...",
                maxLines: 6,
                controller: c.reasonController,
                label: 'Reason for Re-schedule',
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class DateTimeText extends StatelessWidget {
  final DateTime dateTime;

  const DateTimeText({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat("MMMM dd, yyyy | hh:mm a").format(dateTime);

    return Text(
      formattedDate,
      style: AppTextStyles.getLato(12, FontWeight.w400),
    );
  }
}
