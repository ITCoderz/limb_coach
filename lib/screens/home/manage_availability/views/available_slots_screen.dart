import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home/manage_availability/controllers/manage_availability_controller.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';
import 'package:mylimbcoach/widgets/custom_button.dart';

import '../../../../utils/app_colors.dart';

class AvailableSlotsScreen extends StatelessWidget {
  AvailableSlotsScreen({super.key});
  final AvailabilityController c = Get.find<AvailabilityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Available Slots"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Available Slots:",
                    style: AppTextStyles.getLato(16, FontWeight.w600)),
                const SizedBox(height: 12),

                // ✅ Available slots
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.8,
                  children: c.availableSlots.map((slot) {
                    return GestureDetector(
                      onTap: () => c.removeFromAvailable(slot),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: AppColors.borderColor, width: 0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Text(
                              slot,
                              style: AppTextStyles.getLato(
                                14,
                                FontWeight.w500,
                                Colors.black,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.clear,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),

                20.ph,
                Text("Other Slots:",
                    style: AppTextStyles.getLato(16, FontWeight.w600)),
                const SizedBox(height: 12),

                // ✅ Other slots
                // ✅ Other slots without gaps
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.8,
                  children: c.allSlots
                      .where((slot) =>
                          !c.availableSlots.contains(slot)) // filter first
                      .map((slot) {
                    return GestureDetector(
                      onTap: () => c.addToAvailable(slot),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: AppColors.borderColor, width: 0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          slot,
                          style: AppTextStyles.getLato(
                            14,
                            FontWeight.w500,
                            Colors.grey, // not available
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const Spacer(),
                CustomButton(
                  text: "Save Changes",
                  onPressed: () => c.saveChanges(),
                )
              ],
            )),
      ),
    );
  }
}
