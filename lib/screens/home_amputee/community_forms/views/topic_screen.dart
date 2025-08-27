import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/topic_controller.dart';
import 'create_post_screen.dart';
import 'post_detail_screen.dart';

class TopicScreen extends StatelessWidget {
  final Map<String, dynamic> topic;
  final TopicController controller = Get.put(TopicController());

  TopicScreen({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(topic["title"])),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search posts...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.posts.length,
                  itemBuilder: (_, i) {
                    final post = controller.posts[i];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(post["title"].toString()),
                        subtitle: Text("${post["author"]} • ${post["date"]}"),
                        onTap: () => Get.to(() => PostDetailScreen(post: post)),
                      ),
                    );
                  },
                )),
          ),
          ElevatedButton(
            onPressed: () => Get.to(() => CreatePostScreen(topic: topic)),
            child: Text("Create New Post"),
          )
        ],
      ),
    );
  }
}
