import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home/homepage/controllers/home_page_controller.dart';
import 'package:mylimbcoach/screens/home/start_consultation/views/call_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class StartConsultation extends StatelessWidget {
  StartConsultation({super.key});
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Start Consultation"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() => Column(
              children: List.generate(controller.consultations.length, (index) {
                final c = controller.consultations[index];
                return Container(
                  padding: const EdgeInsets.all(12.0),
                  margin: const EdgeInsets.symmetric(vertical: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColors.borderColor, width: 0.5)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "${c['image']}",
                                height: 59,
                              )),
                          10.pw,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${c["name"]} (${c["type"]})",
                                  style: AppTextStyles.getLato(13, 6.weight),
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
                                  style: AppTextStyles.getLato(10, 4.weight),
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
                            child: CustomButton(
                              onPressed: () => Get.to(() => CallScreen(
                                  name: "${c["name"]}",
                                  image: "${c['image']}")),
                              text: "Start Consultation",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            )),
      ),
    );
  }
}
