import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home/all_reviews/controllers/review_controllers.dart';
import 'package:mylimbcoach/screens/home/all_reviews/views/filter_screen.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

import 'rating_bar_row.dart';

class AllReviewsScreen extends StatelessWidget {
  final ReviewsController c = Get.put(ReviewsController());

  AllReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("All Reviews"),
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
                          Row(
                            children: [
                              10.pw,
                              Icon(
                                Icons.favorite,
                                size: 18,
                                color: AppColors.primaryColor,
                              ),
                              5.pw,
                              Text(
                                "Like",
                                style: AppTextStyles.getLato(11, 4.weight),
                              ),
                              10.pw,
                              GestureDetector(
                                onTap: () => c.startReply(r.id),
                                child: Image.asset(
                                  Assets.pngIconsComments,
                                  height: 20,
                                ),
                              ),
                              5.pw,
                              GestureDetector(
                                onTap: () => c.startReply(r.id),
                                child: Text(
                                  "Reply",
                                  style: AppTextStyles.getLato(11, 4.weight),
                                ),
                              ),
                              10.pw,
                              GestureDetector(
                                onTap: () {
                                  openReportDialog(r.id);
                                },
                                child: Image.asset(
                                  Assets.pngIconsReportReview,
                                  height: 14,
                                ),
                              ),
                              5.pw,
                              GestureDetector(
                                onTap: () {
                                  openReportDialog(r.id);
                                },
                                child: Text(
                                  "Report",
                                  style: AppTextStyles.getLato(11, 4.weight),
                                ),
                              )
                            ],
                          ),

                          // 🔹 Reply Box (only for the active review)
                          Obx(() {
                            if (c.replyingToId.value != r.id) {
                              return SizedBox.shrink();
                            }
                            return Column(children: [
                              10.ph,
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: AppColors.borderColor,
                                        width: 0.5)),
                                child: TextField(
                                  controller: c.replyController,
                                  onChanged: (val) => c.replyText.value = val,
                                  decoration: InputDecoration(
                                    hintText: "Type your reply...",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                  ),
                                ),
                              ),
                              10.ph,
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        elevation: 0,
                                        fixedSize: Size(162, 45),
                                        side: BorderSide(
                                            color: AppColors.borderColor,
                                            width: 0.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onPressed: c.cancelReply,
                                      child: Text(
                                        "Cancel",
                                        style: AppTextStyles.getLato(
                                            16, 4.weight, AppColors.hintColor),
                                      ),
                                    ),
                                  ),
                                  10.pw,
                                  Expanded(
                                    child: Obx(() => CustomButton(
                                          onPressed: c.replyText.value.isEmpty
                                              ? () {}
                                              : () => c.submitReply(
                                                  r.id, c.replyText.value),
                                          backgroundColor:
                                              c.replyText.value.isEmpty
                                                  ? AppColors.primaryColor
                                                      .withOpacity(0.45)
                                                  : AppColors.primaryColor,
                                          borderColor: c.replyText.value.isEmpty
                                              ? AppColors.primaryColor
                                                  .withOpacity(0.45)
                                              : AppColors.primaryColor,
                                          text: "Reply",
                                        )),
                                  ),
                                ],
                              )
                            ]);
                          })
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
                                    : Colors.grey)),
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

  Widget _replyBottomSheet(String reviewId) {
    final TextEditingController replyCtrl = TextEditingController();
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Write a Reply",
              style: AppTextStyles.getLato(16, FontWeight.bold)),
          SizedBox(height: 10),
          TextField(
            controller: replyCtrl,
            decoration: InputDecoration(
                hintText: "Type your reply...",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      fixedSize: Size(162, 4),
                      side:
                          BorderSide(color: AppColors.primaryColor, width: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: Text("Cancel")),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      if (replyCtrl.text.isNotEmpty) {
                        Get.find<ReviewsController>()
                            .submitReply(reviewId, replyCtrl.text);
                      }
                    },
                    child: Text("Reply")),
              ),
            ],
          )
        ],
      ),
    );
  }

  void openReplySheet(String reviewId) {
    Get.bottomSheet(_replyBottomSheet(reviewId),
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))));
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

Widget reportDialog(String reviewId) {
  final RxList<String> selectedReasons = <String>[].obs;
  final reasons = [
    "Fake Information",
    "Privacy Violation",
    "Discrimination or Hate Speech",
    "Harassment",
    "Inappropriate Language",
    "Irrelevant Content",
    "Threats of Violence",
  ];

  return AlertDialog(
      title: Text(
        "Report Comment?",
        style: AppTextStyles.getLato(16, FontWeight.w600),
      ),
      content: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select from the reasons below why you want to report this comment?",
              style: AppTextStyles.getLato(13, 4.weight),
            ),
            10.ph,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: reasons
                  .map((r) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: selectedReasons.contains(r),
                            activeColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            side: BorderSide(
                              width: 1,
                              color: AppColors.borderColor,
                            ),
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (val) {
                              if (val == true) {
                                selectedReasons.add(r);
                              } else {
                                selectedReasons.remove(r);
                              }
                            },
                          ),
                          Expanded(
                            child: Text(
                              r,
                              style: AppTextStyles.getLato(14, FontWeight.w400),
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  fixedSize: Size(162, 45),
                  side: BorderSide(color: AppColors.primaryColor, width: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Go Back",
                  style: AppTextStyles.getLato(
                      16, 4.weight, AppColors.primaryColor),
                ),
              ),
            ),
            10.pw,
            Expanded(
              child: CustomButton(
                onPressed: () {
                  Get.back();
                },
                text: "Report",
              ),
            )
          ]),
        )
      ]);
}

void openReportDialog(String reviewId) {
  Get.dialog(reportDialog(reviewId));
}
