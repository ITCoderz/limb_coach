import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/auth/views/add_profile_screen.dart';
import 'package:mylimbcoach/screens/auth/views/under_review_screen.dart';
import 'package:mylimbcoach/widgets/custom_snackbar.dart';

class AuthController extends GetxController {
  // TextEditingControllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  // States
  var rememberMe = false.obs;
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  // Validation + Button State
  var isButtonEnabled = false.obs; // for Sign In
  var isSignUpButtonEnabled = false.obs; // for Sign Up
  var areFilesUploaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Attach listeners
    emailController.addListener(_validateSignInFields);
    passwordController.addListener(_validateSignInFields);
    firstNameController.addListener(_validateSignUpFields);
    lastNameController.addListener(_validateSignUpFields);
    emailController.addListener(_validateSignUpFields);
    passwordController.addListener(_validateSignUpFields);
    confirmPasswordController.addListener(_validateSignUpFields);
    // Watch upload progress and update `areFilesUploaded`
    everAll([licenseUploadProgress, certificateUploadProgress], (_) {
      areFilesUploaded.value = licenseUploadProgress.value == 1.0 &&
          certificateUploadProgress.value == 1.0;
    });
  }

// --- Upload States ---
  var licenseUploadProgress = 0.0.obs; // 0.0 → not uploaded, 1.0 → done
  var certificateUploadProgress = 0.0.obs;

// --- File Names ---
  var licenseFileName = "".obs;
  var certificateFileName = "".obs;

// --- File Picker + Upload Simulation ---
  Future<void> pickAndUploadLicense() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      licenseFileName.value = result.files.single.name; // store name
      await _simulateUpload(licenseUploadProgress);
    } else {
      AppSnackbar.error("Error", "No file selected");
    }
  }

  Future<void> pickAndUploadCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      certificateFileName.value = result.files.single.name; // store name
      await _simulateUpload(certificateUploadProgress);
    } else {
      AppSnackbar.error("Error", "No file selected");
    }
  }

  Future<void> _simulateUpload(RxDouble progress) async {
    progress.value = 0.0;
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 3));
      progress.value = i / 100; // → goes up to 0.75 (75%)
    }
  }

  // --- Toggle Functions ---
  void toggleRememberMe(bool bool) => rememberMe.value = !rememberMe.value;
  void togglePassword() => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmPassword() =>
      obscureConfirmPassword.value = !obscureConfirmPassword.value;

  // --- Validation Helpers ---
  void _validateSignInFields() {
    isButtonEnabled.value = emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        emailController.text.isEmail;
  }

  void _validateSignUpFields() {
    final name = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    isSignUpButtonEnabled.value = name.isNotEmpty &&
        lastName.isNotEmpty &&
        validateEmail(email) &&
        validatePassword(password) &&
        password == confirmPassword;
    print("${isSignUpButtonEnabled.value} -------------------");
  }

  bool validateEmail(String email) {
    return RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(email.trim());
  }

  bool validatePassword(String password) {
    return password.trim().length >= 4;
  }

  // --- Sign In ---
  void signIn(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!validateEmail(email)) {
      AppSnackbar.error("Error", "Enter a valid email");
      return;
    }
    if (!validatePassword(password)) {
      AppSnackbar.error("Error", "Password must be at least 6 characters");
      return;
    }

    // ✅ API call
    print("Signing in with $email and $password");
    Get.to(() => AddProfileScreen());
    // AppSnackbar.success("Success", "Signed in successfully");
  }

  // --- Sign Up ---
  void signUp(BuildContext context) {
    final name = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (!isSignUpButtonEnabled.value) {
      AppSnackbar.error("Error", "Please fill all fields correctly");
      return;
    }

    // ✅ API call
    print("Signing up with $name, $email, $password");
    Get.to(() => UnderReviewScreen());
    goToNextStep();
  }

  // --- Step Navigation ---
  var currentStep = 1.obs; // 1 = Account Creation, 2 = License Upload

  void goToNextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void goToPreviousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }
}
