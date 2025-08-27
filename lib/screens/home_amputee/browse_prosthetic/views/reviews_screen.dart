// lib/screens/shop/views/reviews_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/browse_prosthetic/views/write_review_screen.dart';
import 'package:mylimbcoach/screens/home_professional/all_reviews/controllers/review_controllers.dart';
import 'package:mylimbcoach/screens/home_professional/all_reviews/views/filter_screen.dart';
import 'package:mylimbcoach/screens/home_professional/all_reviews/views/rating_bar_row.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

import '../../../home_professional/homepage/components/custom_app_bar.dart';

class ReviewsScreen extends StatelessWidget {
  ReviewsScreen({super.key, required this.product});
  final Map<String, dynamic> product;
  final c = Get.put(ReviewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("All Reviews"),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            CustomButton(
                text: "Write Review",
                onPressed: () {
                  Get.to(() => WriteReviewScreen());
                }),
          ],
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            _ratingHeader(),
            20.ph,
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.borderColor, width: 0.5)),
              child: Column(
                children: [
                  RatingBarRow(
                    title: "Excellent",
                    color: Color(0xff4F9A62),
                    fillPercent: 0.8, // 80%
                  ),
                  RatingBarRow(
                    title: "Good",
                    color: Color(0xff90B356),
                    fillPercent: 0.7,
                  ),
                  RatingBarRow(
                    title: "Average",
                    color: Color(0xffDED74A),
                    fillPercent: 0.6,
                  ),
                  RatingBarRow(
                    title: "Poor",
                    color: Color(0xffD93F21),
                    fillPercent: 0.5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Text("All Reviews",
                      style: AppTextStyles.getLato(18, 6.weight)),
                  Text(" (${c.filteredReviews.length})",
                      style: AppTextStyles.getLato(
                          16, 4.weight, AppColors.hintColor)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Expanded(child: _buildSearchBar()),
                    10.pw,
                    GestureDetector(
                      onTap: () async {
                        var result = await Get.to(() =>
                            ReviewFiltersScreen()); // Reuse your FiltersScreen
                        if (result != null) {
                          c.selectedRatings.assignAll(result["ratings"] ??
                              []); // expecting ratings list from filter
                          c.selectedRatings.assignAll(result["ratings"] ??
                              []); // expecting ratings list from filter
                          c.fromDate.value = result["fromDate"];
                          c.toDate.value = result["toDate"];
                          c.applyFilters();
                        }
                      },
                      child: Container(
                        height: 48,
                        width: 79,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: AppColors.borderColor, width: 0.5)),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.pngIconsFilter,
                              height: 22,
                            ),
                            5.pw,
                            Text(
                              "Filter",
                              style: AppTextStyles.getLato(13, 4.weight),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  itemCount: c.filteredReviews.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, i) {
                    final r = c.filteredReviews[i];
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.borderColor, width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  r.image,
                                  height: 49,
                                ),
                              ),
                              10.pw,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      r.userName,
                                      style:
                                          AppTextStyles.getLato(14, 6.weight),
                                    ),
                                    Row(
                                      children: List.generate(
                                          5,
                                          (index) => Image.asset(
                                                Assets.pngIconsStar,
                                                color: index < r.rating
                                                    ? Colors.amber
                                                    : Colors.grey,
                                                height: 16,
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${r.date.day}/${r.date.month}/${r.date.year}",
                                style: AppTextStyles.getLato(
                                    11, 4.weight, AppColors.hintColor),
                              ),
                            ],
                          ),
                          10.ph,
                          Text(
                            r.comment,
                            style: AppTextStyles.getLato(12, 4.weight),
                          ),
                          20.ph,
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _ratingHeader() {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(c.avgRating.value.toStringAsFixed(1),
                      style: AppTextStyles.getLato(64, 8.weight)),
                  20.pw,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            5,
                            (i) => Image.asset(Assets.pngIconsStar,
                                color: i < c.avgRating.value.round()
                                    ? Colors.amber
                                    : Colors.amber.withOpacity(0.3))),
                      ),
                      5.ph,
                      Text("Based on ${c.reviews.length} Reviews"),
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        autofocus: false,
        // onChanged: (val) => c.setSearch(val), // ✅ live search

        decoration: InputDecoration(
          hintText: 'Search Here...',
          hintStyle: AppTextStyles.getLato(13, 4.weight, Color(0xffA6A6A6)),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xffA6A6A6),
          ),
          filled: false,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
        ),
      ),
    );
  }
}
