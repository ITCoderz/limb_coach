import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home/homepage/components/custom_app_bar.dart';
import 'package:mylimbcoach/screens/home/manage_availability/controllers/manage_availability_controller.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/widgets/custom_textfield.dart';

class ConsultationPricingScreen extends StatelessWidget {
  final AvailabilityController c = Get.find<AvailabilityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Consultation Type & Pricing"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => ListView(
              children: c.consultationPrices.keys.map((type) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CustomTextField(
                    controller: c.priceControllers[type]!,
                    label: type,
                    hintText: "€20.00",
                    type: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (val) => c.updatePrice(type, val),
                  ),
                );
              }).toList(),
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () => c.saveChanges(),
          child: Text(
            "Save Changes",
            style: AppTextStyles.getLato(16, FontWeight.w600, Colors.white),
          ),
        ),
      ),
    );
  }
}
