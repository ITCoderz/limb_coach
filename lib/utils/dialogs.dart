// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mylimbcoach/utils/app_colors.dart';
// import 'package:mylimbcoach/utils/app_text_styles.dart';
// import 'package:mylimbcoach/widgets/custom_button.dart';
//
// class ShowDialog {
//   ShowDialog._();
//
//   static showSuccessDialog(BuildContext context, String desc) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(
//                 Assets.imagesCheck, // Update with your trash icon asset
//                 height: 130,
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 'Successful!',
//                 style: AppTextStyles.getLato(
//                     20, FontWeight.w600, AppColors.primaryColor),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 desc,
//                 textAlign: TextAlign.center,
//                 style: AppTextStyles.getLato(14, FontWeight.w400),
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                   text: "Back to Home",
//                   width: 280,
//                   onPressed: () {
//                     Get.back();
//                   })
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   static successAlert({required String message}) {
//     Get.snackbar(
//       '',
//       '',
//       maxWidth: 400,
//       titleText: _buildTitle('Success', Colors.green, Icons.check_circle),
//       messageText: _buildMessage(message),
//       backgroundColor: Colors.green,
//       margin: const EdgeInsets.all(12),
//       borderRadius: 12,
//       snackPosition: SnackPosition.TOP,
//       shouldIconPulse: true,
//       isDismissible: true,
//       duration: const Duration(seconds: 2),
//     );
//   }
//
//   static warningAlert({required String message}) {
//     Get.snackbar(
//       '',
//       '',
//       titleText:
//           _buildTitle('Warning', Colors.white, Icons.warning_amber_rounded),
//       messageText: _buildMessage(message),
//       backgroundColor: Colors.deepOrange,
//       maxWidth: 400,
//       margin: const EdgeInsets.all(12),
//       borderRadius: 12,
//       snackPosition: SnackPosition.TOP,
//       shouldIconPulse: true,
//       isDismissible: true,
//       duration: const Duration(seconds: 3),
//     );
//   }
//
//   static Widget _buildTitle(String text, Color color, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, color: Colors.white, size: 24),
//         const SizedBox(width: 8),
//         Text(
//           text,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
//
//   static Widget _buildMessage(String message) {
//     return Text(
//       message,
//       textAlign: TextAlign.left,
//       style: const TextStyle(fontSize: 16, color: Colors.white),
//     );
//   }
// }
