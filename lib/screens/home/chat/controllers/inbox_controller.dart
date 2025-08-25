import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/models/chat_user.dart';

class InboxController extends GetxController {
  var allMessages = <ChatUser>[].obs; // full data
  var messages = <ChatUser>[].obs; // filtered data
  var selectedUser = Rxn<ChatUser>();
  var chats = <ChatMessage>[].obs;
  var isTyping = false.obs;

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    chats.add(ChatMessage(text, true, "Now"));
    isTyping.value = false;
    _scrollToBottom();
  }

  final scrollController = ScrollController();

  Future<void> sendImageMessage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      chats.add(ChatMessage('', true, "Now", imagePath: pickedFile.path));
    }
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  void loadDummyData() {
    final data = [
      ChatUser("Elon Morgan", "Sounds Good!! I will see you on...", "09:30 AM",
          Assets.pngIconsDp),
      ChatUser("Rameen Zafar", "It feels a bit loose around the sock...",
          "09:30 AM", Assets.pngIconsDp2),
      ChatUser("Juliet Johns", "Hello! I had a question...", "10:11 AM",
          Assets.pngIconsDp),
      ChatUser("Amira Yuasha", "Are you available right now?...", "Yesterday",
          Assets.pngIconsDp2),
      ChatUser("Steve Smith", "Thanks for the Help! 🙌", "Wednesday",
          Assets.pngIconsDp),
      ChatUser("Nelson Nail", "When will you be here? 🤔", "Monday",
          Assets.pngIconsDp2),
      ChatUser("Warner Lems", "Oh My Way... 🚗", "Sunday", Assets.pngIconsDp),
    ];
    allMessages.assignAll(data);
    messages.assignAll(data); // initially show all
    _scrollToBottom();
  }

  void filterMessages(String query) {
    if (query.isEmpty) {
      messages.assignAll(allMessages); // reset when search is cleared
    } else {
      messages.assignAll(
        allMessages.where((msg) =>
            msg.name.toLowerCase().contains(query.toLowerCase()) ||
            msg.lastMessage.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  void openChat(ChatUser user) {
    selectedUser.value = user;
    chats.assignAll([
      ChatMessage(
          "Hi Dr. Professional! I have a question about my new prosthetic leg.",
          true,
          "10:05 AM"),
      ChatMessage(
          "Certainly, please tell me more. You can also send photos if that helps",
          false,
          "10:06 AM"),
      ChatMessage("It feels a bit loose around the socket!", true, "10:11 AM"),
    ]);
    _scrollToBottom();
  }
}
