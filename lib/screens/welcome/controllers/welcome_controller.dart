import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var currentPage = 0.obs;
  var selectedLoginType = (-1).obs;

  void selectLoginType(int index) {
    selectedLoginType.value = index;
  }

  bool isSelected(int index) => selectedLoginType.value == index;
}
