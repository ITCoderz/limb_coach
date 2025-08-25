import 'dart:async';

import 'package:get/get.dart';
import 'package:mylimbcoach/screens/welcome/views/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  var progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _startLoading();
  }

  void _startLoading() {
    // increase progress every 30ms (3 seconds total)
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (progress.value >= 100) {
        timer.cancel();
        Get.offAll(() => const WelcomeScreen()); // logged in
      } else {
        progress.value += 1;
      }
    });
  }

  Future<void> _navigate() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    Get.offAll(() => const WelcomeScreen()); // logged in

    // if (token != null && token.isNotEmpty) {
    //   Get.offAll(() => const OnBoardingScreen()); // logged in
    // } else {
    //   Get.offAll(() => const WelcomeScreen()); // onboarding
    // }
  }
}
