import 'package:flutter/material.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class ContactSupportScreen extends StatelessWidget {
  final supportOptions = [
    {
      "title": "Email Support",
      "subtitle": "We aim to respond within\n24-48 hours",
      "image": Assets.pngIconsMessages
    },
    {
      "title": "Submit a Ticket",
      "subtitle": "Get help directly in the\napplication",
      "image": Assets.pngIconsSubmitTicket
    },
    {
      "title": "Live Chat",
      "subtitle": "Real-Time assistance for\nurgent issues",
      "image": Assets.pngIconsContactSupportHeader
    },
    {
      "title": "Phone Support",
      "subtitle": "Get direct help via\n +310 9721847",
      "image": Assets.pngIconsPhoneSupport
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Contact Support"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            70.ph,
            Image.asset(
              Assets.pngIconsContactSupportHeader,
              height: 71,
            ),
            10.ph,
            Text("Hello! How can we help\nyou?",
                textAlign: TextAlign.center,
                style: AppTextStyles.getLato(
                  20,
                  6.weight,
                )),
            70.ph,
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: supportOptions.map((opt) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(width: 0.5, color: AppColors.borderColor),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    AppColors.primaryColor.withOpacity(0.08)),
                            child: Center(
                              child: Image.asset(
                                opt["image"]!,
                                height: opt["image"] ==
                                        Assets.pngIconsContactSupportHeader
                                    ? 22
                                    : 27,
                              ),
                            ),
                          ),
                          5.ph,
                          Text(opt["title"]!,
                              style:
                                  AppTextStyles.getLato(14, FontWeight.w500)),
                          5.ph,
                          Text(opt["subtitle"]!,
                              style: AppTextStyles.getLato(
                                  11, FontWeight.w400, AppColors.hintColor),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
