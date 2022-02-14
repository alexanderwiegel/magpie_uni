import 'dart:convert';

import 'package:magpie_uni/services/api.endpoints.dart';

FeedUserProfileResponse welcomeFromJson(String str) =>
    FeedUserProfileResponse.fromJson(json.decode(str));

class FeedUserProfileResponse {
  String status;
  Profile profile;
  List<FeedNest> nests;
  List<FeedNestItem> nestItems;

  FeedUserProfileResponse({
    required this.status,
    required this.profile,
    required this.nests,
    required this.nestItems,
  });

  factory FeedUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      FeedUserProfileResponse(
        status: json["status"],
        profile: Profile.fromJson(json["profile"]),
        nests:
            List<FeedNest>.from(json["nests"].map((x) => FeedNest.fromJson(x))),
        nestItems: List<FeedNestItem>.from(
            json["nestItems"].map((x) => FeedNestItem.fromJson(x))),
      );
}

class FeedNest {
  int id;
  int userId;
  String title;
  String description;
  String photo;

  FeedNest({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.photo,
  });

  factory FeedNest.fromJson(Map<String, dynamic> json) => FeedNest(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        photo: json["photo"] ??
            "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png",
      );

  String getImage() => photo ==
          "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png"
      ? photo
      : ApiEndpoints.urlPrefix + photo;
}

class FeedNestItem {
  int id;
  int nestId;
  int userId;
  String title;
  String description;
  String photo;

  FeedNestItem({
    required this.id,
    required this.nestId,
    required this.title,
    required this.description,
    required this.photo,
    required this.userId,
  });

  factory FeedNestItem.fromJson(Map<String, dynamic> json) => FeedNestItem(
        id: json["id"],
        nestId: json["nest_id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        photo: json["photo"] ??
            "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png",
      );

  String getImage() => photo ==
          "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png"
      ? photo
      : ApiEndpoints.urlPrefix + photo;
}

class Profile {
  String username;
  String? photo;
  String email;
  int nestCount = 0;
  int nestItemCount = 0;
  List<Stats>? stats;

  Profile({
    required this.username,
    required this.photo,
    required this.email,
    required this.nestCount,
    required this.nestItemCount,
    this.stats,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
      username: json["username"],
      photo: json["photo"],
      email: json["email"],
      nestCount: json["nestCount"],
      nestItemCount: json["nestItemCount"],
      stats: json["stats"] != null
          ? List<Stats>.from(json["stats"].map((stat) => Stats.fromJson(stat)))
          : null);
}

class Stats {
  int count;
  DateTime date;

  Stats({required this.count, required this.date});

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        count: json["count"],
        date: DateTime.parse(json["date"]),
      );
}
