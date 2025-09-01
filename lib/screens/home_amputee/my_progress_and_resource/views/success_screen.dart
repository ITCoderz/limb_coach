import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/homepage/views/home_page.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(""),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Spacer(),
          Container(
              height: 69,
              width: 69,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.05),
                  shape: BoxShape.circle),
              child: Image.asset(
                Assets.pngIconsTickMark,
              )),
          10.ph,
          Text(
            "Plan Created Successfully!",
            style: AppTextStyles.getLato(24, 7.weight),
          ),
          12.ph,
          Text(
              "Your training plan has been created successfully. You can access it from “My Progress & Resources” section",
              style: AppTextStyles.getLato(14, 4.weight),
              textAlign: TextAlign.center),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.offAll(() => AmputeeDashboardScreen()),
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(context.width, 45),
                    side: BorderSide(color: AppColors.primaryColor, width: .8),
                  ),
                  child: Text("Go Back",
                      style: AppTextStyles.getLato(
                          16, 6.weight, AppColors.primaryColor)),
                ),
              ),
              10.pw,
              Expanded(
                  child: CustomButton(
                      text: "Continue Editing",
                      onPressed: () {
                        Get.back();
                      })),
            ],
          ),
        ]),
      ),
    );
  }
}
