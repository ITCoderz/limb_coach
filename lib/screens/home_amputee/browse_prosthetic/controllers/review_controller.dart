// lib/screens/shop/controllers/review_controller.dart
import 'package:get/get.dart';

class AmputeeReviewController extends GetxController {
  // For the selected product
  final reviews = <Map<String, dynamic>>[
    {
      "name": "Vivien Arthur",
      "rating": 5.0,
      "text": "Excellent control and fit.",
      "date": "Mar 2025"
    },
    {
      "name": "John David",
      "rating": 4.0,
      "text": "Great value. Needs fine-tuning.",
      "date": "Feb 2025"
    },
  ].obs;

  double get avg => reviews.isEmpty
      ? 0
      : reviews.fold(0.0, (s, r) => s + (r["rating"] as double)) /
          reviews.length;

  void addReview(double rating, String text, {String? photoPath}) {
    reviews.insert(0, {
      "name": "You",
      "rating": rating,
      "text": text,
      "date": "Now",
      "photo": photoPath,
    });
  }
}
