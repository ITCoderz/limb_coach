import 'package:get/get.dart';

class TimelineController extends GetxController {
  // 0 = only "Order Placed" is active initially
  var activeStepIndex = 0.obs;

  // call this when step changes
  void setActiveStep(int index) {
    activeStepIndex.value = index;
  }
}
