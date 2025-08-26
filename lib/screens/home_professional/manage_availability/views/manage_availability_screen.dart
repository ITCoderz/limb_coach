// --------------------- Manage Availability Screen ---------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home_professional/manage_availability/controllers/manage_availability_controller.dart';
import 'package:mylimbcoach/screens/home_professional/manage_availability/views/available_slots_screen.dart';
import 'package:mylimbcoach/screens/home_professional/manage_availability/views/consultation_pricing_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:table_calendar/table_calendar.dart';

class ManageAvailabilityScreen extends StatelessWidget {
  ManageAvailabilityScreen({super.key});
  final AvailabilityController c = Get.put(AvailabilityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Manage Availability"),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Obx(() => TableCalendar(
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
                                color:
                                    AppColors.primaryColor.withOpacity(0.05)),
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
                        markerMargin: EdgeInsets.all(10),
                        cellMargin: EdgeInsets.all(10),
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Text("Available Slots:",
                      style: AppTextStyles.getLato(16, FontWeight.w600)),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(() => AvailableSlotsScreen());
                    },
                    child: Image.asset(
                      Assets.pngIconsPen,
                      height: 18,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Obx(() => GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3, // ✅ 3 per row
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 2.8,
                    children: c.allSlots.map((slot) {
                      bool isAvailable = c.availableSlots.contains(slot);
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: AppColors.borderColor, width: 0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          slot,
                          style: AppTextStyles.getLato(
                            14,
                            FontWeight.w500,
                            isAvailable
                                ? Colors.black
                                : AppColors.hintColor, // ✅ availability color
                          ),
                        ),
                      );
                    }).toList(),
                  )),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text("Consultation Type & Pricing:",
                      style: AppTextStyles.getLato(16, FontWeight.w600)),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(() => ConsultationPricingScreen());
                    },
                    child: Image.asset(
                      Assets.pngIconsPen,
                      height: 18,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Obx(() => Column(
                    children: c.consultationPrices.keys.map((type) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Radio<String>(
                              value: type,
                              groupValue: c.selectedConsultation.value,
                              onChanged: (val) =>
                                  c.selectedConsultation.value = val!,
                              activeColor: AppColors.primaryColor,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  type,
                                  style: AppTextStyles.getLato(
                                      14, FontWeight.w500),
                                ),
                                Text(
                                  "€${c.consultationPrices[type]}",
                                  style: AppTextStyles.getLato(
                                    12,
                                    4.weight,
                                    const Color(0xffA6A6A6),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )),
              20.ph,
            ],
          ),
        ),
      ),
    );
  }
}
