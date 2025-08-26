import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/auth/views/sign_in_screen.dart';
import 'package:mylimbcoach/screens/auth/views/sign_up_screen.dart';
import 'package:mylimbcoach/screens/auth/views/signup_screen_amputee.dart';
import 'package:mylimbcoach/screens/welcome/controllers/onboarding_controllers.dart';
import 'package:mylimbcoach/screens/welcome/controllers/welcome_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Skip Button
              30.ph,
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => controller.skip(),
                  child: Text(
                    "Skip",
                    style:
                        AppTextStyles.getLato(16, 4.weight, Color(0xffA6A6A6)),
                  ),
                ),
              ),

              20.ph,

              // PageView
              Expanded(
                flex: 4,
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.pages.length,
                  itemBuilder: (context, index) {
                    final page = controller.pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Image.asset(
                              page["image"]!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        20.ph,
                        Text(
                          page["title"]!,
                          style: AppTextStyles.getLato(26, FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        10.ph,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            page["description"]!,
                            style: AppTextStyles.getLato(14, FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              30.ph,

              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.pages.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Bottom Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:
                    controller.currentPage.value == controller.pages.length - 1
                        ? Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    fixedSize: Size(162, 45),
                                    side: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (Get.find<UserTypeController>()
                                        .isAmputee()) {
                                      Get.to(() => SignUpScreenAmputee());
                                    } else {
                                      Get.to(() => SignUpScreen());
                                    }
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: AppTextStyles.getLato(
                                        16, 4.weight, AppColors.primaryColor),
                                  ),
                                ),
                              ),
                              10.pw,
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(162, 45),
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(() => SignInScreen());
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: AppTextStyles.getLato(
                                        16, 4.weight, Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : CustomButton(
                            onPressed: () => controller.nextPage(),
                            text: "Next",
                          ),
              ),

              30.ph,
            ],
          ),
        ),
      ),
    );
  }
}
