import 'dart:io';

import 'package:get/get.dart';

class ProgressController extends GetxController {
  var selectedTab = 0.obs;

  // Hold picked files
  var pickedPhoto = Rx<File?>(null);
  var pickedVideo = Rx<File?>(null);

  void changeTab(int index) {
    selectedTab.value = index;
  }
}
