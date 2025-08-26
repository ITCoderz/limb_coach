import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home_professional/settings/controllers/settings_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class LanguageScreen extends StatelessWidget {
  final c = Get.find<SettingsController>();

  final languages = [
    {"name": "English (USA)", "code": "US"},
    {"name": "English (UK)", "code": "GB"},
    {"name": "African", "code": "ZA"},
    {"name": "French", "code": "FR"},
    {"name": "German", "code": "DE"},
    {"name": "Chinese", "code": "CN"},
    {"name": "Japanese", "code": "JP"},
    {"name": "Korean", "code": "KR"},
    {"name": "Portuguese", "code": "PT"},
    {"name": "Spanish", "code": "ES"},
    {"name": "Italian", "code": "IT"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Language"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: _buildSearchBar(),
          ),
          Expanded(
            child: Obx(() {
              // ✅ Filter based on search
              final query = c.searchQuery.value.toLowerCase();
              final filteredLanguages = languages
                  .where((lang) => lang["name"]!.toLowerCase().contains(query))
                  .toList();
              if (filteredLanguages.isEmpty) {
                return Center(
                  child: Text(
                    "No results found",
                    style: AppTextStyles.getLato(
                        14, FontWeight.w500, AppColors.hintColor),
                  ),
                );
              }
              return ListView.builder(
                itemCount: filteredLanguages.length,
                itemBuilder: (context, index) {
                  final lang = filteredLanguages[index];
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    leading: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.borderColor, width: 0.5),
                          shape: BoxShape.circle),
                      child: CountryFlag.fromCountryCode(
                        lang['code']!,
                        shape: const Circle(),
                      ),
                    ),
                    title: Text(
                      lang["name"]!,
                      style: AppTextStyles.getLato(16, FontWeight.w400),
                    ),
                    trailing: Obx(
                      () => Radio<String>(
                        value: lang["name"]!,
                        activeColor: AppColors.primaryColor,
                        groupValue: c.selectedLanguage.value,
                        onChanged: (val) => c.selectedLanguage.value = val!,
                      ),
                    ),
                    onTap: () => c.selectedLanguage.value = lang["name"]!,
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomButton(
          onPressed: () => Get.back(),
          text: "Save Changes",
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        onChanged: (val) => c.searchQuery.value = val, // ✅ updates query
        decoration: InputDecoration(
          hintText: 'Search Here...',
          hintStyle: AppTextStyles.getLato(13, 4.weight, Color(0xffA6A6A6)),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xffA6A6A6),
          ),
          filled: false,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
        ),
      ),
    );
  }
}
