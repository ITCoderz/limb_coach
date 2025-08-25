import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home/homepage/views/home_page.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class ProfileCompletedScreen extends StatelessWidget {
  const ProfileCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomButton(
                    text: "Go to Home Page",
                    onPressed: () {
                      Get.offAll(() => DashboardScreen());
                    }),
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.pngIconsContactSupport),
                    GestureDetector(
                      onTap: () {},
                      child: Text("Contact Support",
                          style: AppTextStyles.getLato(
                              12, 4.weight, AppColors.primaryColor)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Image.asset(
                  Assets.pngIconsProfileComplete,
                  width: 234,
                ),
              ),
            ),
            15.ph,
            Text(
              "Profile Completed!",
              style: AppTextStyles.getLato(20, 7.weight),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Text(
                "Congratulations! You have set up your profile. You can now proceed to the home page",
                style: AppTextStyles.getLato(14, 4.weight),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}
