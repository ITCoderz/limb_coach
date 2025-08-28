import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/all_reviews/controllers/review_controllers.dart';
import 'package:mylimbcoach/widgets/custom_snackbar.dart';

class ForumController extends GetxController {
  // Search
  RxString searchText = "".obs;
  // Upload states
  RxDouble uploadProgress = 0.0.obs;
  RxString uploadedFileName = "".obs;
  RxBool isEdit = false.obs;
  RxString pickedFilePath = "".obs; // store actual file path

  // Pick & Upload File (Image/Video)
  Future<void> pickAndUploadMedia() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'mp4', 'mov'],
    );

    if (result != null && result.files.isNotEmpty) {
      uploadedFileName.value = result.files.single.name;
      pickedFilePath.value = result.files.single.path ?? "";
      isEdit.value = true;
      await _simulateUpload(uploadProgress);
    }
  }

  deletePic() {
    isEdit.value = false;
    uploadedFileName.value = '';
    uploadProgress.value = 0.0;
  }

  // Fake Upload Progress
  Future<void> _simulateUpload(RxDouble progress) async {
    progress.value = 0.0;
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      progress.value = i / 100;
    }
  }

  var isCertificateEdit = false.obs;
// In ForumController

  // 🔹 Posts (dummy)
  var allPosts = <Map<String, dynamic>>[
    {
      "id": 1,
      "topicId": 1,
      "title": "Welcome to the community!",
      "content": "This is the first post in 'New Amputee Support'.",
      "author": "Admin",
      "likes": "120",
      "comments": "15",
      "shares": "5",
    },
    {
      "id": 2,
      "topicId": 1,
      "title": "How did you adjust?",
      "content": "Share your journey with others here.",
      "author": "John",
      "likes": "88",
      "comments": "30",
      "shares": "12",
    },
    {
      "id": 3,
      "topicId": 2,
      "title": "Cleaning routine",
      "content": "What’s the best way to clean the device daily?",
      "author": "Sarah",
      "likes": "54",
      "comments": "10",
      "shares": "3",
    },
  ].obs;
// Function to get posts by topicId
  List<Map<String, dynamic>> getPostsByTopic(int topicId) {
    return allPosts.where((p) => p["topicId"] == topicId).toList();
  }

  void addPost({
    required int topicId,
    required String title,
    required String content,
  }) {
    allPosts.add({
      "id": allPosts.length + 1,
      "topicId": topicId, // ✅ must be int, not string
      "title": title,
      "content": content,
      "author": "You",
      "likes": 0,
      "comments": 0,
      "shares": 0, // ✅ keep same naming as dummy posts
    });
  }

  // Topics Data
  var allTopics = [
    {
      "id": 1,
      "title": "New Amputee Support",
      "tag": "Trending",
      "posts": 2,
      "description": "A space for new amputees to connect and share experiences"
    },
    {
      "id": 2,
      "title": "Device Maintenance & Care",
      "tag": "Recent",
      "posts": 80,
      "description":
          "Tips & tricks for keeping your prosthetic in top condition"
    },
    {
      "id": 3,
      "title": "Living with Limb Loss",
      "tag": "Trending",
      "posts": 210,
      "description": "Discussions on daily life, challenges and triumphs"
    },
    {
      "id": 4,
      "title": "Sports & Fitness",
      "tag": "Recent",
      "posts": 45,
      "description":
          "Share your athletic journey and get advice on active prosthetics"
    }
  ].obs;

  // Selected filters
  var selectedTopics = <String>[].obs;
  var selectedUseCases = <String>[].obs;

  // Toggle Methods
  void toggleTopic(String topic) {
    if (selectedTopics.contains(topic)) {
      selectedTopics.remove(topic);
    } else {
      selectedTopics.add(topic);
    }
  }

  void toggleUseCase(String useCase) {
    if (selectedUseCases.contains(useCase)) {
      selectedUseCases.remove(useCase);
    } else {
      selectedUseCases.add(useCase);
    }
  }

  // Apply filters (just closes the filter screen, since filtering is reactive)
  void applyFilters() {
    Get.back(); // you don’t need to modify list here, it reacts in `filteredTopics`
  }

  // Computed filtered list
  List<Map<String, dynamic>> get filteredTopics {
    var list = allTopics;

    // Search filter
    if (searchText.isNotEmpty) {
      list = list
          .where((t) => t["title"]
              .toString()
              .toLowerCase()
              .contains(searchText.value.toLowerCase()))
          .toList()
          .obs;
    }

    // Topic filter
    if (selectedTopics.isNotEmpty && !selectedTopics.contains("All Topics")) {
      list = list
          .where((t) => selectedTopics.contains(t["title"].toString()))
          .toList()
          .obs;
    }

    // Use-case filter
    if (selectedUseCases.isNotEmpty &&
        !selectedUseCases.contains("All Use Cases")) {
      list = list
          .where((t) => selectedUseCases.contains(t["tag"].toString()))
          .toList()
          .obs;
    }

    return list;
  }

  RxList<Review> reviews = <Review>[].obs;
  RxList<Review> filteredReviews = <Review>[].obs;

  RxDouble avgRating = 0.0.obs;
  RxMap<int, int> ratingCount = <int, int>{}.obs; // e.g., {5: 80, 4: 20,...}

  // Filters
  RxList<int> selectedRatings = <int>[].obs;
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);
  Rx<DateTime?> toDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    reviews.addAll([
      Review(
        id: "1",
        image: Assets.pngIconsDp,
        userName: "Eion Morgan",
        comment:
            "Dr. Emily White was incredibly helpful. She took the time to explain everything in detail.",
        rating: 5,
        date: DateTime.now().subtract(Duration(days: 2)),
      ),
      Review(
        id: "2",
        image: Assets.pngIconsDp2,
        userName: "Warner Lens",
        comment:
            "I had a very bad experience. There was delay & doctor unavailable.",
        rating: 1,
        date: DateTime.now().subtract(Duration(days: 7)),
      ),
    ]);
  }

  void submitReport(String reviewId, String reason) {
    // TODO: Call API
    Get.back();
    AppSnackbar.success("Reported", "Review reported for: $reason");
  }

  var replyingToId = "".obs;
  var replyText = "".obs;
  final replyController = TextEditingController();

  void startReply(String reviewId) {
    replyingToId.value = reviewId;
    replyText.value = "";
    replyController.clear();
  }

  void cancelReply() {
    replyingToId.value = "";
    replyText.value = "";
    replyController.clear();
  }

  void submitReply(String reviewId, String reply) {
    // 🔹 Your API / logic here
    print("Reply submitted for $reviewId: $reply");

    // reset UI
    cancelReply();
  }
}
