import 'package:get/get.dart';

class UserTypeController extends GetxController {
  // 0 = Amputee, 1 = Professional
  var selectedLoginType = 0.obs;

  void setLoginType(int type) {
    selectedLoginType.value = type;
  }

  int get loginType => selectedLoginType.value;

  bool isAmputee() => selectedLoginType.value == 0;
  bool isProfessional() => selectedLoginType.value == 1;
}
