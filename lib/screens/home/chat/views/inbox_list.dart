import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/screens/home/chat/views/chat.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

import '../controllers/inbox_controller.dart';

class InboxListScreen extends StatelessWidget {
  final c = Get.put(InboxController());

  InboxListScreen({super.key}) {
    c.loadDummyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Inbox Messages"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Search
            _buildSearchBar(),
            20.ph,

            Row(
              children: [
                Text("All Messages",
                    style: AppTextStyles.getLato(18, 6.weight)),
                Obx(() => Text(" (${c.messages.length})",
                    style: AppTextStyles.getLato(
                        16, 4.weight, AppColors.hintColor))),
              ],
            ),
            20.ph,
            c.messages.isEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          15.ph,
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    AppColors.primaryColor.withOpacity(0.05)),
                            child: Image.asset(
                              Assets.pngIconsMessages,
                              height: 69,
                            ),
                          ),
                          15.ph,
                          Text(
                            "No Messages!",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.getLato(18, 6.weight),
                          ),
                          10.ph,
                          Text(
                            "Your Chat/Messages from patients will appear here.\nRight Now, there’s no chat",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.getLato(
                                12, 5.weight, AppColors.hintColor),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: Obx(() => ListView.builder(
                          itemCount: c.messages.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final user = c.messages[index];
                            return Container(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.borderColor,
                                      width: 0.5)),
                              child: ListTile(
                                leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(user.image)),
                                title: Text(user.name,
                                    style: AppTextStyles.getLato(15, 5.weight)),
                                subtitle: Text(user.lastMessage,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.getLato(
                                        13, 4.weight, AppColors.hintColor)),
                                trailing: Column(
                                  children: [
                                    Text(user.time,
                                        style: AppTextStyles.getLato(11,
                                            4.weight, AppColors.primaryColor)),
                                    10.ph,
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryColor),
                                      child: Center(
                                        child: Text(
                                          "2",
                                          style: AppTextStyles.getLato(8,
                                              5.weight, AppColors.whiteColor),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () =>
                                    Get.to(() => ChatScreen(user: user)),
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

  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        onChanged: (val) => c.filterMessages(val), // 👈 connect to filter

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
