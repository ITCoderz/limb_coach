import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';

class PostDetailScreen extends StatelessWidget {
  final Map<String, dynamic> post;
  final PostController controller = Get.put(PostController());

  final TextEditingController commentCtrl = TextEditingController();

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post["title"])),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                Text(post["title"],
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("By ${post["author"]} • ${post["date"]}"),
                SizedBox(height: 12),
                Text(post["content"]),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text("${post["views"]} Views"),
                    SizedBox(width: 12),
                    Text("${post["likes"]} Likes"),
                    SizedBox(width: 12),
                    Text("${post["comments"]} Comments"),
                  ],
                ),
                Divider(),
                Text("All Comments",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Obx(() => Column(
                      children: controller.comments
                          .map((c) => ListTile(
                                title: Text(c["user"]!),
                                subtitle: Text(c["text"]!),
                                trailing: Text(c["date"]!),
                              ))
                          .toList(),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentCtrl,
                    decoration: InputDecoration(
                      hintText: "Type message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (commentCtrl.text.isNotEmpty) {
                      controller.comments.add({
                        "user": "You",
                        "date": "July 20, 2025",
                        "text": commentCtrl.text
                      });
                      commentCtrl.clear();
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
