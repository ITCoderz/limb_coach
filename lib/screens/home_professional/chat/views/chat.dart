import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mylimbcoach/generated/assets.dart';
import 'package:mylimbcoach/models/chat_user.dart';
import 'package:mylimbcoach/screens/home_professional/chat/controllers/inbox_controller.dart';
import 'package:mylimbcoach/screens/home_professional/start_consultation/views/call_screen.dart';
import 'package:mylimbcoach/utils/app_colors.dart';
import 'package:mylimbcoach/utils/app_text_styles.dart';
import 'package:mylimbcoach/utils/gaps.dart';

class ChatScreen extends StatelessWidget {
  final ChatUser user;
  final c = Get.find<InboxController>();
  final msgController = TextEditingController();

  ChatScreen({super.key, required this.user}) {
    c.openChat(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            Assets.pngIconsBackIcon,
          ),
        ),
        title: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              user.image,
              height: 49,
            ),
          ),
          SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(user.name, style: AppTextStyles.getLato(14, 6.weight)),
            4.ph,
            Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                ),
                5.pw,
                Text("Online",
                    style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
          ])
        ]),
        actions: [
          GestureDetector(
              child: Image.asset(
                Assets.pngIconsAudioCall,
                height: 40,
                width: 40,
              ),
              onTap: () =>
                  Get.to(() => CallScreen(name: user.name, image: user.image))),
          10.pw,
          GestureDetector(
              child: Image.asset(
                Assets.pngIconsVideoCall,
                height: 40,
                width: 40,
              ),
              onTap: () =>
                  Get.to(() => CallScreen(name: user.name, image: user.image))),
          20.pw,
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: c.chats.length,
                  itemBuilder: (context, index) {
                    final chat = c.chats[index];
                    return Align(
                      alignment: chat.isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: 15,
                          left: chat.isMe ? 100 : 0,
                          right: chat.isMe ? 0 : 100,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: chat.isMe
                              ? AppColors.primaryColor.withOpacity(0.05)
                              : AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: chat.isMe
                                ? Radius.circular(5)
                                : Radius.circular(0),
                            bottomRight: chat.isMe
                                ? Radius.circular(0)
                                : Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (chat.text.isNotEmpty)
                              Text(
                                chat.text,
                                style: GoogleFonts.lato(
                                  color:
                                      chat.isMe ? Colors.black : Colors.white,
                                ),
                              ),
                            if (chat.imagePath != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(chat.imagePath!),
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            5.ph,
                            Text(chat.time,
                                style: GoogleFonts.lato(
                                    color: chat.isMe
                                        ? AppColors.hintColor
                                        : AppColors.borderColor)),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15, left: 20),
            width: 80,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(5),
              ),
            ),
            child:
                Text("Typing...", style: GoogleFonts.lato(color: Colors.black)),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor, width: 0.5),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: msgController,
              decoration: InputDecoration(
                hintText: "Type your message...",
                border: InputBorder.none,
                filled: false,
              ),
              onChanged: (val) => c.isTyping.value = val.isNotEmpty,
            ),
          ),
          GestureDetector(
            child: Image.asset(
              Assets.pngIconsGetFiles,
              height: 30,
            ),
            onTap: () {
              c.sendImageMessage();
            },
          ),
          5.pw,
          GestureDetector(
            child: Image.asset(
              Assets.pngIconsSendMessage,
              height: 30,
            ),
            onTap: () {
              c.sendMessage(msgController.text);
              msgController.clear();
            },
          )
        ],
      ),
    );
  }
}
