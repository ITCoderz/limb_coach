import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/auth/views/profile_completed_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/homepage/views/home_page.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/views/home_page.dart';
import 'package:mylimbcoach/screens/welcome/controllers/welcome_controller.dart';

class AmputeeProfileController extends GetxController {
  // --- Step 1: About You ---
  final bioController = TextEditingController();
  final reasonController = TextEditingController();

  // --- Step 2: Specialties & Expertise ---
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedDateAmputee = Rx<DateTime?>(null);

  // --- Step 3: Consultation & Pricing ---
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  // --- Step 4: Contact & Location ---
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  var selectedCountry = "".obs;
  var selectedGender = "".obs;
  var selectedLevelAmputee = "".obs;
  var upperLevelAmputee = "".obs;
  var lowerLevelAmputee = "".obs;
  final locationController = TextEditingController();

  // --- Step Logic ---
  var currentStep = 1.obs;
  var isStepValid = false.obs;

  // List of specialities
  final List<String> comfortLevelWithCurrentDevice = [
    "Very Uncomfortable",
    "Uncomfortable",
    "Neutral",
    "Comfortable",
    "Very Comfortable",
  ];
  final List<String> goals = [
    "Find a Certified Professional (Prosthetist/Therapist)",
    "Browse & Purchase Prosthetic Devices",
    "Connect with other Amputees/Peers",
    "Access Educational Content & Resources",
    "Track my Recovery Progress",
    "Learn about New Technologies",
    "Manage My Appointments",
    "Others",
  ];
  final List<String> pastDevice = [
    "Temporary Prosthesis",
    "First Permanent Prosthesis",
    "Specific Brand/Model",
  ];
  final List<String> preferences = [
    "Active Lifestyle",
    "Maximum Comfort",
    "Cosmetic Appearance",
    "Durability",
  ];

  // Track selected checkboxes
  var selectedComfortDevices = <String>[].obs;
  var selectedPastDevices = <String>[].obs;
  var selectedPreferences = <String>[].obs;
  var selectedGoals = <String>[].obs;

  void toggleSelectionGoals(String speciality, bool isSelected) {
    if (isSelected) {
      selectedGoals.add(speciality);
    } else {
      selectedGoals.remove(speciality);
    }
  }

  void toggleSelectionComfortDevices(String speciality, bool isSelected) {
    if (isSelected) {
      selectedComfortDevices.add(speciality);
    } else {
      selectedComfortDevices.remove(speciality);
    }
  }

  void toggleSelectionPastDevices(String speciality, bool isSelected) {
    if (isSelected) {
      selectedPastDevices.add(speciality);
    } else {
      selectedPastDevices.remove(speciality);
    }
  }

  void toggleSelectionPreferences(String speciality, bool isSelected) {
    if (isSelected) {
      selectedPreferences.add(speciality);
    } else {
      selectedPreferences.remove(speciality);
    }
  }

  @override
  void onInit() {
    super.onInit();

    // 🔄 Always revalidate when current step changes
    ever(currentStep, (_) => validateStep());

    // 🔄 Watch Rx fields and revalidate on change
    everAll([
      selectedDate,
      selectedDateAmputee,
      selectedCountry,
      selectedGender,
      selectedLevelAmputee,
      upperLevelAmputee,
      lowerLevelAmputee,
      selectedComfortDevices,
      selectedPastDevices,
      selectedPreferences,
      selectedGoals,
    ], (_) => validateStep());

    // --- Add listeners for all text controllers used in validation ---
    firstNameController.addListener(validateStep);
    lastNameController.addListener(validateStep);
    bioController.addListener(validateStep);
    reasonController.addListener(validateStep);
    emailController.addListener(validateStep);
    phoneController.addListener(validateStep);
    locationController.addListener(validateStep);
  }

  // --- Step Navigation ---
  void goToNextStep({bool skipCall = false}) {
    if (currentStep.value < 4) {
      currentStep.value++;
    } else {
      if (skipCall) {
        if (Get.find<UserTypeController>().isProfessional()) {
          Get.offAll(() => ProfessionalDashboardScreen());
        } else {
          Get.offAll(() => AmputeeDashboardScreen());
        }
      } else {
        Get.offAll(() => ProfileCompletedScreen());
      }
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
      case 1: // Personal Details
        isStepValid.value = firstNameController.text.trim().isNotEmpty &&
            lastNameController.text.trim().isNotEmpty &&
            selectedDate.value != null &&
            selectedCountry.value.isNotEmpty &&
            selectedGender.value.isNotEmpty;

        print("🔍 Step 1 Validation:");
        print(" - First Name: ${firstNameController.text.trim().isNotEmpty}");
        print(" - Last Name: ${lastNameController.text.trim().isNotEmpty}");
        print(" - DOB Selected: ${selectedDate.value != null}");
        print(" - Country Selected: ${selectedCountry.value.isNotEmpty}");
        print(" - Gender Selected: ${selectedGender.value.isNotEmpty}");
        break;

      case 2: // Limb Condition
        isStepValid.value = selectedLevelAmputee.value.isNotEmpty &&
            ((selectedLevelAmputee.value == "Upper Limb Amputation" &&
                    upperLevelAmputee.value.isNotEmpty) ||
                (selectedLevelAmputee.value == "Lower Limb Amputation" &&
                    lowerLevelAmputee.value.isNotEmpty)) &&
            selectedDateAmputee.value != null &&
            reasonController.text.trim().isNotEmpty;

        print("🔍 Step 2 Validation:");
        print(" - Selected Level Amputee: ${selectedLevelAmputee.value}");
        print(" - Upper Level Amputee: ${upperLevelAmputee.value}");
        print(" - Lower Level Amputee: ${lowerLevelAmputee.value}");
        print(" - Date Amputee Selected: ${selectedDateAmputee.value != null}");
        print(" - Reason Provided: ${reasonController.text.trim().isNotEmpty}");
        break;

      case 3: // Device Journey
        isStepValid.value = selectedComfortDevices.isNotEmpty &&
            selectedPastDevices.isNotEmpty &&
            selectedPreferences.isNotEmpty;

        print("🔍 Step 3 Validation:");
        print(
            " - Comfort Devices Selected: ${selectedComfortDevices.isNotEmpty}");
        print(" - Past Devices Selected: ${selectedPastDevices.isNotEmpty}");
        print(" - Preferences Selected: ${selectedPreferences.isNotEmpty}");
        break;

      case 4: // Goals
        isStepValid.value = selectedGoals.isNotEmpty;

        print("🔍 Step 4 Validation:");
        print(" - Goals Selected: ${selectedGoals.isNotEmpty}");
        break;

      default:
        isStepValid.value = false;
        print("⚠️ Invalid Step: ${currentStep.value}");
    }

    // ✅ Final step validation result
    print(
        "✅ Step ${currentStep.value} validation result => ${isStepValid.value}");
  }
}
