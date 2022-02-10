import 'package:magpie_uni/services/api.endpoints.dart';

class FeedResponse {
  String status;
  List<Feed> feeds;

  FeedResponse({
    required this.status,
    required this.feeds,
  });

  factory FeedResponse.fromJson(Map<String, dynamic> json) => FeedResponse(
        status: json["status"],
        feeds: List<Feed>.from(json["result"].map((x) => Feed.fromJson(x))),
      );
}

class Feed {
  int id;
  String title;
  String description;
  int userId;
  String photo;
  String createdAt;
  String username;
  String email;

  Feed({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.photo,
    required this.createdAt,
    required this.username,
    required this.email,
  });

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        userId: json["user_id"],
        photo: json["photo"],
        createdAt: json["created_at"],
        username: json["username"],
        email: json["email"],
      );

  String getImage() => photo ==
          "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png"
      ? photo
      : ApiEndpoints.urlPrefix + photo;
}
