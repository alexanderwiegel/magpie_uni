class NotificationResponse {
  NotificationResponse({
    required this.status,
    required this.notificationCount,
  });

  String status;
  int notificationCount;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      status: json["status"],
      notificationCount: json["notificationCount"],
    );
  }
}
