import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/auth/controllers/auth_controller.dart';
import 'package:mylimbcoach/screens/auth/views/sign_in_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class SignUpScreenAmputee extends StatelessWidget {
  SignUpScreenAmputee({super.key});
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
                    text: "Sign Up",
                    onPressed: controller.isSignUpAmputeeButtonEnabled.value
                        ? () => controller.signUpAmputee(context)
                        : () {}, // disabled if invalid
                    backgroundColor:
                        controller.isSignUpAmputeeButtonEnabled.value
                            ? AppColors.primaryColor
                            : AppColors.primaryColor.withOpacity(0.4),
                    borderColor: controller.isSignUpAmputeeButtonEnabled.value
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.ph,
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(Assets.pngIconsBackIcon),
              ),
              40.ph,
              Expanded(child: _accountCreationForm(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget _accountCreationForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sign Up", style: AppTextStyles.getLato(26, 7.weight)),
          5.ph,
          Text("Sign up to create your account",
              style: AppTextStyles.getLato(14, 4.weight)),
          40.ph,

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
          Row(
            children: [
              Obx(
                () => Checkbox(
                  value: controller.terms.value,
                  activeColor: AppColors.primaryColor,
                  side: BorderSide(color: AppColors.borderColor, width: 0.5),
                  materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // ✅ removes extra space
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: MaterialStateBorderSide.resolveWith((states) {
                      if (states.contains(MaterialState.focused)) {
                        return BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.5,
                        );
                      }
                      return BorderSide(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        width: 0.5,
                      );
                    }),
                  ),
                  onChanged: (val) => controller.toggleTerms(val ?? false),
                ),
              ),
              const SizedBox(width: 6), // adjust spacing if needed
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.getLato(12, FontWeight.w400)
                        .copyWith(color: Colors.black), // base style
                    children: [
                      const TextSpan(text: "By signing up, you agree to our "),
                      TextSpan(
                        text: "Terms of Service",
                        style: AppTextStyles.getLato(12, FontWeight.w600)
                            .copyWith(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // 👉 Navigate to Terms Screen
                            // Get.to(() => TermsScreen());
                          },
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(text: '\n'),
                      TextSpan(
                        text: "Privacy Policy",
                        style: AppTextStyles.getLato(12, FontWeight.w600)
                            .copyWith(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // 👉 Navigate to Privacy Policy Screen
                            // Get.to(() => PrivacyPolicyScreen());
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
