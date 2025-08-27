import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_amputee/track_order/conrollers/track_order_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/track_order/views/track_order_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class TrackOrderListScreen extends StatelessWidget {
  final controller = Get.put(TrackOrderController());

  TrackOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Track Order"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.filteredTrackingIds.length,
                    itemBuilder: (context, index) {
                      final id = controller.filteredTrackingIds[index];
                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide(
                              color: AppColors.borderColor, width: 0.5),
                        ),
                        child: ListTile(
                          title: Text(
                            "Tracking ID: $id",
                            style: AppTextStyles.getLato(14, FontWeight.w400),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,
                              size: 16, color: AppColors.hintColor),
                          onTap: () {
                            controller.selectTrackingId(id);
                            Get.to(() => TrackOrderScreen());
                          },
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Custom Search Bar
  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        onChanged: (value) => controller.searchText.value = value,
        decoration: InputDecoration(
          hintText: 'Search Track ID...',
          hintStyle:
              AppTextStyles.getLato(13, 4.weight, const Color(0xffA6A6A6)),
          prefixIcon: const Icon(Icons.search, color: Color(0xffA6A6A6)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Color(0xffDEDEDE), width: 0.5),
          ),
        ),
      ),
    );
  }
}
