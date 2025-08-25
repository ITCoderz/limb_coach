import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/auth/components/uplaod_box.dart';
import 'package:mylimbcoach/screens/auth/controllers/profile_controler.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_dropdown.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class AddProfileScreen extends StatelessWidget {
  AddProfileScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Column(
          children: [
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: controller.currentStep.value == 1 ||
                          controller.currentStep.value == 4
                      ? CustomButton(
                          text: controller.currentStep.value == 4
                              ? "Save Profile"
                              : "Next",
                          onPressed: controller.isStepValid.value
                              ? () => controller.goToNextStep()
                              : () {},
                          backgroundColor: controller.isStepValid.value
                              ? AppColors.primaryColor
                              : AppColors.primaryColor.withOpacity(0.4),
                          borderColor: controller.isStepValid.value
                              ? AppColors.primaryColor
                              : AppColors.primaryColor.withOpacity(0.4),
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  fixedSize: Size(162, 45),
                                  side: BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  controller.goToPreviousStep();
                                },
                                child: Text(
                                  "Back",
                                  style: AppTextStyles.getLato(
                                      16, 4.weight, AppColors.primaryColor),
                                ),
                              ),
                            ),
                            10.pw,
                            Expanded(
                              child: CustomButton(
                                onPressed: controller.isStepValid.value
                                    ? () => controller.goToNextStep()
                                    : () {},
                                backgroundColor: controller.isStepValid.value
                                    ? AppColors.primaryColor
                                    : AppColors.primaryColor.withOpacity(0.4),
                                borderColor: controller.isStepValid.value
                                    ? AppColors.primaryColor
                                    : AppColors.primaryColor.withOpacity(0.4),
                                text: "Next",
                              ),
                            ),
                          ],
                        ),
                )),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(() => Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.ph,
                  GestureDetector(
                    onTap: () => controller.currentStep.value == 2
                        ? controller.goToPreviousStep()
                        : Navigator.pop(context),
                    child: Image.asset(Assets.pngIconsBackIcon),
                  ),
                  30.ph,
                  _stepIndicator(controller.currentStep.value),
                  20.ph,
                  Expanded(child: _stepContent(context)),
                ],
              ),
            )),
      ),
    );
  }

  Widget _stepIndicator(int step) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // align left to right
      children: [
        for (int i = 0; i < 4; i++) ...[
          Icon(
            Icons.check_circle,
            color: step >= i + 1
                ? AppColors.primaryColor
                : AppColors.hintColor.withOpacity(0.4),
          ),
          if (i < 3) // only draw 4 lines between icons
            Expanded(
              child: DottedLine(
                dashLength: 2,
                dashGapLength: 2,
                dashColor: step > i + 1
                    ? AppColors.primaryColor
                    : AppColors.hintColor.withOpacity(0.4),
              ),
            ),
        ],
      ],
    );
  }

  // Step Content Renderer
  Widget _stepContent(BuildContext context) {
    switch (controller.currentStep.value) {
      case 1:
        return _aboutYou();
      case 2:
        return _specialties();
      case 3:
        return _consultation();
      case 4:
        return _contact();
      default:
        return Center(child: Text("Profile Completed"));
    }
  }

  Widget _aboutYou() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About You:", style: AppTextStyles.getLato(24, 7.weight)),
          20.ph,
          // Image Picker Section
          Obx(() => Center(
                child: GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Color(0xffF1F1F1),
                      shape: BoxShape.circle,
                    ),
                    child: controller.selectedImage.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              controller.selectedImage.value!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Image.asset(Assets.pngIconsUserIcon)],
                            ),
                          ),
                  ),
                ),
              )),
          20.ph,
          CustomTextField(
            label: "Bio/Description",
            hintText:
                "Tell users about your experience, approach, and\nphilosophy (e.g., 'I specialize in paediatric lower limb\nprosthetics...').",
            controller: controller.bioController,
            maxLines: 6,
            maxLength: 500,
          ),
        ],
      ),
    );
  }

  Widget _specialties() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Specialties & Expertise:",
              style: AppTextStyles.getLato(24, 7.weight)),
          10.ph,
          Text("Areas of Expertise:",
              style: AppTextStyles.getLato(14, 6.weight)),
          10.ph,
          Obx(() {
            final items = controller.specialities;
            final chunked = <List<String>>[];

            // split list into chunks of 2
            for (var i = 0; i < items.length; i += 2) {
              chunked.add(
                items.sublist(i, i + 2 > items.length ? items.length : i + 2),
              );
            }

            return Column(
              children: chunked.map((pair) {
                return Row(
                  children: pair.map((speciality) {
                    return Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: controller.selected.contains(speciality),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: BorderSide(color: AppColors.borderColor),
                            activeColor: AppColors.primaryColor,
                            onChanged: (val) {
                              controller.toggleSelection(
                                  speciality, val ?? false);
                            },
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap, // 🔥 removes default padding
                            visualDensity: VisualDensity
                                .comfortable, // 🔥 makes it tighter
                          ),
                          Text(
                            speciality,
                            style: AppTextStyles.getLato(12, 4.weight),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          }),
          20.ph,
          Text("Paediatric Prosthetics Certificate:",
              style: AppTextStyles.getLato(14, 5.weight)),
          10.ph,
          UploadBox(
            title: "Document",
            fileName: controller.licenseFileName,
            progress: controller.licenseUploadProgress,
            onTap: () => controller.pickAndUploadLicense(),
          ),
          20.ph,
          Text("Orthotics Certificate:",
              style: AppTextStyles.getLato(14, 5.weight)),
          10.ph,
          UploadBox(
            title: "Document",
            fileName: controller.certificateFileName,
            progress: controller.certificateUploadProgress,
            onTap: () => controller.pickAndUploadCertificate(),
          ),
        ],
      ),
    );
  }

  Widget _consultation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Consultation & Pricing:",
            style: AppTextStyles.getLato(24, 7.weight)),
        20.ph,
        Text(
          "Consultation Fees:",
          style: AppTextStyles.getLato(14, 6.weight),
        ),
        10.ph,
        Row(
          children: [
            Obx(
              () => Radio<String>(
                value: "hour",
                groupValue: controller.consultationType.value,
                onChanged: (val) => controller.consultationType.value = val!,
                activeColor: AppColors.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            Text(
              "Per Hour",
              style: AppTextStyles.getLato(12, 4.weight),
            ),
          ],
        ),
        10.ph,
        Row(
          children: [
            Obx(
              () => Radio<String>(
                value: "session",
                groupValue: controller.consultationType.value,
                onChanged: (val) => controller.consultationType.value = val!,
                activeColor: AppColors.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            Text(
              "Per Session",
              style: AppTextStyles.getLato(12, 4.weight),
            ),
          ],
        ),
        10.ph,
        Row(
          children: [
            Obx(
              () => Radio<String>(
                value: "custom",
                groupValue: controller.consultationType.value,
                onChanged: (val) => controller.consultationType.value = val!,
                activeColor: AppColors.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            Text(
              "Custom",
              style: AppTextStyles.getLato(12, 4.weight),
            ),
          ],
        ),
        10.ph,
        if (controller.consultationType.value == 'custom')
          CustomTextField(
            label: "Consultation Fee",
            hintText: "€50.00",
            controller: controller.consultationFeeController,
          )
      ],
    );
  }

  Widget _contact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Contact & Location:", style: AppTextStyles.getLato(24, 7.weight)),
        20.ph,
        CustomTextField(
            label: "Email Address",
            controller: controller.emailController,
            hintText: "example@mail.com"),
        20.ph,
        CustomTextField(
            label: "Phone",
            type: TextInputType.number,
            controller: controller.phoneController,
            hintText: "+123456789"),
        20.ph,
        CustomDropdownField(
          fieldLabel: "Country",
          items: ["Germany", "USA", "India"],
          onChanged: (val) => controller.selectedCountry.value = val!,
        ),
        20.ph,
        CustomTextField(
            label: "Location",
            controller: controller.locationController,
            hintText: "Street, City, Country"),
      ],
    );
  }
}
