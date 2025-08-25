import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/widgets/custom_snackbar.dart';

import '../../../../generated/assets.dart';

class Review {
  final String id;
  final String userName;
  final String image;
  final String comment;
  final double rating;
  final DateTime date;

  Review({
    required this.id,
    required this.userName,
    required this.image,
    required this.comment,
    required this.rating,
    required this.date,
  });
}

class ReviewsController extends GetxController {
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
    applyFilters();
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

    _calculateStats();
  }

  void _calculateStats() {
    avgRating.value =
        reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;

    ratingCount.value = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var r in reviews) {
      ratingCount[r.rating.toInt()] = (ratingCount[r.rating.toInt()] ?? 0) + 1;
    }
  }

  void applyFilters() {
    filteredReviews.assignAll(reviews.where((r) {
      if (selectedRatings.isNotEmpty &&
          !selectedRatings.contains(r.rating.toInt())) {
        return false;
      }

      if (fromDate.value != null && r.date.isBefore(fromDate.value!)) {
        return false;
      }
      if (toDate.value != null && r.date.isAfter(toDate.value!)) {
        return false;
      }
      return true;
    }).toList());
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
