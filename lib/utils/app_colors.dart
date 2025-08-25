import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF035C8A);
  static const Color orangeColor = Color(0xFFD16135);
  static const Color primaryColor2 = Color(0xFF510A83);
  static const Color primaryColor3 = Color(0xFF2C0547);
  static const Color bgColor = Color(0xFFF8F8FF);

  static const Color whiteColor = Colors.white;
  static const Color hintColor = Color(0xffA6A6A6);

  static const Color lightGreyColor = Color(0xffB8B8B8);
  static const Color textBlackColor = Color(0xff1E1E1E);
  static const Color blackColor = Color(0xff000000);
  static const Color borderColor = Color(0xffDEDEDE);
  static const redColor = Color(0xffD82300);

  static LinearGradient primaryGradient = LinearGradient(colors: [
    AppColors.primaryColor.withOpacity(0.2),
    AppColors.whiteColor.withOpacity(0),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}

// class AppColors {
//   static ThemeController get _controller => Get.find();
//
//   static Color get primaryColor => _controller.selectedColor.value;
//   static Color get orangeColor => Colors.orange;
//   static Color get primaryColor2 => _darken(primaryColor, 0.15);
//   static Color get primaryColor3 => _darken(primaryColor, 0.25);
//   static Color get bgColor => _controller.isDarkMode.value
//       ? const Color(0xFF1E1E1E)
//       : const Color(0xFFF8F8FF);
//   static Color get whiteColor => Colors.white;
//   static Color get lightGreyColor => const Color(0xffB8B8B8);
//   static Color get textBlackColor => const Color(0xff121212);
//   static Color get blackColor => Colors.black;
//   static Color get borderColor => const Color(0xffA1A1A1);
//   static Color get redColor => const Color(0xffFF0000);
//
//   static LinearGradient get primaryGradient => LinearGradient(
//         colors: [
//           primaryColor.withOpacity(0.2),
//           whiteColor.withOpacity(0),
//         ],
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//       );
//
//   static Color _darken(Color color, double amount) {
//     final hsl = HSLColor.fromColor(color);
//     final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
//     return hslDark.toColor();
//   }
// }
