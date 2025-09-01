import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/my_progress_and_resource/controllers/training_plan_controller.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_snackbar.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

import 'success_screen.dart';

class AddTrainingPlanScreen extends StatelessWidget {
  final TrainingPlanController controller =
      Get.put(TrainingPlanController()); // inject controller

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController goalCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();

  AddTrainingPlanScreen({super.key});

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      dateCtrl.text = "${picked.day}/${picked.month}/${picked.year}";
      controller.completionDate.value = dateCtrl.text;
    }
  }

  void _showAddExerciseDialog(BuildContext context) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController setsCtrl = TextEditingController();
    final TextEditingController instructionCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Add Exercise", style: AppTextStyles.getLato(16, 6.weight)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.ph,
              CustomTextField(
                controller: nameCtrl,
                label: "Exercise Name",
                hintText: "e.g., Calf Raises",
              ),
              12.ph,
              CustomTextField(
                controller: setsCtrl,
                label: "Sets & Reps",
                hintText: "e.g., 3 x 12",
              ),
              12.ph,
              CustomTextField(
                controller: instructionCtrl,
                label: "Instructions",
                hintText: "Write instructions here...",
                maxLines: 4,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  backgroundColor: Colors.white,
                  textStyle:
                      AppTextStyles.getLato(16, 4.weight, AppColors.hintColor),
                  onPressed: () => Get.back(),
                  borderColor: AppColors.borderColor,
                  text: "Cancel",
                ),
              ),
              10.pw,
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    if (nameCtrl.text.isNotEmpty &&
                        setsCtrl.text.isNotEmpty &&
                        instructionCtrl.text.isNotEmpty) {
                      controller.addExercise(
                          nameCtrl.text, setsCtrl.text, instructionCtrl.text);
                    }
                    Get.back();
                  },
                  text: "Add Exercise",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Add New Training Plan"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Plans Details:",
                  style: AppTextStyles.getLato(16, 6.weight)),
              30.ph,
              CustomTextField(
                controller: titleCtrl,
                hintText: "e.g., My Walking Practice",
                label: "Plan Title",
                onChanged: (val) => controller.title.value = val,
              ),
              20.ph,
              CustomTextField(
                controller: goalCtrl,
                maxLines: 6,
                maxLength: 200,
                hintText: "Write plan goal here..",
                label: "Plan Goal",
                onChanged: (val) => controller.goal.value = val,
              ),
              20.ph,
              CustomTextField(
                controller: dateCtrl,
                readOnly: true,
                hintText: "DD/MM/YYYY",
                label: "Completion Date*",
                onTap: () => _pickDate(context),
              ),
              30.ph,
              Text("Exercises:", style: AppTextStyles.getLato(16, 6.weight)),
              15.ph,

              /// Reactive exercise list
              Obx(() => Column(
                    children: controller.exercises
                        .map((ex) => Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.borderColor, width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(ex["name"] ?? "",
                                          style: AppTextStyles.getLato(
                                              13, 4.weight)),
                                      5.ph,
                                      Text("${ex["sets"]}",
                                          style: AppTextStyles.getLato(10,
                                              4.weight, AppColors.hintColor)),
                                    ],
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      controller.exercises.removeLast();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: AppColors.redColor
                                              .withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Image.asset(
                                        Assets.pngIconsDelete,
                                        color: AppColors.redColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  )),

              GestureDetector(
                onTap: () => _showAddExerciseDialog(context),
                child: Text(
                  "Add Exercise",
                  style: AppTextStyles.getLato(13, 4.weight).copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColors.primaryColor,
                    decorationColor: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
            onPressed: () {
              if (controller.isValidPlan) {
                Get.to(() => SuccessScreen());
              } else {
                AppSnackbar.error(
                  "Missing Information",
                  "Please fill all fields and add at least one exercise",
                );
              }
            },
            text: "Create Plan",
          )),
    );
  }
}
