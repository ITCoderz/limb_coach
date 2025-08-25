import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/auth/controllers/auth_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Obx(() => CustomButton(
                  onPressed: controller.isButtonEnabled.value
                      ? () => controller.signIn(context)
                      : () {},
                  text: "Sign in",
                  backgroundColor: controller.isButtonEnabled.value
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(0.4),
                  borderColor: controller.isButtonEnabled.value
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(0.4),
                )),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don’t have an account? ",
                    style: AppTextStyles.getLato(12, 4.weight)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignUpScreen()));
                  },
                  child: Text("Sign Up",
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.ph,
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(Assets.pngIconsBackIcon),
                ),
                40.ph,
                Text("Sign In", style: AppTextStyles.getLato(26, 7.weight)),
                const SizedBox(height: 5),
                Text("Welcome Back! Sign in to your account",
                    style: AppTextStyles.getLato(14, 4.weight)),
                50.ph,

                // Email
                CustomTextField(
                  label: "Email Address",
                  hintText: "test@example.com",
                  controller: controller.emailController,
                ),
                20.ph,

                // Password
                CustomTextField(
                  label: "Password",
                  hintText: "********",
                  controller: controller.passwordController,
                  isPassword: true,
                ),
                20.ph,

                // Remember Me
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          activeColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                            side: MaterialStateBorderSide.resolveWith((states) {
                              if (states.contains(MaterialState.focused)) {
                                return BorderSide(
                                    color: AppColors.primaryColor, width: 1.5);
                              }
                              return BorderSide(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.1),
                                  width: 0.5);
                            }),
                          ),
                          onChanged: (val) =>
                              controller.toggleRememberMe(val ?? false),
                        )),
                    Text("Remember Me",
                        style: AppTextStyles.getLato(12, 4.weight)),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: AppTextStyles.getLato(
                                12, 5.weight, AppColors.primaryColor)
                            .copyWith(
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                40.ph,

                // Social login
                Row(
                  children: [
                    Expanded(child: Divider(color: Color(0xffDEDEDE))),
                    5.pw,
                    Text("Or Sign In with",
                        style: AppTextStyles.getLato(12, 4.weight)),
                    5.pw,
                    Expanded(child: Divider(color: Color(0xffDEDEDE))),
                  ],
                ),
                40.ph,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialIcon(Assets.pngIconsGoogle),
                    const SizedBox(width: 16),
                    _socialIcon(Assets.pngIconsApple),
                    const SizedBox(width: 16),
                    _socialIcon(Assets.pngIconsFacebook),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(String asset) {
    return Container(
      height: 45,
      width: 45,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffDEDEDE)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Image.asset(asset, width: 24, height: 24),
    );
  }
}
