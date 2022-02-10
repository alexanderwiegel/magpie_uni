import 'dart:convert';

ChatSession chatSessionFromJson(String str) =>
    ChatSession.fromJson(json.decode(str));

class ChatSessionResponse {
  ChatSessionResponse({
    required this.status,
    required this.chat,
  });

  String status;
  List<ChatSession> chat;

  factory ChatSessionResponse.fromJson(Map<String, dynamic> json) =>
      ChatSessionResponse(
        status: json["status"],
        chat: List<ChatSession>.from(
            json["chat"].map((x) => ChatSession.fromJson(x))),
      );
}

class ChatSession {
  int id;
  int unreadMessages;
  String? topMessage;
  String? lastMessageTime;
  String opponentUserName;
  int opponentUserId;
  String imageURL =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJGNHFnbUHLoK_9zZ8nM1aI0HLu7P6eyu83eJAs_D9lv9qY_au3YFraMk01LgqOm6ju5I&usqp=CAU";

  ChatSession({
    required this.id,
    required this.opponentUserName,
    required this.topMessage,
    required this.lastMessageTime,
    required this.opponentUserId,
    required this.unreadMessages,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) => ChatSession(
        id: json["id"],
        unreadMessages: json["unreadMessages"],
        topMessage: json["topMessage"],
        lastMessageTime: json["lastMessageTime"],
        opponentUserName: json["opponentUserName"],
        opponentUserId: json["opponentUserId"],
      );
}

class NewChatSessionResponse {
  NewChatSessionResponse({
    required this.status,
    required this.chat,
  });

  String status;
  ChatSession chat;

  factory NewChatSessionResponse.fromJson(Map<String, dynamic> json) =>
      NewChatSessionResponse(
        status: json["status"],
        chat: ChatSession.fromJson(json["chat"]),
      );
}
