import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home_professional/my_patients/controllers/my_patient_controller.dart';
import 'package:mylimbcoach/screens/home_professional/my_patients/views/view_history_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class MyPatients extends StatelessWidget {
  MyPatients({super.key});
  final controller = Get.put(MyPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("My Patients"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              20.ph,
              _buildSearchBar(),
              20.ph,
              Row(
                children: [
                  Text("Total Patients",
                      style: AppTextStyles.getLato(18, 6.weight)),
                  Text(" (2)",
                      style: AppTextStyles.getLato(
                          16, 4.weight, AppColors.hintColor)),
                ],
              ),
              20.ph,
              Obx(() => Column(
                    children:
                        List.generate(controller.consultations.length, (index) {
                      final c = controller.consultations[index];
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
                                    child: Image.asset(Assets.pngIconsDp)),
                                10.pw,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${c["name"]} (${c["type"]})",
                                        style:
                                            AppTextStyles.getLato(13, 6.weight),
                                      ),
                                      5.ph,
                                      Text(
                                        "Amputation Type: ${c["amputation"]}",
                                        style: AppTextStyles.getLato(
                                            10, 4.weight, Color(0xffa6a6a6)),
                                      ),
                                      5.ph,
                                      Text(
                                        "Date & Time: ${c["date"]}",
                                        style:
                                            AppTextStyles.getLato(10, 4.weight),
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
                                    onPressed: () {},
                                    child: Text(
                                      "Message",
                                      style: AppTextStyles.getLato(
                                          16, 4.weight, AppColors.primaryColor),
                                    ),
                                  ),
                                ),
                                10.pw,
                                Expanded(
                                  child: CustomButton(
                                    onPressed: () {
                                      Get.to(() => ViewHistoryScreen(
                                            patient: c,
                                          ));
                                    },
                                    text: "View History",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  )),
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
}
