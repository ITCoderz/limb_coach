import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/auth/components/uplaod_box.dart';
import 'package:mylimbcoach/screens/auth/controllers/auth_controller.dart';
import 'package:mylimbcoach/screens/auth/views/sign_in_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_dropdown.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Obx(() => CustomButton(
                    text: controller.currentStep.value == 1
                        ? "Next"
                        : "Register & Continue",
                    onPressed: controller.currentStep.value == 1
                        ? (controller.isSignUpButtonEnabled.value
                            ? () => controller.goToNextStep()
                            : () {}) // disable when invalid
                        : (controller.areFilesUploaded.value
                            ? () => controller.signUp(context)
                            : () {}), // disable when files not uploaded
                    backgroundColor: (controller.currentStep.value == 1
                            ? controller.isSignUpButtonEnabled.value
                            : controller.areFilesUploaded.value)
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.4),
                    borderColor: (controller.currentStep.value == 1
                            ? controller.isSignUpButtonEnabled.value
                            : controller.areFilesUploaded.value)
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.4),
                  )),
              20.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ",
                      style: AppTextStyles.getLato(12, 4.weight)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignInScreen()));
                    },
                    child: Text("Sign in",
                        style: AppTextStyles.getLato(
                                12, 4.weight, AppColors.primaryColor)
                            .copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor)),
                  )
                ],
              ),
              10.ph,
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.ph,
                GestureDetector(
                  onTap: () => controller.currentStep.value == 2
                      ? controller.goToPreviousStep()
                      : Navigator.pop(context),
                  child: Image.asset(Assets.pngIconsBackIcon),
                ),
                40.ph,
                _stepIndicator(controller.currentStep.value),
                const SizedBox(height: 30),
                if (controller.currentStep.value == 1)
                  Expanded(child: _accountCreationForm(context))
                else
                  Expanded(child: _licenseUploadStep(context)),
              ],
            ),
          );
        }),
      ),
    );
  }

  // Step indicator
  Widget _stepIndicator(int step) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: AppColors.primaryColor,
          size: 28,
        ), // first always completed
        Expanded(
          child: DottedLine(
            dashLength: 1,
            dashGapLength: 1,
            lineThickness: 1,
            dashColor: step == 1
                ? AppColors.hintColor.withOpacity(0.4)
                : AppColors.primaryColor,
          ),
        ),
        Icon(
          Icons.check_circle,
          size: 28,
          color: step == 2 ? AppColors.primaryColor : AppColors.hintColor,
        ),
      ],
    );
  }

  // Step 1: Account Creation
  Widget _accountCreationForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Account Creation:", style: AppTextStyles.getLato(26, 7.weight)),
          30.ph,

          // Example: First + Last name
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

          CustomTextField(
              label: "Email Address",
              hintText: "test@example.com",
              controller: controller.emailController),
          20.ph,
          CustomDropdownField(
              fieldLabel: "Professional Title",
              onChanged: (val) {},
              items: ['Plumber', "Electrician", "Technion"]),
          20.ph,
          CustomTextField(
              label: "Password",
              hintText: "********",
              controller: controller.passwordController,
              isPassword: true),
          20.ph,
          CustomTextField(
              label: "Confirm Password",
              hintText: "********",
              controller: controller.confirmPasswordController,
              isPassword: true),
          20.ph,
        ],
      ),
    );
  }

  // Step 2: License Upload
  Widget _licenseUploadStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("License & Certificates:",
            style: AppTextStyles.getLato(26, 7.weight)),
        const SizedBox(height: 20),
        Text(
          "Professional License:",
          style: AppTextStyles.getLato(14, 5.weight),
        ),
        5.ph,
        UploadBox(
          title: "Document",
          fileName: controller.licenseFileName,
          progress: controller.licenseUploadProgress,
          onTap: () => controller.pickAndUploadLicense(),
        ),
        20.ph,
        Text(
          "Professional Certification:",
          style: AppTextStyles.getLato(14, 5.weight),
        ),
        5.ph,
        UploadBox(
          title: "Document",
          fileName: controller.certificateFileName,
          progress: controller.certificateUploadProgress,
          onTap: () => controller.pickAndUploadCertificate(),
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 20),
      ],
    );
  }
}
