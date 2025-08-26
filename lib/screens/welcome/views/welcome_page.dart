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
    final userTypeController =
        Get.find<UserTypeController>(); // ✅ global access

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
                        onTap: () => userTypeController.setLoginType(0),
                        child: Container(
                          height: 122,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: userTypeController.isAmputee()
                                  ? AppColors.primaryColor
                                  : const Color(0xffDEDEDE),
                              width: userTypeController.isAmputee() ? 1 : 0.5,
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
                                  child: Image.asset(
                                    Assets.pngIconsAmpute,
                                    height: 28,
                                  ),
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
                        onTap: () => userTypeController.setLoginType(1),
                        child: Container(
                          height: 122,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: userTypeController.isProfessional()
                                  ? AppColors.primaryColor
                                  : const Color(0xffDEDEDE),
                              width:
                                  userTypeController.isProfessional() ? 1 : 0.5,
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
                                  child: Image.asset(
                                    Assets.pngIconsProfessional,
                                    height: 28,
                                  ),
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
            CustomButton(
              onPressed: () {
                if (userTypeController.loginType == 0) {
                  // 👇 amputee flow
                  Get.to(() => const OnBoardingScreen());
                } else {
                  // 👇 professional flow
                  Get.to(() => const OnBoardingScreen());
                }
              },
              text: "Continue",
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}
