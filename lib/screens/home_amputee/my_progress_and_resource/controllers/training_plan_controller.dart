// training_plan_controller.dart
import 'package:get/get.dart';

class TrainingPlanController extends GetxController {
  var title = ''.obs;
  var goal = ''.obs;
  var completionDate = ''.obs;
  var exercises = <Map<String, String>>[].obs;

  void addExercise(String name, String sets, String instructions) {
    exercises.add({
      "name": name,
      "sets": sets,
      "instructions": instructions,
    });
  }

  bool get isValidPlan {
    return title.isNotEmpty &&
        goal.isNotEmpty &&
        completionDate.isNotEmpty &&
        exercises.isNotEmpty;
  }
}
