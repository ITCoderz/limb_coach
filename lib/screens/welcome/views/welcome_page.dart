import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/welcome/controllers/welcome_controller.dart';
import 'package:mylimbcoach/screens/welcome/views/onboarding_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WelcomeController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            100.ph,
            Center(
              child: Image.asset(
                Assets.pngIconsLogo,
                height: 108,
                width: 123,
              ),
            ),
            70.ph,
            Text(
              "Welcome to Limb Coach!",
              style: AppTextStyles.getLato(26, FontWeight.w700),
            ),
            4.ph,
            Text(
              "Select your kind of logins",
              style: AppTextStyles.getLato(14, FontWeight.w400),
            ),
            30.ph,
            Obx(() => Row(
                  children: [
                    // 👉 Amputee
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectLoginType(0),
                        child: Container(
                          height: 122,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: controller.isSelected(0)
                                  ? AppColors.primaryColor
                                  : Color(0xffDEDEDE),
                              width: controller.isSelected(0) ? 1 : 0.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.transparent,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AppColors.primaryColor.withOpacity(0.05),
                                ),
                                child: Center(
                                  child: Image.asset(Assets.pngIconsAmpute),
                                ),
                              ),
                              5.ph,
                              Text(
                                "Amputee",
                                style: AppTextStyles.getLato(
                                  16,
                                  FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    10.pw,
                    // 👉 Professional
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectLoginType(1),
                        child: Container(
                          height: 122,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: controller.isSelected(1)
                                  ? AppColors.primaryColor
                                  : Color(0xffDEDEDE),
                              width: controller.isSelected(1) ? 1 : 0.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.transparent,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AppColors.primaryColor.withOpacity(0.05),
                                ),
                                child: Center(
                                  child:
                                      Image.asset(Assets.pngIconsProfessional),
                                ),
                              ),
                              5.ph,
                              Text(
                                "Professional",
                                style: AppTextStyles.getLato(
                                  16,
                                  FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            const Spacer(),
            Obx(() => CustomButton(
                  onPressed: controller.selectedLoginType.value == -1
                      ? () {} // disable until selection
                      : () {
                          // ✅ Use selected type for navigation
                          if (controller.selectedLoginType.value == 0) {
                            Get.to(() => const OnBoardingScreen());
                          } else {
                            Get.to(() => const OnBoardingScreen());
                          }
                        },
                  text: "Continue",
                )),
            10.ph,
          ],
        ),
      ),
    );
  }
}
