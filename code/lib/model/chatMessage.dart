import 'dart:convert';

ChatMessage chatMessageFromJson(String str) =>
    ChatMessage.fromJson(json.decode(str));

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessageResponse {
  String status;
  List<ChatMessage> chat;

  ChatMessageResponse({
    required this.status,
    required this.chat,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) =>
      ChatMessageResponse(
        status: json["status"],
        chat: List<ChatMessage>.from(
            json["chat"].map((x) => ChatMessage.fromJson(x))),
      );
}

class ChatMessage {
  String message;
  int senderId;
  int receiverId;
  int chatSessionId;

  ChatMessage(
      {required this.message,
      required this.senderId,
      required this.receiverId,
      required this.chatSessionId});

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        message: json["message"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        chatSessionId: json["chat_session_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "chat_session_id": chatSessionId,
      };
}
