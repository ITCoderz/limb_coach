import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mylimbcoach/screens/auth/views/profile_completed_screen.dart';

class ProfileController extends GetxController {
  // --- Step 1: About You ---
  final bioController = TextEditingController();
  final reasonController = TextEditingController();

  // --- Step 2: Specialties & Expertise ---
  var licenseUploadProgress = 0.0.obs;
  var certificateUploadProgress = 0.0.obs;
  var licenseFileName = "".obs;
  var certificateFileName = "".obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedDateAmputee = Rx<DateTime?>(null);

  // --- Step 3: Consultation & Pricing ---
  var consultationType = "".obs;
  final consultationFeeController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  // --- Step 4: Contact & Location ---
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  var selectedCountry = "".obs;

  final locationController = TextEditingController();

  // --- Step Logic ---
  var currentStep = 1.obs;
  var isStepValid = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  // List of specialities
  final List<String> specialities = [
    "Pediatric Prosthetics",
    "Orthotics",
    "Upper Limb Prosthetics",
    "Lower Limb Prosthetics",
    "Sports Prosthetics",
    "Rehabilitation Therapy",
    "Amputee Counseling",
  ];

  // Track selected checkboxes
  var selected = <String>[].obs;

  void toggleSelection(String speciality, bool isSelected) {
    if (isSelected) {
      selected.add(speciality);
    } else {
      selected.remove(speciality);
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(currentStep, (_) => validateStep());
    bioController.addListener(validateStep);
    consultationFeeController.addListener(validateStep);
    emailController.addListener(validateStep);
    phoneController.addListener(validateStep);
    locationController.addListener(validateStep);

    everAll([licenseUploadProgress, certificateUploadProgress], (_) {
      validateStep();
    });
  }

  // --- File Picker & Upload ---
  Future<void> pickAndUploadLicense() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      licenseFileName.value = result.files.single.name;
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
      await _simulateUpload(certificateUploadProgress);
    }
  }

  Future<void> _simulateUpload(RxDouble progress) async {
    progress.value = 0.0;
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      progress.value = i / 100;
    }
  }

  // --- Step Navigation ---
  void goToNextStep() {
    if (currentStep.value < 4) {
      currentStep.value++;
    } else {
      Get.offAll(() => ProfileCompletedScreen());
    }
  }

  void goToPreviousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  // --- Validation ---
  void validateStep() {
    switch (currentStep.value) {
      case 1:
        isStepValid.value = bioController.text.trim().isNotEmpty;

        // isStepValid.value = firstNameController.text.trim().isNotEmpty &&
        //     lastNameController.text.isNotEmpty &&
        //     selectedDate.value != null &&
        //     selectedCountry.value.isNotEmpty &&
        //     selectedGender.value.isNotEmpty;
        break;
      case 2:
        isStepValid.value = selected.isNotEmpty &&
            licenseUploadProgress.value == 1.0 &&
            certificateUploadProgress.value == 1.0;
        break;
      case 3:
        isStepValid.value = consultationType.value.isNotEmpty &&
                consultationType.value.toString() == 'custom'
            ? consultationFeeController.text.isNotEmpty
            : 1 == 1;
        break;
      case 4:
        isStepValid.value = emailController.text.isEmail &&
            phoneController.text.trim().isNotEmpty &&
            selectedCountry.value.isNotEmpty &&
            locationController.text.trim().isNotEmpty;
        break;
      default:
        isStepValid.value = true;
    }
  }
}
