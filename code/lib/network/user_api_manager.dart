import 'package:magpie_uni/model/feedUserProfileModel.dart';

class UserAPIManager {
  static final UserAPIManager _shared = UserAPIManager._internal();

  factory UserAPIManager() {
    return _shared;
  }

  late FeedUserProfileResponse currentUserProfile;

  static int currentUserId = 5;
  static String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjo1LCJpYXQiOjE2NDQ0MTMyOTgsImV4cCI6MTY0NDQxNjg5OH0.jYQ8cRpmCjaKwELaYTne2tFdz2V6d7yYBB2VGN27QIk";

  Map<String, String> getAPIHeader() {
    var header = {"Authorization": "Bearer $token"};
    return header;
  }

  UserAPIManager._internal();

  static const routePrefix = 'user/';
}
