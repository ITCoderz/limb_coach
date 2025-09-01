import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/consultation/views/consultation_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/my_schedule/controllers/schedule_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/my_schedule/views/add_custom_event_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/my_schedule/views/add_med_timing_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/my_schedule/views/add_training_plan_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/my_schedule/views/add_treatment_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/my_schedule/views/consultation_details_dialog.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home_professional/start_consultation/views/call_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:table_calendar/table_calendar.dart';

class MyScheduleScreen extends StatelessWidget {
  MyScheduleScreen({super.key});
  final c = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("My Schedule", widgets: [
        GestureDetector(
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.primaryColor.withOpacity(0.05),
            ),
            child: Icon(Icons.add, size: 30, color: AppColors.primaryColor),
          ),
          onTap: () => _showQuickActions(context),
        ),
        10.pw,
      ]),
      body: Obx(() {
        final dayEvents = c.eventsForDay(c.selectedDate.value);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _calendar(),
              14.ph,
              Row(
                children: [
                  Text(
                    "Events for ${_fmtDate(c.selectedDate.value)}",
                    style: AppTextStyles.getLato(14, 6.weight),
                  ),
                ],
              ),
              10.ph,
              if (dayEvents.isEmpty)
                _empty()
              else
                Column(
                  children: List.generate(dayEvents.length, (i) {
                    final e = dayEvents[i];
                    return _eventTile(e, i);
                  }),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _calendar() {
    return Obx(() => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.borderColor, width: 0.5)),
          child: TableCalendar(
            rowHeight: 50,
            firstDay: DateTime.now(),
            lastDay: DateTime(2030),
            focusedDay: c.selectedDate.value,
            selectedDayPredicate: (day) => isSameDay(c.selectedDate.value, day),
            onDaySelected: (d, f) => c.selectedDate.value = d,

            // ✅ load events
            eventLoader: (day) => c.eventsForDay(day),

            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primaryColor.withOpacity(0.05)),
                  child: Icon(Icons.chevron_left,
                      size: 18, color: AppColors.primaryColor)),
              rightChevronIcon: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primaryColor),
                  child: Icon(Icons.chevron_right,
                      size: 18, color: AppColors.whiteColor)),
              titleTextStyle: AppTextStyles.getLato(16, FontWeight.w600),
            ),

            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              cellPadding: EdgeInsets.zero,
              defaultDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
              ),
              weekendDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
              ),
              outsideDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
              ),
              todayDecoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              selectedTextStyle:
                  AppTextStyles.getLato(14, FontWeight.w600, Colors.white),
              todayTextStyle:
                  AppTextStyles.getLato(14, FontWeight.w600, Colors.black),
              disabledTextStyle:
                  AppTextStyles.getLato(14, FontWeight.w500, Colors.grey),
            ),

            // 🔴 custom marker
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        ));
  }

  String _iconForType(String type) {
    switch (type) {
      case "Consultation":
        return Assets.pngIconsAllConsultation;
      case "Medication":
        return Assets.pngIconsTreatmentTherapy;
      case "Training Plan":
        return Assets.pngIconsAddTrainingPlan;
      case "Treatment/Therapy":
        return Assets.pngIconsTreatmentTherapy;
      case "Custom Event":
        return Assets.pngIconsCustomEvent;
      default:
        return Assets.pngIconsAllConsultation; // fallback
    }
  }

  Widget _eventTile(Map<String, dynamic> e, int indexInDayList) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderColor, width: 0.5),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Image.asset(_iconForType(e["type"] ?? "")),
        ),
        title:
            Text(e["title"] ?? "-", style: AppTextStyles.getLato(13, 6.weight)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${e["with"] ?? ""}",
              style: AppTextStyles.getLato(11, 4.weight, AppColors.hintColor),
            ),
            5.ph,
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor.withOpacity(0.05)),
              child: Text(
                "Date: ${e["date"] != null ? DateFormat('dd/MM/yyyy').format(e["date"]) : ""} "
                "Time: ${e["time"] ?? ""}",
                style: AppTextStyles.getLato(10, 4.weight),
              ),
            ),
          ],
        ),
        trailing: ((e["type"] ?? "") == "Consultation")
            ? GestureDetector(
                onTap: () {
                  Get.to(() =>
                      CallScreen(name: 'Dr Smith', image: Assets.pngIconsDr));
                },
                child: Container(
                    height: 30,
                    width: 91,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "Join Video Call",
                        style: AppTextStyles.getLato(
                            12, 4.weight, AppColors.whiteColor),
                      ),
                    )),
              )
            : GestureDetector(
                onTap: () {
                  // Get.to(() =>
                  //     CallScreen(name: 'Dr Smith', image: Assets.pngIconsDr));
                },
                child: Container(
                    height: 30,
                    width: 91,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "View Plan",
                        style: AppTextStyles.getLato(
                            12, 4.weight, AppColors.whiteColor),
                      ),
                    )),
              ),
        onTap: () {
          // go to edit/details
          Get.dialog(ConsultationDialog(e));
        },
      ),
    );
  }

  Widget _empty() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.borderColor, width: 0.5),
        ),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.06),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.event_busy, size: 18),
            ),
            10.pw,
            Expanded(
              child: Text(
                "No events for this date",
                style: AppTextStyles.getLato(12, 5.weight, AppColors.hintColor),
              ),
            ),
          ],
        ),
      );

  // Quick Actions (+)
  void _showQuickActions(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title:
            Text("Add New Event", style: AppTextStyles.getLato(16, 6.weight)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: _quickAction(
                      Assets.pngIconsMedTiming,
                      "Medication Timing",
                      () => Get.off(() => AddMedicationTimingScreen())),
                ),
                10.pw,
                Expanded(
                  child: _quickAction(
                      Assets.pngIconsBookConsultation,
                      "Add Consultation",
                      () => Get.off(() => ConsultationFlow(
                            screenTitle: 'Add Consultation',
                          ))),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _quickAction(
                      Assets.pngIconsAddTrainingPlan,
                      "Add Training Plan",
                      () => Get.off(() => AddTrainingPlanScreen())),
                ),
                10.pw,
                Expanded(
                  child: _quickAction(
                      Assets.pngIconsTreatmentTherapy,
                      "Treatment/Therapy",
                      () => Get.off(() => AddTreatmentScreen())),
                ),
              ],
            ),
            _quickAction(Assets.pngIconsCustomEvent, "Add Custom Event",
                () => Get.off(() => AddCustomEventScreen()))
          ],
        ),
      ),
    );
  }

  Widget _quickAction(String icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.borderColor, width: 0.5)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(icon, height: 35),
              SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.getLato(12, 5.weight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) => "${_month(d.month)} ${d.day}, ${d.year}";
  String _month(int m) => const [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
      ][m - 1];
}
