import 'package:flutter/material.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About My Limb Coach")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit..."
          "\n\nDe Finibus Bonorum et Malorum..."
          "\n\n1914 Translation by H. Rackham...",
          style: AppTextStyles.getLato(14, FontWeight.w400),
        ),
      ),
    );
  }
}
