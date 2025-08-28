import 'package:get/get.dart';

class OrdersController extends GetxController {
  var orders = <Map<String, dynamic>>[
    {
      "id": "MLC-123456789",
      "status": "Processing", // Processing / Delivered
      "estimatedDelivery": "July 25 - July 28, 2025",
      "items": [
        {"name": "Lightweight Running Leg", "qty": 1, "price": 520.0},
        {"name": "Gel Comfort Liner", "qty": 1, "price": 520.0},
      ],
      "shipping": {
        "address": "Max Mustermann, Musterstraße 123, 10115 Berlin, Germany",
        "method": "Standard Shipping",
        "tracking": "ABC12345XYZ"
      },
      "payment": {"method": "Credit Card ending in ****1234", "total": 1055.00},
    },
    {
      "id": "MLC-987654321",
      "status": "Delivered",
      "estimatedDelivery": "July 15 - July 20, 2025",
      "items": [
        {"name": "Lightweight Running Leg", "qty": 1, "price": 520.0},
        {"name": "Gel Comfort Liner", "qty": 1, "price": 520.0},
      ],
      "shipping": {
        "address": "Max Mustermann, Musterstraße 123, 10115 Berlin, Germany",
        "method": "Standard Shipping",
        "tracking": "XYZ987654321"
      },
      "payment": {"method": "Credit Card ending in ****5678", "total": 1055.00},
    }
  ].obs;

  var searchText = "".obs;

  List<Map<String, dynamic>> get activeOrders =>
      orders.where((o) => o["status"] != "Delivered").toList();

  List<Map<String, dynamic>> get pastOrders =>
      orders.where((o) => o["status"] == "Delivered").toList();

  List<Map<String, dynamic>> searchOrders(String query) {
    if (query.isEmpty) return orders;
    return orders
        .where((o) =>
            o["id"].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  final allTrackingIds = [
    "TRK123456",
    "TRK987654",
    "TRK456789",
    "TRK654321",
  ];

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
