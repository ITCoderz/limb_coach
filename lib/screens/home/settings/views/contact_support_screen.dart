import 'package:flutter/material.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class ContactSupportScreen extends StatelessWidget {
  final supportOptions = [
    {"title": "Email Support", "subtitle": "We’ll reply within 24 hours"},
    {"title": "Submit a Ticket", "subtitle": "Fill out application form"},
    {"title": "Live Chat", "subtitle": "Fast response for urgent issues"},
    {"title": "Phone Support", "subtitle": "Call us: +123 456 789"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Support")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Hello! How can we help you?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            20.ph,
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: supportOptions.map((opt) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: AppColors.hintColor.withOpacity(0.3)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(opt["title"]!,
                              style:
                                  AppTextStyles.getLato(14, FontWeight.w600)),
                          5.ph,
                          Text(opt["subtitle"]!,
                              style: AppTextStyles.getLato(
                                  12, FontWeight.w400, Colors.grey),
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
