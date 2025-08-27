import 'package:get/get.dart';

class ForumController extends GetxController {
  // Search
  RxString searchText = "".obs;

  // Topics Data
  var allTopics = [
    {
      "id": 1,
      "title": "New Amputee Support",
      "tag": "Trending",
      "posts": 2,
      "description": "A space for new amputees to connect and share experiences"
    },
    {
      "id": 2,
      "title": "Device Maintenance & Care",
      "tag": "Recent",
      "posts": 80,
      "description":
          "Tips & tricks for keeping your prosthetic in top condition"
    },
    {
      "id": 3,
      "title": "Living with Limb Loss",
      "tag": "Trending",
      "posts": 210,
      "description": "Discussions on daily life, challenges and triumphs"
    },
    {
      "id": 4,
      "title": "Sports & Fitness",
      "tag": "Recent",
      "posts": 45,
      "description":
          "Share your athletic journey and get advice on active prosthetics"
    }
  ].obs;

  // Selected filters
  var selectedTopics = <String>[].obs;
  var selectedUseCases = <String>[].obs;

  // Toggle Methods
  void toggleTopic(String topic) {
    if (selectedTopics.contains(topic)) {
      selectedTopics.remove(topic);
    } else {
      selectedTopics.add(topic);
    }
  }

  void toggleUseCase(String useCase) {
    if (selectedUseCases.contains(useCase)) {
      selectedUseCases.remove(useCase);
    } else {
      selectedUseCases.add(useCase);
    }
  }

  // Apply filters (just closes the filter screen, since filtering is reactive)
  void applyFilters() {
    Get.back(); // you don’t need to modify list here, it reacts in `filteredTopics`
  }

  // Computed filtered list
  List<Map<String, dynamic>> get filteredTopics {
    var list = allTopics;

    // Search filter
    if (searchText.isNotEmpty) {
      list = list
          .where((t) => t["title"]
              .toString()
              .toLowerCase()
              .contains(searchText.value.toLowerCase()))
          .toList()
          .obs;
    }

    // Topic filter
    if (selectedTopics.isNotEmpty && !selectedTopics.contains("All Topics")) {
      list = list
          .where((t) => selectedTopics.contains(t["title"].toString()))
          .toList()
          .obs;
    }

    // Use-case filter
    if (selectedUseCases.isNotEmpty &&
        !selectedUseCases.contains("All Use Cases")) {
      list = list
          .where((t) => selectedUseCases.contains(t["tag"].toString()))
          .toList()
          .obs;
    }

    return list;
  }
}
