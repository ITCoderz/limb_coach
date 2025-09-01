import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/edit_profile/controllers/edit_profile_controllers.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class AmputeeEditProfileScreen extends StatelessWidget {
  final c = Get.put(AmputeeEditProfileController());

  AmputeeEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Profile"),
      body: Column(
        children: [
          /// 🔹 Profile Avatar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Obx(() {
                return GestureDetector(
                  onTap: () => c.pickImage(c.profileImage),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: c.profileImage.value != null
                        ? FileImage(c.profileImage.value!)
                        : const AssetImage(Assets.pngIconsDp2) as ImageProvider,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        Assets.pngIconsCam,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          /// 🔹 Tab Views
          Expanded(
            child: _buildPersonalTab(context),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
            onPressed: () => c.updateProfile(), text: "Update Profile"),
      ),
    );
  }

  /// PERSONAL TAB
  Widget _buildPersonalTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                    controller: c.firstNameController,
                    label: "First Name",
                    hintText: "Emily"),
              ),
              10.pw,
              Expanded(
                child: CustomTextField(
                    controller: c.lastNameController,
                    label: "Last Name",
                    hintText: "White"),
              ),
            ],
          ),
          20.ph,
          CustomTextField(
            controller: c.emailController,
            label: "Email Address",
            hintText: "emilywhite101@gmail.com",
            type: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          Text(
            "Change Password:",
            style: AppTextStyles.getLato(16, 6.weight),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: c.oldPasswordController,
            label: "Old Password",
            isPassword: true,
            hintText: '',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: c.newPasswordController,
            label: "New Password",
            isPassword: true,
            hintText: '',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: c.confirmPasswordController,
            label: "Confirm Password",
            isPassword: true,
            hintText: '',
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
