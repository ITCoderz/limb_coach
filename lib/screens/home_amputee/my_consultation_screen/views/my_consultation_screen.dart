import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/consultation/views/consultation_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/my_consultation_screen/controllers/my_consultation_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/my_consultation_screen/views/consultation_detail.dart';
import 'package:mylimbcoach/screens/home_amputee/my_consultation_screen/views/filter.dart';
import 'package:mylimbcoach/screens/home_amputee/my_schedule/views/consultation_details_dialog.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home_professional/start_consultation/views/call_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class MyConsultationsPage extends StatelessWidget {
  final MyConsultationController c = Get.put(MyConsultationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("My Consultations", widgets: [
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
          onTap: () => Get.to(() => ConsultationFlow(
                screenTitle: "Add Consultation",
              )),
        ),
        10.pw,
      ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            10.ph,
            Row(
              children: [
                Expanded(child: _buildSearchBar(c)),
                10.pw,
                GestureDetector(
                    onTap: () => Get.to(() => ConsultationFilterPage()),
                    child: Container(
                      height: 48,
                      width: 79,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: AppColors.borderColor, width: 0.5)),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.pngIconsFilter,
                            height: 22,
                          ),
                          5.pw,
                          Text(
                            "Filter",
                            style: AppTextStyles.getLato(13, 4.weight),
                          )
                        ],
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                Expanded(child: _tabButton("Upcoming", 0, c)),
                Expanded(child: _tabButton("Past", 1, c)),
              ],
            ),
            20.ph,
            Obx(
              () => Row(
                children: [
                  Text(
                      c.selectedTab.value == 0
                          ? "Upcoming Consultation"
                          : "Past Consultation",
                      style: AppTextStyles.getLato(18, 6.weight)),
                  Text(
                      " (${(c.selectedTab.value == 0 ? c.upcomingConsultations : c.pastConsultations).length})",
                      style: AppTextStyles.getLato(
                          16, 4.weight, AppColors.hintColor)),
                ],
              ),
            ),
            20.ph,
            Expanded(
              child: Obx(() {
                final list = c.selectedTab.value == 0
                    ? c.upcomingConsultations
                    : c.pastConsultations;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, i) => _consultationCard(list[i]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Search Bar
  Widget _buildSearchBar(MyConsultationController controller) {
    return SizedBox(
      height: 48,
      child: TextField(
        onChanged: (value) => controller.searchText.value = value,
        decoration: InputDecoration(
          hintText: 'Search..here.',
          hintStyle:
              AppTextStyles.getLato(13, 4.weight, const Color(0xffA6A6A6)),
          prefixIcon: const Icon(Icons.search, color: Color(0xffA6A6A6)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
        ),
      ),
    );
  }

  /// ---------------- Tabs ----------------
  Widget _tabButton(String title, int index, MyConsultationController c) {
    return GestureDetector(
      onTap: () {
        c.selectedTab.value = index;
      },
      child: Obx(() => Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: c.selectedTab.value == index
                      ? AppColors.primaryColor
                      : AppColors.borderColor,
                  width: c.selectedTab.value == index ? 2 : 0.5,
                ),
              ),
            ),
            child: Text(
              title.toUpperCase(),
              style: AppTextStyles.getLato(
                13,
                c.selectedTab.value == index ? 7.weight : 4.weight,
                c.selectedTab.value == index
                    ? AppColors.primaryColor
                    : AppColors.hintColor,
              ),
            ),
          )),
    );
  }

  Widget _consultationCard(Map<String, dynamic> e) {
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
          child: ((e["type"] ?? "") == "Consultation")
              ? Image.asset(Assets.pngIconsAllConsultation)
              : ((e["type"] ?? "") == "Medication")
                  ? Image.asset(Assets.pngIconsTreatmentTherapy)
                  : Image.asset(Assets.pngIconsAllConsultation),
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
        trailing: e["status"] == "upcoming"
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
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: e["status"] == "completed"
                            ? Colors.green.withOpacity(0.05)
                            : Colors.red.withOpacity(0.05)),
                    child: Text(
                      e["status"].toString().capitalize!,
                      style: AppTextStyles.getLato(
                          10,
                          4.weight,
                          e["status"] == "completed"
                              ? Colors.green
                              : Colors.red),
                    ),
                  ),
                ],
              ),
        onTap: () {
          if (e["status"] == "upcoming") {
            Get.dialog(ConsultationDialog(e));
          } else {
            Get.to(() => ConsultationDetailSummaryScreen(
                  name: e["with"] ?? "-",
                  type: e["type"] ?? "-",
                  title: e["title"] ?? "-",
                  dateTime: DateFormat('dd/MM/yyyy').format(e["date"]),
                  duration: e["duration"] ?? "30 min",
                  notes: e["notes"] ?? "",
                  resources: [],
                ));
          }
        },
      ),
    );
  }
}
