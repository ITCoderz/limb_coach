import 'package:flutter/material.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("About My Limb Coach"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AboutParagraph(
                title: "Standard Lorem Ipsum Passage:",
                description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi. "
                    "Aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit. "
                    "Velit esse cillum dolore eu fugiat nulla pariatur. "
                    "Excepteur sint occaecat cupidatat non proident. "
                    "Sunt in culpa qui officia deserunt mollit anim id est laborum. "
                    "Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. "
                    "Sed nisi. Nulla quis sem at nibh elementum imperdiet.",
              ),
              16.ph,
              AboutParagraph(
                title: "Why Use It?",
                description:
                    "It is a long established fact that a reader will be distracted by readable content. "
                    "The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters. "
                    "It makes the text look like readable English. "
                    "Many desktop publishing packages and web editors now use it as their default. "
                    "Sometimes by accident, sometimes on purpose. "
                    "It helps designers focus on layout instead of words. "
                    "Readers can judge the structure without being distracted by meaning. "
                    "This saves time in design and review stages. "
                    "It also provides balance in paragraph flow. "
                    "Thus, it continues to be widely adopted across industries.",
              ),
              16.ph,
              AboutParagraph(
                title: "Where Does It Come From?",
                description:
                    "Contrary to popular belief, Lorem Ipsum is not random text. "
                    "It originates from a piece of classical Latin literature written in 45 BC. "
                    "Richard McClintock, a Latin professor, discovered its source. "
                    "The text comes from sections of Cicero's writings. "
                    "It has been used for centuries in typesetting. "
                    "Even before computers, it was a standard for printers. "
                    "Its enduring presence shows its usefulness. "
                    "Over the years, many variations evolved. "
                    "Some injected humor, others added non-standard words. "
                    "But the core roots remain classical Latin passages.",
              ),
              16.ph,
              AboutParagraph(
                title: "Where Can I Get Some?",
                description:
                    "There are many websites offering Lorem Ipsum generators. "
                    "Most provide text in varying lengths and structures. "
                    "Users can specify paragraphs, words, or sentences. "
                    "Some even offer themed Ipsum versions. "
                    "Designers often copy and paste directly from these tools. "
                    "They ensure text fits layouts realistically. "
                    "Open-source libraries also exist for developers. "
                    "They integrate generators directly into apps or CMS. "
                    "This makes placeholder creation effortless. "
                    "Anyone can access them online free of cost.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔹 Reusable Paragraph Widget
class AboutParagraph extends StatelessWidget {
  final String title;
  final String description;

  const AboutParagraph({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.getLato(16, FontWeight.w600),
        ),
        10.ph,
        Text(
          description,
          style: AppTextStyles.getLato(14, FontWeight.w400),
        ),
      ],
    );
  }
}
