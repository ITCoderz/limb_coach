import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/consultation/views/doctor_profile_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/consultation/views/filter_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/consultation/views/success_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/consultation_controller.dart';

class ConsultationFlow extends StatelessWidget {
  final c = Get.put(AmputeeConsultationController());
  final String screenTitle;
  ConsultationFlow({super.key, this.screenTitle = "Book Consultation"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(screenTitle),
      body: Column(
        children: [
          _stepIndicator(),
          Expanded(
            child: Obx(() {
              switch (c.step.value) {
                case 0:
                  return _consultationList();
                case 1:
                  return _slotBooking();
                case 2:
                  return _bookingSummary();
                default:
                  return SizedBox();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _stepIndicator() {
    return Obx(() {
      final step = c.step.value;
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: step >= 0 ? AppColors.primaryColor : AppColors.hintColor,
              size: 28,
            ),
            Expanded(
              child: DottedLine(
                  dashLength: 1,
                  lineThickness: 1,
                  dashColor: step >= 1
                      ? AppColors.primaryColor
                      : AppColors.hintColor.withOpacity(0.4)),
            ),
            Icon(Icons.check_circle,
                size: 28,
                color: step >= 1
                    ? AppColors.primaryColor
                    : AppColors.hintColor.withOpacity(0.4)),
            Expanded(
              child: DottedLine(
                  dashLength: 1,
                  lineThickness: 1,
                  dashColor: step >= 2
                      ? AppColors.primaryColor
                      : AppColors.hintColor.withOpacity(0.4)),
            ),
            Icon(Icons.check_circle,
                size: 28,
                color: step == 2
                    ? AppColors.primaryColor
                    : AppColors.hintColor.withOpacity(0.4)),
          ],
        ),
      );
    });
  }

  /// Step 1 → Consultation List
  Widget _consultationList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.ph,
          Text(
            "Select Professional:",
            style: AppTextStyles.getLato(24, 7.weight),
          ),
          20.ph,
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(child: _buildSearchBar()),
                10.pw,
                GestureDetector(
                  onTap: () async {
                    final result =
                        await Get.to(() => ConsultationFiltersScreen());
                    if (result != null && result is Map) {
                      final cats =
                          List<String>.from(result["categories"] ?? const []);
                      final rats =
                          List<String>.from(result["ratings"] ?? const []);
                      c.setFilters(cats, rats); // ✅ single place to set filters
                    }
                  },
                  child: Container(
                    height: 48,
                    width: 79,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: AppColors.borderColor, width: 0.5),
                    ),
                    child: Row(
                      children: [
                        Image.asset(Assets.pngIconsFilter, height: 22),
                        5.pw,
                        Text("Filter",
                            style: AppTextStyles.getLato(13, 4.weight)),
                      ],
                    ),
                  ),
                ),
                5.pw,
              ],
            ),
          ),
          20.ph,
          Row(
            children: [
              Text("Total Professional",
                  style: AppTextStyles.getLato(18, 6.weight)),
              Obx(() => Text(
                    " (${c.filteredDoctors.length})",
                    style: AppTextStyles.getLato(
                        16, 4.weight, AppColors.hintColor),
                  )),
            ],
          ),
          20.ph,
          Expanded(
            child: Obx(() {
              final results = c.filteredDoctors;

              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (_, i) {
                  final doc = results[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      onTap: () {
                        c.selectDoctor(doc);
                        Get.to(() => DoctorProfileScreen());
                      },
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(Assets.pngIconsDr)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                              color: AppColors.borderColor, width: 0.5)),
                      title: Text(doc["name"]!.toString(),
                          style: AppTextStyles.getLato(14, 6.weight)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc["category"],
                            style: AppTextStyles.getLato(
                                11, 4.weight, AppColors.hintColor),
                          ),
                          8.ph,
                          Row(
                            children: [
                              ...List.generate(
                                5,
                                (index) => Image.asset(
                                  Assets.pngIconsStar,
                                  height: 16,
                                  color: index < (doc["rating"] as num).toInt()
                                      ? Colors.amber // ⭐ active star
                                      : Colors.amber
                                          .withOpacity(0.4), // ☆ faded star
                                ),
                              ),
                              5.pw,
                              Text(
                                "(${doc["reviews"]} Reviews)",
                                style: AppTextStyles.getLato(11, 4.weight),
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: InkWell(
                        onTap: () {
                          c.selectDoctor(doc);
                          Get.to(() => DoctorProfileScreen());
                        },
                        child: Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              "View Profile",
                              style: AppTextStyles.getLato(
                                  12, 6.weight, AppColors.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }

  /// Step 2 → Slot Booking
  /// Step 1 → Slot Booking Screen
  Widget _slotBooking() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Your Date & Slot:",
                style: AppTextStyles.getLato(24, 7.weight)),
            10.ph,
            Text(
              "Choose a Date:",
              style: AppTextStyles.getLato(16, 6.weight),
            ),
            10.ph,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Obx(() => TableCalendar(
                    rowHeight: 40,
                    firstDay: DateTime.now(), // ✅ today = no past dates
                    lastDay: DateTime(2030),
                    focusedDay: c.selectedDate.value,
                    selectedDayPredicate: (day) {
                      return isSameDay(c.selectedDate.value, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      c.selectedDate.value = selectedDay;
                    },

                    // ✅ Header: Month-Year centered, chevrons on sides
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
                      titleTextStyle:
                          AppTextStyles.getLato(16, FontWeight.w600),
                    ),

                    // ✅ Styling Days
                    calendarStyle: CalendarStyle(
                      // Disable default circular background completely
                      markerMargin: EdgeInsets.all(6),
                      cellMargin:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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

                      // ✅ Today Style
                      todayDecoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.transparent,
                      ),

                      // ✅ Selected Day Style
                      selectedDecoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),

                      selectedTextStyle: AppTextStyles.getLato(
                        14,
                        FontWeight.w600,
                        Colors.white,
                      ),
                      todayTextStyle: AppTextStyles.getLato(
                        14,
                        FontWeight.w600,
                        Colors.black,
                      ),

                      disabledTextStyle: AppTextStyles.getLato(
                        14,
                        FontWeight.w500,
                        Colors.grey,
                      ),
                    ),
                  )),
            ),
            20.ph,
            Text("Available Slots:",
                style: AppTextStyles.getLato(16, 6.weight)),
            10.ph,
            Obx(() => GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
            25.ph,
            Text("Consultation Type:",
                style: AppTextStyles.getLato(16, 6.weight)),
            15.ph,
            Obx(() => Column(
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: "Video Call",
                          activeColor: AppColors.primaryColor,
                          groupValue: c.consultationType.value,
                          onChanged: (v) => c.consultationType.value = v!,
                          visualDensity:
                              VisualDensity.compact, // reduce tap area
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Video Call",
                              style: AppTextStyles.getLato(14, 5.weight),
                            ),
                            Text(
                              "Convenient online consultation",
                              style: AppTextStyles.getLato(
                                  12, 4.weight, AppColors.hintColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    5.ph,
                    Row(
                      children: [
                        Radio<String>(
                          value: "In-Person Visit",
                          groupValue: c.consultationType.value,
                          activeColor: AppColors.primaryColor,
                          onChanged: (v) => c.consultationType.value = v!,
                          visualDensity: VisualDensity.compact,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "In-Person Visit",
                              style: AppTextStyles.getLato(14, 5.weight),
                            ),
                            Text(
                              "Visit clinic at professional's location",
                              style: AppTextStyles.getLato(
                                  12, 4.weight, AppColors.hintColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
            20.ph,
            Text("Set Reminder:", style: AppTextStyles.getLato(16, 6.weight)),
            5.ph,
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...[
                      "At Time of Event",
                      "15 Mins Before",
                      "30 Mins Before",
                      "1 Hour Before",
                      "1 Day Before"
                    ].map((r) => Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: r,
                                groupValue: c.reminder.value,
                                activeColor: AppColors.primaryColor,
                                onChanged: (v) => c.reminder.value = v!,
                                materialTapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // ✅ smaller touch target
                                visualDensity:
                                    VisualDensity.compact, // ✅ reduces spacing
                              ),
                              Text(
                                r,
                                style:
                                    AppTextStyles.getLato(14, FontWeight.w400),
                              ),
                            ],
                          ),
                        ))
                  ],
                )),
            20.ph,
            CustomTextField(
              maxLines: 4,
              onChanged: (val) => c.note.value = val,
              label: "Add Notes",
              hintText: "Type here...",
              controller: TextEditingController(),
            ),
            20.ph,
            CustomButton(
                onPressed: () => c.nextStep(), text: "Confirm Booking"),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(String label) {
    return Obx(() => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: c.addToCalendar.value, // ✅ bound to controller
              activeColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              side: BorderSide(
                width: 1,
                color: AppColors.borderColor,
              ),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: c.toggleCalendar, // ✅ controller handles toggle
            ),
            Text(
              label,
              style: AppTextStyles.getLato(12, FontWeight.w400),
            ),
          ],
        ));
  }

  Widget _bookingSummary() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Booking Summary:",
                  style: AppTextStyles.getLato(24, 7.weight)),
              20.ph,
              Row(
                children: [
                  Image.asset(
                    Assets.pngIconsMySchedule,
                    height: 28,
                  ),
                  10.pw,
                  Text(DateFormat('MMMM d, y').format(c.selectedDate.value),
                      style: AppTextStyles.getLato(13, 4.weight)),
                ],
              ),
              10.ph,
              Row(
                children: [
                  Image.asset(
                    Assets.pngIconsHistory,
                    height: 28,
                  ),
                  10.pw,
                  Text(c.selectedTime.value,
                      style: AppTextStyles.getLato(13, 4.weight)),
                ],
              ),
              10.ph,
              Row(
                children: [
                  Image.asset(
                    Assets.pngIconsVideocam,
                    height: 28,
                  ),
                  10.pw,
                  Text(c.consultationType.value,
                      style: AppTextStyles.getLato(13, 4.weight)),
                ],
              ),
              10.ph,
              Row(
                children: [
                  Image.asset(
                    Assets.pngIconsReminder,
                    height: 28,
                  ),
                  10.pw,
                  Text("Reminder: ${c.reminder.value}",
                      style: AppTextStyles.getLato(13, 4.weight)),
                ],
              ),
              10.ph,
              Row(
                children: [
                  Image.asset(
                    Assets.pngIconsNotes,
                    height: 28,
                  ),
                  10.pw,
                  Text("Notes: ${c.note.value}",
                      style: AppTextStyles.getLato(13, 4.weight)),
                ],
              ),
              10.ph,
              Divider(),
              10.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Consultation Fee",
                      style: AppTextStyles.getLato(
                          14, 4.weight, AppColors.hintColor)),
                  Text("€100.00",
                      style: AppTextStyles.getLato(
                        22,
                        FontWeight.bold,
                      )),
                ],
              ),
              15.ph,
              _buildCheckbox("Add to my device calendar"),
              Spacer(),
              CustomButton(
                  onPressed: () {
                    Get.to(() => BookingSuccessScreen());
                  },
                  text: "Confirm Booking"),
            ],
          ),
        ));
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        autofocus: false,
        onChanged: (val) => c.query.value = val, // ✅ live search
        decoration: InputDecoration(
          hintText: 'Search professsionals......',
          hintStyle: AppTextStyles.getLato(13, 4.weight, Color(0xffA6A6A6)),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xffA6A6A6),
          ),
          filled: false,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
        ),
      ),
    );
  }
}
