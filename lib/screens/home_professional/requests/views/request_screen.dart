import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/consultation/views/consultation_details_dialog.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home_professional/requests/controller/requests_controller.dart';
import 'package:mylimbcoach/screens/home_professional/requests/views/filter_screen.dart';
import 'package:mylimbcoach/screens/home_professional/start_consultation/views/call_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class RequestConsultationScreen extends StatelessWidget {
  final RequestsController c = Get.put(RequestsController());

  RequestConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("All Requests"),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Search
              SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Expanded(child: _buildSearchBar()),
                    10.pw,
                    GestureDetector(
                      onTap: () async {
                        final result = await Get.to(() => FiltersScreen());
                        if (result != null) {
                          print("✅ Applied Filters: $result");
                          c.setFilters(
                            result['statuses'],
                          );
                        }
                      },
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
                      ),
                    )
                  ],
                ),
              ),
              20.ph,
              // Tabs
              // Consultations list
              Expanded(
                child: _consultationList(c.filteredConsultations),
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
        onChanged: (val) => c.setSearch(val), // ✅ live search

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

  Widget _consultationList(
    RxList<RequestsConsultation> list,
  ) {
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
              "No Requests!",
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(18, 6.weight),
            ),
            10.ph,
            Text(
              "Consultation Requests from patients will show here ",
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
            Text("Total Requests", style: AppTextStyles.getLato(18, 6.weight)),
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
                                    Row(
                                      children: [
                                        Text(
                                          "${c.patientName} (${c.type})",
                                          style: AppTextStyles.getLato(
                                              13, 6.weight),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: c.status == "Completed"
                                                  ? Color(0xff16B900)
                                                      .withOpacity(0.05)
                                                  : c.status == "Pending"
                                                      ? Color(0xffE0731F)
                                                          .withOpacity(0.05)
                                                      : Colors.red
                                                          .withOpacity(0.05)),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                c.status == "Completed"
                                                    ? Assets.pngIconsCompleted
                                                    : Assets.pngIconsPending,
                                                height: 18,
                                              ),
                                              5.pw,
                                              Text(
                                                c.status,
                                                style: AppTextStyles.getLato(
                                                    12, 4.weight),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
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
                          Row(
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.dialog(_cancelDialog(c.id));
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: AppTextStyles.getLato(
                                        14, 4.weight, AppColors.primaryColor),
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.dialog(
                                        RequestConsultationDetailsDialog(c));
                                  },
                                  child: Text(
                                    "Re-schedule",
                                    style: AppTextStyles.getLato(
                                        14, 4.weight, AppColors.primaryColor),
                                  ),
                                ),
                              ),
                              10.pw,
                              Expanded(
                                child: CustomButton(
                                  onPressed: () {
                                    if (c.status == "Completed") {
                                      Get.to(() => CallScreen(
                                          name: c.patientName,
                                          image: Assets.pngIconsDp));
                                    } else {
                                      Get.dialog(_acceptDialog(c.id));
                                    }
                                  },
                                  text: c.status == "Pending"
                                      ? "Accept"
                                      : "Start",
                                ),
                              ),
                            ],
                          )
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
                    side: BorderSide(color: AppColors.borderColor, width: 0.5),
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
                        16, 4.weight, AppColors.hintColor),
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

  Widget _acceptDialog(String id) {
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
              "Accept Consultation?",
              textAlign: TextAlign.center,
              style: AppTextStyles.getLato(16, 6.weight),
            ),
            10.ph,
            Text(
              "Are you sure that you want to accept the consultation? ",
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
                    c.acceptConsultation(id);
                  },
                  text: "Accept",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
