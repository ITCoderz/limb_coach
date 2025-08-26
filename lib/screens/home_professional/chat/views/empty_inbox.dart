import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylimbcoach/screens/home_professional/chat/controllers/inbox_controller.dart';

class InboxEmptyScreen extends StatelessWidget {
  final c = Get.put(InboxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inbox Messages")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mail_outline, size: 80, color: Colors.grey),
            SizedBox(height: 10),
            Text("No Messages!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(
                "Your chat/messages from patients will appear here.\nRight now, there’s no chat.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
