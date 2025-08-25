import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home/settings/controllers/settings_controller.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';

class LanguageScreen extends StatelessWidget {
  final c = Get.find<SettingsController>();

  final languages = [
    "English (USA)",
    "English (UK)",
    "African",
    "French",
    "German",
    "Chinese",
    "Japanese",
    "Korean",
    "Portuguese",
    "Spanish",
    "Italian"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Language")),
      body: Obx(() => ListView(
            children: languages.map((lang) {
              return RadioListTile(
                title: Text(lang,
                    style: AppTextStyles.getLato(14, FontWeight.w500)),
                value: lang,
                groupValue: c.selectedLanguage.value,
                onChanged: (val) => c.selectedLanguage.value = val!,
              );
            }).toList(),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text("Save Changes"),
        ),
      ),
    );
  }
}
