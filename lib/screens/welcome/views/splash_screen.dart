import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/welcome/controllers/splash_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart'; // <-- assuming you have AppColors

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 204,
              width: 233,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.pngIconsLogo),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Loading.. ${controller.progress.value.toInt()}%",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: controller.progress.value / 100,
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(2),
                      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                      minHeight: 6,
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
