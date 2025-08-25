import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home/settings/controllers/settings_controller.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';

class FAQScreen extends StatelessWidget {
  final c = Get.find<SettingsController>();

  final faqs = [
    "How do I set up my professional profile?",
    "What information is visible to amputee users?",
    "What if a patient needs to reschedule?",
    "How does the video call work?",
    "How do I manage my availability for booking?",
    "How do I post new content?",
    "How can I see how my content is performing?",
    "Is patient data secure and private?",
    "What if I need to report a patient review?"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Frequently Asked Questions")),
      body: Obx(() => ListView.builder(
            itemCount: faqs.length,
            itemBuilder: (_, i) {
              final isExpanded = c.expandedFaq.value == i;
              return ExpansionTile(
                title: Text(faqs[i],
                    style: AppTextStyles.getLato(14, FontWeight.w500)),
                initiallyExpanded: isExpanded,
                onExpansionChanged: (val) {
                  c.expandedFaq.value = val ? i : null;
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Sample answer for: ${faqs[i]}",
                      style: AppTextStyles.getLato(
                          13, FontWeight.w400, Colors.grey),
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
