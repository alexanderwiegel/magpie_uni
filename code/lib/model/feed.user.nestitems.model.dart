import 'dart:convert';
import 'feed.user.profile.model.dart';

FeedUserNestItemsResponse FeedUserNestItemFromJson(String str) =>
    FeedUserNestItemsResponse.fromJson(json.decode(str));

class FeedUserNestItemsResponse {
  FeedUserNestItemsResponse({
    required this.status,
    required this.nestItems,
  });

  String status;
  List<FeedNestItem>? nestItems;

  factory FeedUserNestItemsResponse.fromJson(Map<String, dynamic> json) =>
      FeedUserNestItemsResponse(
        status: json["status"],
        nestItems: List<FeedNestItem>.from(
            json["result"].map((x) => FeedNestItem.fromJson(x))),
      );
}
