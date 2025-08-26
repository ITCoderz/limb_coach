import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/auth/components/uplaod_box.dart';
import 'package:mylimbcoach/screens/home_professional/edit_profile/controllers/edit_profile_controllers.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';
import 'package:mylimbcoach/widgets/custom_dropdown.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  final c = Get.put(EditProfileController());

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Image.asset(Assets.pngIconsBackIcon),
          ),
          title: Text(
            "Profile",
            style: AppTextStyles.getLato(18, 6.weight),
          ),
          centerTitle: true,
        ),
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
                          : const AssetImage(Assets.pngIconsDp2)
                              as ImageProvider,
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

            /// 🔹 Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: AppColors.hintColor,
                indicatorColor: AppColors.primaryColor,
                tabs: [
                  Tab(text: "PERSONAL  DETAILS"),
                  Tab(text: "PROFESSIONAL DETAILS"),
                ],
              ),
            ),

            /// 🔹 Tab Views
            Expanded(
              child: TabBarView(
                children: [
                  _buildPersonalTab(context),
                  _buildProfessionalTab(context),
                ],
              ),
            ),
          ],
        ),
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
          Text(
            "Personal Details:",
            style: AppTextStyles.getLato(18, 6.weight),
          ),
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
            style: AppTextStyles.getLato(18, 6.weight),
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
          CustomButton(
              onPressed: () => c.updateProfile(), text: "Update Profile"),
        ],
      ),
    );
  }

  /// PROFESSIONAL TAB
  Widget _buildProfessionalTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Account Information:",
            style: AppTextStyles.getLato(18, 6.weight),
          ),
          20.ph,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                    controller: c.firstNameController,
                    label: "First Name",
                    hintText: "John"),
              ),
              10.pw,
              Expanded(
                child: CustomTextField(
                    controller: c.lastNameController,
                    label: "Last Name",
                    hintText: "Doe"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: c.emailController,
            label: "Email Address",
            hintText: "johndoe@gmail.com",
            type: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          CustomDropdownField(
            value: c.professionalTitle.value.isEmpty
                ? null
                : c.professionalTitle.value,
            fieldLabel: "Professional Title",
            items: ["Prosthetist", "Orthotist", "Therapist"],
            onChanged: (val) => c.professionalTitle.value = val ?? "",
          ),
          const SizedBox(height: 12),
          Text(
            "About You:",
            style: AppTextStyles.getLato(18, 6.weight),
          ),
          20.ph,
          CustomTextField(
            controller: c.bioController,
            label: "Bio/Description",
            maxLines: 8,
            hintText: "Tell us about yourself...",
            type: TextInputType.multiline,
          ),
          20.ph,
          Text("Professional License:",
              style: AppTextStyles.getLato(18, 6.weight)),
          10.ph,
          // --- Licence Upload ---
          UploadBox2(
            title: "Licence",
            isEdit: c.isLicenseEdit,
            imageWidget: Obx(() {
              if (c.licenseFilePath.value.isEmpty) {
                return const SizedBox(); // nothing selected yet
              } else if (c.licenseFilePath.value
                  .toLowerCase()
                  .endsWith(".pdf")) {
                return Image.asset("assets/icons/pdf.png",
                    width: 50); // 🔥 your pdf icon
              } else {
                return SizedBox(
                  height: 150,
                  width: context.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(File(c.licenseFilePath.value),
                        fit: BoxFit.cover),
                  ),
                );
              }
            }),
            fileName: c.licenseFileName,
            progress: c.licenseUploadProgress,
            onTap: () => c.pickAndUploadLicense(),
            onDelete: () => c.deleteLicense(),
          ),

          20.ph,

          Text(
            "Professional Certificate:",
            style: AppTextStyles.getLato(18, 6.weight),
          ),

          10.ph,

// --- Certificate Upload ---
          UploadBox2(
            title: "Certificate",
            isEdit: c.isCertificateEdit,
            imageWidget: Obx(() {
              if (c.certificateFilePath.value.isEmpty) {
                return const SizedBox();
              } else if (c.certificateFilePath.value
                  .toLowerCase()
                  .endsWith(".pdf")) {
                return Image.asset("assets/icons/pdf.png", width: 50);
              } else {
                return SizedBox(
                  height: 150,
                  width: context.width,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(File(c.certificateFilePath.value),
                          fit: BoxFit.cover)),
                );
              }
            }),
            fileName: c.certificateFileName,
            progress: c.certificateUploadProgress,
            onTap: () => c.pickAndUploadCertificate(),
            onDelete: () => c.deleteCertificate(),
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Consultation & Pricing:",
                  style: AppTextStyles.getLato(18, 6.weight)),
              GestureDetector(
                  onTap: () {
                    Get.to(() => ConsultationPricingScreen());
                  },
                  child: Image.asset(
                    Assets.pngIconsPen,
                    height: 22,
                  ))
            ],
          ),
          15.ph,
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: "hour",
                  groupValue: c.selectedPricingType.value,
                  onChanged: (val) => c.selectPricingType(val!),
                  activeColor: AppColors.primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Per Hour",
                      style: AppTextStyles.getLato(12, 4.weight),
                    ),
                    3.ph,
                    Text(
                      "€${c.priceControllers["Per Hour"]!.text}",
                      style: AppTextStyles.getLato(
                          12, 4.weight, AppColors.hintColor),
                    )
                  ],
                ),
              ],
            ),
          ),
          15.ph,
          Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Radio<String>(
                  value: "session",
                  groupValue: c.selectedPricingType.value,
                  onChanged: (val) => c.selectPricingType(val!),
                  activeColor: AppColors.primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Per Session",
                      style: AppTextStyles.getLato(12, 4.weight),
                    ),
                    3.ph,
                    Text(
                      "€${c.priceControllers["Per Session"]!.text}",
                      style: AppTextStyles.getLato(
                          12, 4.weight, AppColors.hintColor),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          CustomButton(
              onPressed: () => c.updateProfile(), text: "Update Profile"),
        ],
      ),
    );
  }
}

class ConsultationPricingScreen extends StatelessWidget {
  final c = Get.find<EditProfileController>();

  ConsultationPricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Consultation & Pricing"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              controller: c.priceControllers["Per Hour"]!,
              label: "Per Hour",
              hintText: "€100.00",
              type: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (val) => c.updatePrice("Per Hour", val),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: c.priceControllers["Per Session"]!,
              label: "Per Session",
              hintText: "€200.00",
              type: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (val) => c.updatePrice("Per Session", val),
            ),
            const Spacer(),
            CustomButton(
              onPressed: () => c.updateProfile(),
              text: "Save Changes",
            )
          ],
        ),
      ),
    );
  }
}
