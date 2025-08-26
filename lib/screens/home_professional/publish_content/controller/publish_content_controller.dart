import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_professional/publish_content/views/publish_success_screen.dart';
import 'package:mylimbcoach/widgets/custom_snackbar.dart';

class PublishController extends GetxController {
  var contentType = "Article".obs;
  var title = "".obs;
  var content = "".obs;
  var visibility = "Public".obs;
  var allowComments = false.obs;
  var uploadedVideo = "".obs;
  var uploadProgress = 0.0.obs;
  var uploadedFileName = "".obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  List<String> allTags = [
    "Pediatric",
    "Research",
    "Upper Limb",
    "Lower Limb",
    "Rehabilitation",
    "Exercise"
  ];
  var selectedTags = <String>[].obs;

  /// ✅ Computed: Button Enable/Disable
  RxBool isPublishEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();

    /// Listen to all form fields
    everAll([title, content, contentType, uploadedVideo, selectedTags], (_) {
      validateForm();
    });
  }

  void validateForm() {
    if (title.value.trim().isEmpty) {
      isPublishEnabled.value = false;
      return;
    }

    if (contentType.value == "Article" && content.value.trim().isEmpty) {
      isPublishEnabled.value = false;
      return;
    }

    if (contentType.value == "Video" && uploadedVideo.value.isEmpty) {
      isPublishEnabled.value = false;
      return;
    }

    // Example: Require at least 1 tag
    if (selectedTags.isEmpty) {
      isPublishEnabled.value = false;
      return;
    }

    // ✅ All conditions satisfied
    isPublishEnabled.value = true;
  }

  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      uploadedVideo.value = file.path ?? "";
      uploadedFileName.value = file.name;
      uploadProgress.value = 1.0;

      AppSnackbar.success("Success", "Video uploaded: ${file.name}");
    } else {
      AppSnackbar.error("Cancelled", "No video selected");
    }
  }

  void toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
    validateForm();
  }

  void removeTag(String tag) {
    selectedTags.remove(tag);
    validateForm();
  }

  void publish() {
    if (!isPublishEnabled.value) return;

    Get.to(() => PublishSuccessScreen());
  }
}
