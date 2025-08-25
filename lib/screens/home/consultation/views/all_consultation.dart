import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home/consultation/controllers/consultation_controller.dart';
import 'package:mylimbcoach/screens/home/consultation/views/consultation_details_dialog.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home/start_consultation/views/call_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class AllConsultationsScreen extends StatelessWidget {
  final ConsultationController c = Get.put(ConsultationController());

  AllConsultationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("All Consultations"),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Search
              _buildSearchBar(),
              20.ph,
              // Tabs
              Row(
                children: [
                  _tab("TODAY", 0),
                  _tab("UPCOMING", 1),
                ],
              ),

              const Divider(height: 1),

              // Consultations list
              Expanded(
                child: c.selectedTab.value == 0
                    ? _consultationList(c.todayConsultations, true)
                    : _consultationList(c.upcomingConsultations, false),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Search Here...',
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

  Widget _tab(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => c.selectedTab.value = index,
        child: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: c.selectedTab.value == index
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(
                13,
                c.selectedTab.value == index ? 7.weight : 4.weight,
                c.selectedTab.value == index
                    ? AppColors.primaryColor
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _consultationList(RxList<Consultation> list, bool isToday) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            15.ph,
            Image.asset(
              Assets.pngIconsCancelConsultation,
              height: 69,
            ),
            15.ph,
            Text(
              "No Consultation?",
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(18, 6.weight),
            ),
            10.ph,
            Text(
              "Your consultations will show here once none've\nbook any consultation",
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(12, 5.weight, AppColors.hintColor),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        20.ph,
        Row(
          children: [
            Text(isToday ? "Today Consultations" : "Upcoming Consultations",
                style: AppTextStyles.getLato(18, 6.weight)),
            Text(" (${list.length})",
                style:
                    AppTextStyles.getLato(16, 4.weight, AppColors.hintColor)),
          ],
        ),
        Expanded(
          child: Obx(() => SingleChildScrollView(
                child: Column(
                  children: List.generate(list.length, (index) {
                    final c = list[index];
                    return Container(
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.borderColor, width: 0.5)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    c.image,
                                    height: 59,
                                  )),
                              10.pw,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${c.patientName} (${c.type})",
                                      style:
                                          AppTextStyles.getLato(13, 6.weight),
                                    ),
                                    5.ph,
                                    Text(
                                      "Amputation Type: ${c.type}",
                                      style: AppTextStyles.getLato(
                                          10, 4.weight, Color(0xffa6a6a6)),
                                    ),
                                    5.ph,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.primaryColor
                                              .withOpacity(0.05)),
                                      child: Text(
                                        "Date & Time: ${DateFormat("MMMM dd, yyyy | hh:mm a").format(c.dateTime)}  ${c.mode}",
                                        style:
                                            AppTextStyles.getLato(10, 4.weight),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          10.ph,
                          isToday
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                          fixedSize: Size(162, 45),
                                          side: BorderSide(
                                              color: AppColors.primaryColor,
                                              width: 0.5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.dialog(_cancelDialog(c.id));
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: AppTextStyles.getLato(14,
                                              4.weight, AppColors.primaryColor),
                                        ),
                                      ),
                                    ),
                                    10.pw,
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                          fixedSize: Size(162, 45),
                                          side: BorderSide(
                                              color: AppColors.primaryColor,
                                              width: 0.5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.dialog(
                                              ConsultationDetailsDialog(c));
                                        },
                                        child: Text(
                                          "Re-schedule",
                                          style: AppTextStyles.getLato(14,
                                              4.weight, AppColors.primaryColor),
                                        ),
                                      ),
                                    ),
                                    10.pw,
                                    Expanded(
                                      child: CustomButton(
                                        onPressed: () => Get.to(() =>
                                            CallScreen(
                                                name: c.patientName,
                                                image: Assets.pngIconsDp)),
                                        text: "Start",
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                          fixedSize: Size(162, 45),
                                          side: BorderSide(
                                              color: AppColors.primaryColor,
                                              width: 0.5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.dialog(_cancelDialog(c.id));
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: AppTextStyles.getLato(16,
                                              4.weight, AppColors.primaryColor),
                                        ),
                                      ),
                                    ),
                                    10.pw,
                                    Expanded(
                                      child: CustomButton(
                                        onPressed: () => Get.dialog(
                                            ConsultationDetailsDialog(c)),
                                        text: "Re-schedule",
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    );
                  }),
                ),
              )),
        ),
      ],
    );
  }

  Widget _cancelDialog(String id) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            15.ph,
            Image.asset(
              Assets.pngIconsCancelConsultation,
              height: 45,
            ),
            15.ph,
            Text(
              "Cancel Consultation?",
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(16, 6.weight),
            ),
            10.ph,
            Text(
              "Are you sure that you want to cancel the consultation? Once the consultation is cancelled, you’ve to re-schedule it",
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(13, 4.weight),
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(bottom: 20),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    fixedSize: Size(162, 45),
                    side: BorderSide(color: AppColors.primaryColor, width: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Go Back",
                    style: AppTextStyles.getLato(
                        16, 4.weight, AppColors.primaryColor),
                  ),
                ),
              ),
              10.pw,
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    c.cancelConsultation(id);
                  },
                  text: "Yes, Cancel",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
