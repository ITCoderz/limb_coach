import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/auth/controllers/amputee_profie_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_dropdown.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class AddProfileScreenAmputee extends StatelessWidget {
  AddProfileScreenAmputee({super.key});

  final controller = Get.put(AmputeeProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Column(
          children: [
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: controller.currentStep.value == 1
                      ? CustomButton(
                          text: controller.currentStep.value == 4
                              ? "Finish Setup"
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
                                  text: controller.currentStep.value == 4
                                      ? "Finish Setup"
                                      : "Next"),
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
                  Expanded(child: _stepContent(context, controller)),
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
            size: 28,
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
  Widget _stepContent(BuildContext context, AmputeeProfileController c) {
    switch (controller.currentStep.value) {
      case 1:
        return _personalDetails(context, c);
      case 2:
        return _limbCondition(context, c);
      case 3:
        return _deviceJourney();
      case 4:
        return _goals();
      default:
        return Center(child: Text("Profile Completed"));
    }
  }

  Widget _personalDetails(context, AmputeeProfileController c) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Personal Details:", style: AppTextStyles.getLato(24, 7.weight)),
          30.ph,
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                      label: "First Name",
                      hintText: "John",
                      controller: controller.firstNameController)),
              const SizedBox(width: 12),
              Expanded(
                  child: CustomTextField(
                      label: "Last Name",
                      hintText: "Doe",
                      controller: controller.lastNameController)),
            ],
          ),
          20.ph,
          Obx(
            () => CustomTextField(
              hintText: "DD/MM/YYYY",
              label: "Date of Birth",
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  c.selectedDate.value = pickedDate;
                }
              },
              controller: TextEditingController(
                text: c.selectedDate.value != null
                    ? "${c.selectedDate.value!.day}/${c.selectedDate.value!.month}/${c.selectedDate.value!.year}"
                    : "",
              ),
            ),
          ),
          20.ph,
          CustomDropdownField(
            fieldLabel: "Country",
            items: ["Germany", "USA", "India"],
            onChanged: (val) => controller.selectedCountry.value = val!,
          ),
          20.ph,
          CustomDropdownField(
            fieldLabel: "Gender",
            items: ["Male", "Female", "Not Specified"],
            onChanged: (val) => controller.selectedGender.value = val!,
          ),
          40.ph,
          InkWell(
            onTap: () {
              c.goToNextStep();
            },
            child: Center(
              child: Text("Skip for now",
                  style: AppTextStyles.getLato(
                          13, 4.weight, AppColors.primaryColor)
                      .copyWith(
                          decorationColor: AppColors.primaryColor,
                          decoration: TextDecoration.underline)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _limbCondition(context, AmputeeProfileController c) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your Limb Condition:",
              style: AppTextStyles.getLato(24, 7.weight)),
          30.ph,
          CustomDropdownField(
            fieldLabel: "Level of Amputation",
            items: [
              "Upper Limb Amputation",
              "Lower Limb Amputation",
            ],
            onChanged: (val) => controller.selectedLevelAmputee.value = val!,
          ),
          20.ph,
          if (c.selectedLevelAmputee.value == "Upper Limb Amputation")
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomDropdownField(
                fieldLabel: "Upper Limb Amputation",
                items: [
                  "Partial Hand Amputation",
                  "Wrist Disarticulation",
                  "Transracial Amputation",
                  "Quad Amputation",
                  "Elbow Disarticulation",
                  "Trans humeral Amputation",
                  "Shoulder Disarticulation",
                  "Forequarter Amputation",
                ],
                onChanged: (val) => controller.upperLevelAmputee.value = val!,
              ),
            ),
          if (c.selectedLevelAmputee.value == "Lower Limb Amputation")
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomDropdownField(
                fieldLabel: "Lower Limb Amputation",
                items: [
                  "Partial Foot Amputation",
                  "Ankle Disarticulation",
                  "Transtibial Amputation",
                  "Quad Amputation",
                  "Knee Disarticulation",
                  "Trans femoral Amputation",
                  "Hip Disarticulation",
                  "Hemipelvectomy",
                ],
                onChanged: (val) => controller.lowerLevelAmputee.value = val!,
              ),
            ),
          Obx(
            () => CustomTextField(
              hintText: "DD/MM/YYYY",
              label: "Date of Amputation",
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  c.selectedDateAmputee.value = pickedDate;
                }
              },
              controller: TextEditingController(
                text: c.selectedDateAmputee.value != null
                    ? "${c.selectedDateAmputee.value!.day}/${c.selectedDateAmputee.value!.month}/${c.selectedDateAmputee.value!.year}"
                    : "",
              ),
            ),
          ),
          20.ph,
          CustomTextField(
            label: "Reason",
            hintText: "e.g. trauma, medical condition",
            maxLines: 6,
            controller: controller.reasonController,
          ),
          40.ph,
          InkWell(
            onTap: () {
              c.goToNextStep();
            },
            child: Center(
              child: Text("Skip for now",
                  style: AppTextStyles.getLato(
                          13, 4.weight, AppColors.primaryColor)
                      .copyWith(
                          decorationColor: AppColors.primaryColor,
                          decoration: TextDecoration.underline)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _deviceJourney() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Your Device Journey:",
            style: AppTextStyles.getLato(24, 7.weight)),
        20.ph,
        CustomDropdownField(
          fieldLabel: "Current Prosthetic Device",
          items: [
            "None / Not Using",
            "Basic Prosthesis (non-microprocessor)",
            "Microprocessor-Controlled Prosthesis (e.g., C-Leg, Proprietor)",
            "Myoelectric Upper Limb Prosthesis",
            "Cosmetic / Passive Prosthesis",
            "Activity-Specific Prosthesis (e.g., sports, swimming)",
          ],
          onChanged: (val) => controller.lowerLevelAmputee.value = val!,
        ),
        10.ph,
        Text(
          "Comfort Level with Current Device*",
          style: AppTextStyles.getLato(14, 5.weight),
        ),
        Obx(() {
          final items = controller.comfortLevelWithCurrentDevice;
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
                          value: controller.selectedComfortDevices
                              .contains(speciality),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(color: AppColors.borderColor),
                          activeColor: AppColors.primaryColor,
                          onChanged: (val) {
                            controller.toggleSelectionComfortDevices(
                                speciality, val ?? false);
                          },
                          materialTapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // 🔥 removes default padding
                          visualDensity:
                              VisualDensity.comfortable, // 🔥 makes it tighter
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
        Text(
          "Past Device*",
          style: AppTextStyles.getLato(14, 5.weight),
        ),
        Obx(() {
          final items = controller.pastDevice;
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
                          value: controller.selectedPastDevices
                              .contains(speciality),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(color: AppColors.borderColor),
                          activeColor: AppColors.primaryColor,
                          onChanged: (val) {
                            controller.toggleSelectionPastDevices(
                                speciality, val ?? false);
                          },
                          materialTapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // 🔥 removes default padding
                          visualDensity:
                              VisualDensity.comfortable, // 🔥 makes it tighter
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
        Text(
          "Preferences*",
          style: AppTextStyles.getLato(14, 5.weight),
        ),
        Obx(() {
          final items = controller.preferences;
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
                          value: controller.selectedPreferences
                              .contains(speciality),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(color: AppColors.borderColor),
                          activeColor: AppColors.primaryColor,
                          onChanged: (val) {
                            controller.toggleSelectionPreferences(
                                speciality, val ?? false);
                          },
                          materialTapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // 🔥 removes default padding
                          visualDensity:
                              VisualDensity.comfortable, // 🔥 makes it tighter
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
        40.ph,
        InkWell(
          onTap: () {
            controller.goToNextStep();
          },
          child: Center(
            child: Text("Skip for now",
                style:
                    AppTextStyles.getLato(13, 4.weight, AppColors.primaryColor)
                        .copyWith(
                            decorationColor: AppColors.primaryColor,
                            decoration: TextDecoration.underline)),
          ),
        ),
      ],
    );
  }

  Widget _goals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("What Are Your Goals?",
            style: AppTextStyles.getLato(24, 7.weight)),
        10.ph,
        Text(
          "Select your goals from below options:",
          style: AppTextStyles.getLato(13, 4.weight),
        ),
        10.ph,
        Obx(() {
          final items = controller.goals;

          return SingleChildScrollView(
            // ✅ scroll if many items
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((speciality) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: controller.selectedGoals.contains(speciality),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: BorderSide(color: AppColors.borderColor),
                      activeColor: AppColors.primaryColor,
                      onChanged: (val) {
                        controller.toggleSelectionGoals(
                            speciality, val ?? false);
                      },
                      materialTapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // 🔥 removes default padding
                      visualDensity: VisualDensity
                          .compact, // ✅ tighter spacing than comfortable
                    ),
                    Text(
                      speciality,
                      style: AppTextStyles.getLato(12, FontWeight.w400),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        }),
        30.ph,
        Obx(() => controller.selectedGoals.contains("Others")
            ? CustomTextField(
                label: "Other",
                maxLines: 3,
                hintText: '',
                controller: TextEditingController())
            : SizedBox.shrink()),
        40.ph,
        InkWell(
          onTap: () {
            controller.goToNextStep(skipCall: true);
          },
          child: Center(
            child: Text("Skip for now",
                style:
                    AppTextStyles.getLato(13, 4.weight, AppColors.primaryColor)
                        .copyWith(
                            decorationColor: AppColors.primaryColor,
                            decoration: TextDecoration.underline)),
          ),
        ),
      ],
    );
  }
}
