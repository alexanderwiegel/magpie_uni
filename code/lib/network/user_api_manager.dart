import 'package:magpie_uni/model/feed.user.profile.model.dart';

class UserAPIManager {
  static final UserAPIManager _shared = UserAPIManager._internal();

  factory UserAPIManager() {
    return _shared;
  }

  // TODO: fix error when clicking on statistics: LateInitializationError: Field 'currentUserProfile' has not been initialized.
  static late FeedUserProfileResponse currentUserProfile;

  // TODO: make sure this is set after login
  static late int currentUserId = -1;
  static String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjo1LCJpYXQiOjE2NDQ0MTMyOTgsImV4cCI6MTY0NDQxNjg5OH0.jYQ8cRpmCjaKwELaYTne2tFdz2V6d7yYBB2VGN27QIk";

  Map<String, String> getAPIHeader() => {"Authorization": "Bearer $token"};

  UserAPIManager._internal();

  static const routePrefix = 'user/';
}
