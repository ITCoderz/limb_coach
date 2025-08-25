class ChatUser {
  final String name;
  final String image;
  final String lastMessage;
  final String time;
  ChatUser(this.name, this.lastMessage, this.time, this.image);
}

class ChatMessage {
  final String text;
  final String? imagePath;
  final bool isMe;
  final String time;

  ChatMessage(this.text, this.isMe, this.time, {this.imagePath});
}
