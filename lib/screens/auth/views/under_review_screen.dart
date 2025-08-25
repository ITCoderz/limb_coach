import 'package:flutter/material.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/auth/views/sign_in_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class UnderReviewScreen extends StatelessWidget {
  const UnderReviewScreen({super.key});

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
                    text: "Go to Login",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignInScreen()));
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
                  Assets.pngIconsReview,
                  width: 234,
                ),
              ),
            ),
            15.ph,
            Text(
              "Your Application is Under Review!",
              style: AppTextStyles.getLato(20, 7.weight),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Text(
                "Thank you for registering with My Limb Coach. We are currently reviewing your professional credentials. This typically takes 24-48 hours. We will notify you via email once your profile has been verified",
                style: AppTextStyles.getLato(14, 4.weight),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}
