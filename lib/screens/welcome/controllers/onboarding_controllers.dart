import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  late PageController pageController;

  final pages = [
    {
      "image": Assets.pngIconsImage1, // replace with your asset paths
      "title": "Find Your Perfect Fit",
      "description":
          "Browse a wide selection of prosthetic devices from trusted vendors.",
    },
    {
      "image": Assets.pngIconsImage2,
      "title": "Connect with Experts",
      "description":
          "Schedule consultations and chat securely with certified prosthetists and therapists.",
    },
    {
      "image": Assets.pngIconsImage3,
      "title": "Start Your Journey",
      "description": "Welcome! Join our community to start your journey.",
    },
  ];
  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login/signup
      // Get.offAll(() => const LoginScreen());
    }
  }

  void skip() {
    pageController.jumpToPage(pages.length - 1);
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }
}
