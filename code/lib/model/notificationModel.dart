import 'dart:convert';

// NotificationResponse NotificationFromJson(String str) => NotificationResponse.fromJson(json.decode(str));

class NotificationResponse {
  NotificationResponse({
    required this.status,
    required this.notificationCount,
  });

  String status;
  int notificationCount;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        status: json["status"],
        notificationCount: json["notificationCount"],
      );
}
