import 'package:get/get.dart';

class TrackOrderController extends GetxController {
  final allTrackingIds = [
    "TRK123456",
    "TRK987654",
    "TRK456789",
    "TRK654321",
  ];

  RxString searchText = "".obs;
  RxList<String> filteredTrackingIds = <String>[].obs;
  RxString selectedTrackingId = "".obs;

  @override
  void onInit() {
    super.onInit();
    // filteredTrackingIds.assignAll(allTrackingIds);

    // React to search text changes
    ever(searchText, (String query) {
      if (query.isEmpty) {
        // filteredTrackingIds.assignAll(allTrackingIds);
      } else {
        filteredTrackingIds.assignAll(
          allTrackingIds
              .where((id) => id.toLowerCase().contains(query.toLowerCase()))
              .toList(),
        );
      }
    });
  }

  void selectTrackingId(String id) {
    selectedTrackingId.value = id;
  }
}
