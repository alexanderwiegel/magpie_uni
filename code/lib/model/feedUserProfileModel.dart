import 'dart:convert';

FeedUserProfileResponse welcomeFromJson(String str) =>
    FeedUserProfileResponse.fromJson(json.decode(str));

class FeedUserProfileResponse {
  FeedUserProfileResponse({
    required this.status,
    required this.profile,
    required this.nests,
    required this.nestItems,
  });

  String status;
  Profile profile;
  List<FeedNest>? nests;
  List<NestItem>? nestItems;

  factory FeedUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      FeedUserProfileResponse(
        status: json["status"],
        profile: Profile.fromJson(json["profile"]),
        nests: List<FeedNest>.from(json["nests"].map((x) => FeedNest.fromJson(x))),
        nestItems: List<NestItem>.from(
            json["nestItems"].map((x) => NestItem.fromJson(x))),
      );
}

class FeedNest {
  FeedNest({
    required this.id,
    required this.title,
    required this.description,
    required this.photo,
  });

  int id;
  String title;
  String description;
  String photo;

  factory FeedNest.fromJson(Map<String, dynamic> json) => FeedNest(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        photo: json["photo"] == null
            ? "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png"
            : json["photo"],
      );

  String getImage() {
    if (this.photo ==
        "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png") {
      return "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png";
    } else {
      return "http://localhost:3000/" + this.photo;
    }
  }
}

class NestItem {
  NestItem({
    required this.id,
    required this.nestId,
    required this.title,
    required this.description,
    required this.photo,
    required this.userId,
  });

  int id;
  int nestId;
  int userId;
  String title;
  String description;
  String photo;

  factory NestItem.fromJson(Map<String, dynamic> json) => NestItem(
        id: json["id"],
        nestId: json["nest_id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        photo: json["photo"] == null
            ? "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png"
            : json["photo"],
      );

  String getImage() {
    if (this.photo ==
        "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png") {
      return "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png";
    } else {
      return "http://localhost:3000/" + this.photo;
    }
  }
}

class Profile {
  Profile({
    required this.username,
    required this.photo,
    required this.email,
    required this.nestCount,
    required this.nestItemCount,
  });

  String username;
  String? photo;
  String email;
  int nestCount;
  int nestItemCount;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        username: json["username"],
        photo: json["photo"],
        email: json["email"],
        nestCount: json["nestCount"],
        nestItemCount: json["nestItemCount"],
      );
}
