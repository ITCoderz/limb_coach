import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/track_order/views/track_order_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class TrainingDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        "Week 1 Mobility Exercises",
        widgets: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(Assets.pngIconsShare),
          ),
          10.pw,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoRow("Created", "July 01, 2025"),
            infoRow("Assigned By", "Dr. Emily White"),
            15.ph,
            Text("Goal:", style: AppTextStyles.getLato(16, 6.weight)),
            10.ph,
            Text(
              "This plan focuses on improving your range of motion and initial strength post-surgery.",
              style: AppTextStyles.getLato(13, 4.weight),
            ),
            10.ph,
            Divider(),
            10.ph,
            Expanded(
              child: ListView(
                children: [
                  Text("Warm Up:", style: AppTextStyles.getLato(16, 6.weight)),
                  _exerciseTile("Calf Raises", "3 sets of 10 reps"),
                  Text("Exercise:", style: AppTextStyles.getLato(16, 6.weight)),
                  10.ph,
                  Timeline(isActive: false),
                  10.ph,
                  Text(
                    "Cool-down:",
                    style: AppTextStyles.getLato(16, 6.weight),
                  ),
                  _exerciseTile("Gentle Stretching", "5 min"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _exerciseTile(String name, String detail) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.check_circle, color: AppColors.borderColor),
      minLeadingWidth: 25,
      title: Text(
        name,
        style: AppTextStyles.getLato(14, 6.weight, AppColors.hintColor),
      ),
      subtitle: Text(
        detail,
        style: AppTextStyles.getLato(12, 4.weight, AppColors.hintColor),
      ),
      trailing: Icon(Icons.info, color: AppColors.primaryColor),
      onTap: () => Get.dialog(_exerciseDialog(name, detail: detail)),
    );
  }
}

Widget _exerciseDialog(String name, {String? detail}) {
  // Instructions map
  final instructions = {
    "Calf Raises": [
      "Stand up tall on a flat surface, with your feet hip-width apart. Point your toes forward and keep your shoulders back and down. Engage your core, and let your arms hang naturally to your sides.",
      "Perform calf raises according to the 2-1-2-1 rule. Raise in 2 seconds, pause for 1 second at the top, lower in 2 seconds, and pause 1 second at the bottom.",
      "Push off and raise your heels, exhaling as you do so.",
      "Squeeze your calves at the top of the movement, then inhale as you lower back down to the starting position. Repeat for the desired number of reps.",
    ],
    "Arm Circles": [
      "Stand with your feet shoulder-width apart.",
      "Extend your arms out to your sides.",
      "Begin making circular motions with your arms.",
      "You can change the size of the circles.",
      "Perform for 15-30 seconds in each direction.",
    ],
    "Leg Swing": [
      "Begin by supporting yourself with one arm while swinging your opposite leg forward then backward.",
      "Keep your leg straight as it moves forward and stretches the hamstrings then as it comes back try to kick yourself in the butt to stretch the quads.",
      "With each swing you should take the stretch a bit further.",
      "Try 20 reps on each leg.",
    ],
    "Gentle Stretching": [
      "To Stretch Hip Flexors: Lunges",
      "To Stretch Hamstrings: Single-Leg Standing Hamstring Stretch",
      "To Stretch Outer Hips and Glutes.",
      "To Stretch Inner Thighs (Hip Adductors): Side Lunge Stretch",
      "To Stretch Outer Thigh and Hips: Standing IT Band Stretch",
      "To Stretch Hip Flexors: Standing Mobility Lunge",
    ],
  };

  // Image map
  final images = {
    "Calf Raises": Assets.pngIconsExercise,
    "Arm Circles": Assets.pngIconsArmcircles,
    "Leg Swing": Assets.pngIconsLegswings,
    "Gentle Stretching": Assets.pngIconsGeneralStretching,
  };

  final steps = instructions[name] ?? [];
  final imagePath = images[name] ?? Assets.pngIconsExercise;

  return AlertDialog(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(name, style: AppTextStyles.getLato(16, FontWeight.bold)),
            Spacer(),
            GestureDetector(onTap: () => Get.back(), child: Icon(Icons.clear)),
          ],
        ),
        if (detail != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              detail,
              style: AppTextStyles.getLato(
                13,
                FontWeight.w400,
                AppColors.hintColor,
              ),
            ),
          ),
      ],
    ),
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise Image
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColors.borderColor, width: 0.5),
            ),
            child: Center(
              child: Image.asset(
                imagePath, // ✅ dynamic per exercise
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Instruction Points
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              steps.length,
              (i) => _instructionPoint(steps[i], i + 1),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _instructionPoint(String text, int number) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$number. ",
          style: AppTextStyles.getLato(14, FontWeight.bold, Colors.black),
        ),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.getLato(14, FontWeight.normal, Colors.black),
          ),
        ),
      ],
    ),
  );
}

class Timeline extends StatelessWidget {
  final steps = const [
    ["Arm Circles", "2 sets of 5 min"],
    ["Leg Swing", "2 sets of 10 reps"],
  ];

  final bool isActive;
  Timeline({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (i) {
        bool active = false; // ✅ if order inactive (past), all steps active

        return _sessionTile(
          steps[i][0],
          steps[i][1],
          active,
          i == steps.length - 1,
          () {
            Get.dialog(_exerciseDialog(steps[i][0], detail: steps[i][1]));
          },
        );
      }),
    );
  }

  Widget _sessionTile(
    String title,
    String time,
    bool active,
    bool last,
    onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                Icons.check_circle,
                color: active ? AppColors.primaryColor : AppColors.borderColor,
              ),
              if (!last)
                SizedBox(
                  height: 30,
                  child: DottedLine(
                    direction: Axis.vertical,
                    dashLength: 2,
                    dashGapLength: 2,
                    dashColor: active
                        ? AppColors.primaryColor
                        : AppColors.hintColor.withOpacity(0.6),
                  ),
                ),
            ],
          ),
          10.pw,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.getLato(
                  14,
                  6.weight,
                  active ? AppColors.blackColor : AppColors.hintColor,
                ),
              ),
              5.ph,
              Text(
                time,
                style: AppTextStyles.getLato(12, 4.weight, AppColors.hintColor),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.info, color: AppColors.primaryColor),
        ],
      ),
    );
  }
}
