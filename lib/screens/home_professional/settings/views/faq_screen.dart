import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

/// 🔹 Controller
class FaqController extends GetxController {
  RxInt expandedIndex = (-1).obs;
  RxString searchQuery = "".obs;

  void toggleExpansion(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }
}

/// 🔹 Main FAQ Screen
class FAQScreen extends StatelessWidget {
  FAQScreen({super.key});

  final controller = Get.put(FaqController());

  final faqs = [
    {
      "q": "How do I set up my professional profile?",
      "a": "You can update your profile information from the Settings section."
    },
    {
      "q": "What information is visible to amputee users?",
      "a":
          "Only your public profile details and shared content will be visible."
    },
    {
      "q": "What if a patient needs to reschedule?",
      "a": "Patients can reschedule directly from their booking page."
    },
    {
      "q": "How does the video call work?",
      "a": "Video calls are integrated in-app using a secure service."
    },
    {
      "q": "How do I manage my availability for booking?",
      "a": "Go to availability settings to adjust your schedule."
    },
    {
      "q": "How do I post new content?",
      "a": "You can post articles, exercises, or updates in the Content tab."
    },
    {
      "q": "How can I see how my content is performing?",
      "a":
          "Content performance analytics are available in the Insights section."
    },
    {
      "q": "Is patient data secure and private?",
      "a": "Yes, all patient data is encrypted and stored securely."
    },
    {
      "q": "What if I need to report a patient review?",
      "a": "You can report reviews directly by tapping on the report option."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Frequently Asked Questions"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            10.ph,
            Expanded(
              child: Obx(() {
                final query = controller.searchQuery.value.toLowerCase();
                final filteredFaqs = faqs
                    .where((f) => f["q"]!.toLowerCase().contains(query))
                    .toList();

                return ListView.builder(
                  itemCount: filteredFaqs.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, i) {
                    final faq = filteredFaqs[i];
                    final actualIndex = faqs.indexOf(faq);
                    final isExpanded =
                        controller.expandedIndex.value == actualIndex;

                    return Obx(() => FaqTile(
                          index: actualIndex,
                          question: faq["q"]!,
                          answer: faq["a"]!,
                          isExpanded:
                              controller.expandedIndex.value == actualIndex,
                          onToggle: () =>
                              controller.toggleExpansion(actualIndex),
                        ));
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Search Bar
  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        onChanged: (val) => controller.searchQuery.value = val,
        decoration: InputDecoration(
          hintText: 'Search FAQs...',
          hintStyle: AppTextStyles.getLato(
            13,
            FontWeight.w400,
            const Color(0xffA6A6A6),
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xffA6A6A6)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
        ),
      ),
    );
  }
}

/// 🔹 Reusable FAQ Tile Widget
class FaqTile extends StatelessWidget {
  final int index;
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onToggle;

  const FaqTile({
    super.key,
    required this.index,
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.borderColor, width: 0.5),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 0,
      child: ExpansionTile(
        key: Key("$question-$isExpanded"),
        onExpansionChanged: (expanded) => onToggle(),
        initiallyExpanded: isExpanded,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          question,
          textAlign: TextAlign.left,
          style: AppTextStyles.getLato(
            14,
            FontWeight.w500,
            isExpanded ? AppColors.primaryColor : Colors.black,
          ),
        ),
        trailing: Icon(
          isExpanded ? Icons.expand_less : Icons.expand_more,
          color: Colors.black,
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.topLeft,
        shape: InputBorder.none,
        children: [
          Text(
            answer,
            textAlign: TextAlign.left,
            style: AppTextStyles.getLato(
              13,
              FontWeight.w400,
              Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
