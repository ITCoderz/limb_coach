import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home/start_consultation/controllers/call_controller.dart';
import 'package:mylimbcoach/screens/home/start_consultation/views/consultation_summary_screen.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class CallScreen extends StatelessWidget {
  final String name;
  final String image;
  final controller = Get.put(CallController());

  CallScreen({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Obx(() => Stack(
              children: [
                // Background video placeholder
                Positioned.fill(
                  top: controller.isVideo.value ? 80 : 0,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),

                // Overlay
                Positioned.fill(
                  child: Container(
                    color: controller.isVideo.value
                        ? Colors.black.withOpacity(0.2)
                        : Colors.black.withOpacity(0.8),
                  ),
                ),

                // Name & Duration
                if (controller.isVideo.value)
                  Positioned(
                    top: 30,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            Assets.pngIconsBackIcon,
                            color: Colors.white,
                          ),
                        ),
                        Text(name,
                            style: AppTextStyles.getLato(
                                18, FontWeight.w600, Colors.white)),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(controller.callDuration.value,
                              style: AppTextStyles.getLato(
                                  14, FontWeight.w400, Colors.white70)),
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 186,
                          width: 186,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage(image), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                      10.ph,
                      Text(name,
                          style: AppTextStyles.getLato(
                              32, FontWeight.w600, Colors.white)),
                      10.ph,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(controller.callDuration.value,
                            style: AppTextStyles.getLato(
                                14, FontWeight.w400, Colors.white70)),
                      ),
                    ],
                  ),

                // Small preview (self video)
                if (controller.isVideo.value)
                  Positioned(
                    right: 20,
                    bottom: 140,
                    child: Container(
                      height: 120,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage(image), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                    ),
                  ),

                // Bottom controls
                Positioned(
                  bottom: 50,
                  left: 30,
                  right: 30,
                  child: Container(
                    height: 74,
                    width: 297,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.62),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _roundButton(Assets.pngIconsAddMember, Colors.white),
                        const SizedBox(width: 20),
                        _roundButton(Assets.pngIconsMic, Colors.white),
                        const SizedBox(width: 20),
                        controller.isVideo.value
                            ? _roundButton(Assets.pngIconsRotate, Colors.white,
                                onTap: () => controller.isVideo.toggle())
                            : _roundButton(
                                Assets.pngIconsVideo,
                                controller.isVideo.value
                                    ? Colors.white
                                    : Colors.grey,
                                onTap: () => controller.isVideo.toggle()),
                        const SizedBox(width: 20),
                        controller.isVideo.value
                            ? _roundButton(Assets.pngIconsSummary, Colors.red,
                                onTap: () {
                                Get.to(() => ConsultationSummaryScreen(
                                    name: name,
                                    type: "Video Call",
                                    dateTime: "July 31, 2025 | 10:00 AM",
                                    duration: "30 Minutes",
                                    notes:
                                        "Follow-up appointment to assess the fit and comfort of the new prosthetic socket provided two weeks ago. Patient also reported a minor increase in phantom limb sensations.",
                                    resources: [])); // end call
                              })
                            : _roundButton(Assets.pngIconsEndCall, Colors.red,
                                onTap: () {
                                Get.back(); // end call
                              }),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _roundButton(String icon, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.black54,
        child: Image.asset(
          icon,
        ),
      ),
    );
  }
}
