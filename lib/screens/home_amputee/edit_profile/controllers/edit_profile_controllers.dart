import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AmputeeEditProfileController extends GetxController {
  // Personal Details
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final selectedPricingType = "Per Hour".obs;

  // Images
  Rx<File?> profileImage = Rx<File?>(null);
  Rx<File?> licenseImage = Rx<File?>(null);
  Rx<File?> certificateImage = Rx<File?>(null);

  final picker = ImagePicker();

  Future<void> pickImage(Rx<File?> target) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      target.value = File(picked.path);
    }
  }

  void updateProfile() {
    Get.back();
  }

  void selectPricingType(String type) {
    selectedPricingType.value = type;
  }

  // --- Step 2: Specialties & Expertise ---
  var licenseUploadProgress = 0.0.obs;
  var certificateUploadProgress = 0.0.obs;
  var licenseFileName = "".obs;
  var certificateFileName = "".obs;
  // Upload states
  var isLicenseEdit = false.obs;
  var isCertificateEdit = false.obs;
  var licenseFilePath = "".obs; // ✅ store file path
  var certificateFilePath = "".obs; // ✅ store file path
  // --- File Picker & Upload ---
  Future<void> pickAndUploadLicense() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      licenseFileName.value = result.files.single.name;
      licenseFilePath.value = result.files.single.path ?? ""; // ✅ save path
      isLicenseEdit.value = true; // ✅ enable edit mode
      licenseImage.value = File(result.files.single.path!); // ✅ also store File
      await _simulateUpload(licenseUploadProgress);
    }
  }

  Future<void> pickAndUploadCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      certificateFileName.value = result.files.single.name;
      certificateFilePath.value = result.files.single.path ?? ""; // ✅ save path

      isCertificateEdit.value = true; // ✅ enable edit mode
      certificateImage.value =
          File(result.files.single.path!); // ✅ also store File

      await _simulateUpload(certificateUploadProgress);
    }
  }

  void deleteLicense() {
    licenseFileName.value = "";
    licenseFilePath.value = "";
    licenseImage.value = null;
    licenseUploadProgress.value = 0;
    isLicenseEdit.value = false;
    licenseUploadProgress.value = 0.0;
  }

  void deleteCertificate() {
    certificateFileName.value = "";
    certificateFilePath.value = "";
    certificateImage.value = null;
    certificateUploadProgress.value = 0;
    isCertificateEdit.value = false;
    certificateUploadProgress.value = 0.0;
  }

  Future<void> _simulateUpload(RxDouble progress) async {
    progress.value = 0.0;
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      progress.value = i / 100;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
