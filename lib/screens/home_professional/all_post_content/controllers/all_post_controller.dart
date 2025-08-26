import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_professional/all_reviews/controllers/review_controllers.dart';
import 'package:mylimbcoach/widgets/custom_snackbar.dart';

class AllPostController extends GetxController {
  // ✅ Master list (never changes)
  final allPosts = [
    {
      "category": "Prosthetics",
      "title": "Understanding Prosthetic Liners",
      "desc":
          "Prosthetic liners are the unsung heroes of daily comfort. They're the crucial interface between your residual limb and the prosthetic socket, and their design directly impacts your comfort, skin health, and overall mobility. While they may seem like a simple sleeve, the technology behind them is advancing at an incredible pace.",
      "likes": "1.5k",
      "comments": "14",
      "shares": "200"
    },
    {
      "category": "Paediatric",
      "title": "5 Daily Exercises for Amputee Mobility",
      "desc":
          "Prosthetic liners are the unsung heroes of daily comfort. They're the crucial interface between your residual limb and the prosthetic socket, and their design directly impacts your comfort, skin health, and overall mobility. While they may seem like a simple sleeve, the technology behind them is advancing at an incredible pace.Prosthetic liners are the unsung heroes of daily comfort. They're the crucial interface between your residual limb and the prosthetic socket, and their design directly impacts your comfort, skin health, and overall mobility. While they may seem like a simple sleeve, the technology behind them is advancing at an incredible pace.",
      "likes": "2.1k",
      "comments": "36",
      "shares": "540"
    },
    {
      "category": "Lower Limb",
      "title": "Watch: Overcoming Challenges",
      "desc":
          "Prosthetic liners are the unsung heroes of daily comfort. They're the crucial interface between your residual limb and the prosthetic socket, and their design directly impacts your comfort, skin health, and overall mobility. While they may seem like a simple sleeve, the technology behind them is advancing at an incredible pace.",
      "likes": "3.8k",
      "comments": "82",
      "shares": "1.1k",
      "videoUrl":
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"
    }
  ];

  // ✅ Currently visible posts
  var posts = <Map<String, dynamic>>[].obs;

  // Filters
  var selectedCategories = <String>[].obs;

  // Search query
  var searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
    posts.assignAll(allPosts); // show all by default
  }

  // 🔹 Apply category filters
  void applyFilters({List<String>? categories}) {
    selectedCategories.assignAll(categories ?? []);
    _filterAndSearch();
  }

  // 🔹 Search function
  void searchPosts(String query) {
    searchQuery.value = query;
    _filterAndSearch();
  }

  // 🔹 Combines filters + search
  void _filterAndSearch() {
    var filtered = allPosts;

    // Filter by category
    if (selectedCategories.isNotEmpty &&
        !selectedCategories.contains("All Categories")) {
      filtered = filtered
          .where((p) => selectedCategories.contains(p["category"]))
          .toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((p) =>
              p["title"]!
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              p["desc"]!
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              p["category"]!
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    posts.assignAll(filtered);
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

  RxList<Review> comments = <Review>[].obs;

  void _loadDummyData() {
    comments.addAll([
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
}
