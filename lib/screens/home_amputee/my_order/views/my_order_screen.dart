import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home_amputee/my_order/controller/my_order_controller.dart';
import 'package:mylimbcoach/screens/home_amputee/my_order/views/order_detail_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/my_order/views/view_receipt_screen.dart';
import 'package:mylimbcoach/screens/home_amputee/track_order/views/track_order_screen.dart';
import 'package:mylimbcoach/screens/home_professional/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

class MyOrderListScreen extends StatelessWidget {
  final controller = Get.put(OrdersController());

  MyOrderListScreen({super.key});

  final tabs = const ["Active Orders", "Past Orders"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: customAppBar("My Orders"),
        body: Column(
          children: [
            /// 🔍 Search
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildSearchBar(),
            ),

            /// 📌 Tabs (fixed with grey underline for all + active underline in primary color)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.hintColor, // grey line for all tabs
                    width: 0.5,
                  ),
                ),
              ),
              child: TabBar(
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: AppColors.hintColor,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: AppColors.primaryColor, // active underline
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: AppTextStyles.getLato(13, 7.weight),
                unselectedLabelStyle: AppTextStyles.getLato(14, 4.weight),
                tabs: tabs.map((e) => Tab(text: e.toUpperCase())).toList(),
              ),
            ),

            /// 📌 Tab Views
            Expanded(
              child: TabBarView(
                children: [
                  _buildOrderList(isActive: true),
                  _buildOrderList(isActive: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Search Bar
  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        onChanged: (value) => controller.searchText.value = value,
        decoration: InputDecoration(
          hintText: 'Search Order ID, Tracking Number...',
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

  /// ✅ Orders List
  Widget _buildOrderList({required bool isActive}) {
    return Obx(() {
      final query = controller.searchText.value;
      final searched = controller.searchOrders(query);

      final orders = isActive
          ? searched.where((o) => o["status"] != "Delivered").toList()
          : searched.where((o) => o["status"] == "Delivered").toList();

      if (orders.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 69,
                width: 69,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(Assets.pngIconsMyOrders),
              ),
              10.ph,
              Text(
                "No Orders Yet!",
                style: AppTextStyles.getLato(18, 6.weight),
              ),
              5.ph,
              Text(
                'Your orders will show here once you’ve placed them',
                textAlign: TextAlign.center,
                style: AppTextStyles.getLato(12, 5.weight, AppColors.hintColor),
              ),
            ],
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(isActive ? "Active Orders" : "Past Orders",
                    style: AppTextStyles.getLato(16, 6.weight)),
                Text(
                  " (${orders.length})",
                  style:
                      AppTextStyles.getLato(16, 4.weight, AppColors.hintColor),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => OrderDetailScreen(
                            order: order,
                            isActive: isActive,
                          ));
                    },
                    child: Card(
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: AppColors.borderColor, width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Order ID: ${order["id"]}",
                                  style: AppTextStyles.getLato(
                                      14, FontWeight.w600),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: order["status"] != "Delivered"
                                        ? AppColors.primaryColor
                                            .withOpacity(0.05)
                                        : Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        order["status"] != "Delivered"
                                            ? Assets.pngIconsProcessing
                                            : Assets.pngIconsTickMark,
                                        height: 18,
                                        color: order["status"] == "Delivered"
                                            ? Colors.green
                                            : AppColors.primaryColor,
                                      ),
                                      5.pw,
                                      Text(
                                        order["status"] ?? "",
                                        style: AppTextStyles.getLato(
                                          12,
                                          6.weight,
                                          order["status"] != "Delivered"
                                              ? AppColors.primaryColor
                                              : Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            5.ph,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Estimated Delivery:",
                                      style: AppTextStyles.getLato(
                                          11, 4.weight, AppColors.hintColor),
                                    ),
                                    5.ph,
                                    Text(
                                      "July 25 - July 28, 2025",
                                      style: AppTextStyles.getLato(
                                        13,
                                        5.weight,
                                      ),
                                    ),
                                  ],
                                ),
                                4.pw,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Items:",
                                      style: AppTextStyles.getLato(
                                          11, 4.weight, AppColors.hintColor),
                                    ),
                                    5.ph,
                                    Text(
                                      "2",
                                      style: AppTextStyles.getLato(
                                        13,
                                        5.weight,
                                      ),
                                    ),
                                  ],
                                ),
                                4.pw,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Price:",
                                      style: AppTextStyles.getLato(
                                          11, 4.weight, AppColors.hintColor),
                                    ),
                                    5.ph,
                                    Text(
                                      "€1,055.00",
                                      style: AppTextStyles.getLato(
                                        13,
                                        5.weight,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            20.ph,
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        controller
                                            .selectTrackingId(order["id"]);
                                        Get.to(() => TrackOrderScreen(
                                              isActive: isActive,
                                            ));
                                      },
                                      style: ButtonStyle(
                                          shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          )),
                                          side: WidgetStatePropertyAll(
                                              BorderSide(
                                                  color: AppColors.primaryColor,
                                                  width: 0.5))),
                                      child: Center(
                                        child: Text(
                                          "Track Order",
                                          style: AppTextStyles.getLato(16,
                                              6.weight, AppColors.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                10.pw,
                                Expanded(
                                    child: CustomButton(
                                        text: isActive
                                            ? "View Receipt"
                                            : "View Details",
                                        onPressed: () {
                                          if (isActive) {
                                            Get.to(() => ViewReceiptScreen(
                                                order: order));
                                          } else {
                                            Get.to(() => OrderDetailScreen(
                                                  order: order,
                                                  isActive: isActive,
                                                ));
                                          }
                                        }))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
