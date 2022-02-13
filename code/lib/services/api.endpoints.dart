import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/model/nest.item.dart';
import 'package:magpie_uni/model/nest.or.nest.item.dart';
import 'package:magpie_uni/model/feed.user.profile.model.dart';
import 'package:magpie_uni/model/notification.model.dart';
import 'package:magpie_uni/model/user.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/model/feeds.model.dart';
import 'package:magpie_uni/model/chat.session.model.dart';
import 'package:magpie_uni/model/chat.message.dart';

import '../constants.dart';
import '../model/feed.user.nestitems.model.dart';

class ApiEndpoints {
  static String urlPrefix = "http://10.0.2.2:3000/";
  static int userId = UserAPIManager.currentUserId;
  static String token = UserAPIManager.token;
  static Map<String, String> headers = {
    "Accept": "application/json",
    "Content-type": "application/json",
    "Authorization": "Bearer $token"
  };

  static Future<dynamic> getUserProfile() async {
    String url = urlPrefix + "user/userProfile?userId=$userId";
    final response = await http.get(Uri.parse(url), headers: headers);
    final result = response.statusCode == 200 ? response.body : null;
    UserAPIManager.currentUserProfile = welcomeFromJson(result!);
    printInfo("Status of getting the current user profile: ${UserAPIManager.currentUserProfile.status}");
    return result;
  }

  static Future<User> getHomeScreen() async {
    String url = urlPrefix + "user/getUser?id=$userId";

    final response = await http.get(Uri.parse(url), headers: headers);
    final result =
        response.statusCode == 200 ? jsonDecode(response.body)["user"] : null;
    //print(result);

    return User.fromMap(result);
  }

  static Future<void> updateHomeScreen(
      String sortMode, bool isAsc, bool onlyFavored) async {
    String url = urlPrefix + "user/editUser";

    final body = {
      "id": userId.toString(),
      "sort_mode": sortMode,
      "is_asc": isAsc ? "1" : "0",
      "only_favored": onlyFavored ? "1" : "0",
    };
    //print("Body: $body");

    final req = http.Request("PUT", Uri.parse(url));

    final customHeader = {
      "Accept": "application/json",
      "Content-type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer $token"
    };
    customHeader.forEach((key, value) => req.headers[key] = value);
    req.bodyFields = body;
    //print(req.bodyFields);

    await req.send();
  }

  static Future<List> getNests() async {
    String url = urlPrefix + "nest/userNests?user_id=$userId";
    final response = await http.get(Uri.parse(url), headers: headers);
    final result = response.statusCode == 200
        ? await json.decode(response.body)["result"]
        : null;
    List list = result.map((item) => Nest.fromMap(item)).toList();
    return list;
  }

  static Future<List> getNestItems(int nestId) async {
    String url = urlPrefix + "nest/nestItems?nest_id=$nestId";
    final response = await http.get(Uri.parse(url), headers: headers);
    final result = response.statusCode == 200
        ? await json.decode(response.body)["result"]
        : null;
    List list = result.map((item) => NestItem.fromMap(item)).toList();
    return list;
  }

  static Future<bool> uploadNestOrNestItem(
      NestOrNestItem nestOrNestItem, bool isNest, bool isNew) async {
    String url = urlPrefix + "nest/";
    url += isNew ? "add" : "edit";
    url += isNest ? "Nest" : "NestItem";
    //print("Url: $url");

    // TODO: use PATCH here and in the backend instead
    String method = isNew ? "POST" : "PUT";
    var req = http.MultipartRequest(method, Uri.parse(url));

    headers.forEach((key, value) => req.headers[key] = value);

    Map nestOrNestItemAsMap = nestOrNestItem.toMap();

    //print("NestOrNestItem: $nestOrNestItemAsMap");

    nestOrNestItemAsMap.forEach((key, value) {
      req.fields[key] = value.toString();
    });
    // var filename = nestOrNestItem.photo.toString().split("/").last;
    // // remove the last single quote
    // filename = filename.substring(0, filename.length-1);
    // print("Filename: $filename");
    if (!nestOrNestItem.photo!.startsWith("http")) {
      req.files.add(await http.MultipartFile.fromPath(
        'image',
        nestOrNestItem.photo!,
        contentType: MediaType('image', 'jpg'),
        // filename: filename
      ));
    }

    //print("Path before sending request" + nestOrNestItem.photo!);
    //print("Send request");
    var response = await req.send();
    return (response.statusCode == 200) ? true : false;
  }

  static Future<void> deleteNestOrNestItem(
      bool isNest, int nestOrNestItemId) async {
    String url = urlPrefix + "nest/deleteNest";
    if (!isNest) url += "Item";
    //print("Url: $url");
    final reqKey = isNest ? "nest_id" : "nest_item_id";
    final body = {reqKey: nestOrNestItemId.toString()};
    //print("Body: $body");

    final req = http.Request("DELETE", Uri.parse(url));

    final customHeader = {
      "Accept": "application/json",
      "Content-type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer $token"
    };
    customHeader.forEach((key, value) => req.headers[key] = value);
    req.bodyFields = body;
    //print(req.bodyFields);

    await req.send();
  }

  // Get Feeds
  static Future<FeedResponse> fetchFeeds(int loggedUserId) async {
    var headers = UserAPIManager().getAPIHeader();
    // print(Uri.parse(urlPrefix + 'feed/getFeeds?userId=$loggedUserId'));
    final response = await http.get(
        Uri.parse(urlPrefix + 'feed/getFeeds?userId=$loggedUserId'),
        headers: headers);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print(response.body);
      return FeedResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Feeds');
    }
  }

  //Get Feed User Profile
  static Future<FeedUserProfileResponse> fetchFeedUserProfile(
      int feedUserId) async {
    var headers = UserAPIManager().getAPIHeader();
    final response = await http.get(
        Uri.parse(urlPrefix + 'feed/userProfile?userId=$feedUserId'),
        headers: headers);
    if (response.statusCode == 200) {
      //print(response.body);
      return FeedUserProfileResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Feeds');
    }
  }

  //Get Feed User Specific Nest Items
  static Future<FeedUserNestItemsResponse> fetchFeedUserNestItems(
      int nestId) async {
    var headers = UserAPIManager().getAPIHeader();
    final response = await http.get(
        Uri.parse(urlPrefix + 'feed/nestItems?nest_id=$nestId'),
        headers: headers);
    if (response.statusCode == 200) {
      //print(response.body);
      return FeedUserNestItemsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Feeds');
    }
  }


  // Get Chat Sessions
  static Future<ChatSessionResponse> fetchChatSessions(int loggedUserId) async {
    var headers = UserAPIManager().getAPIHeader();
    final response = await http.get(
        Uri.parse(urlPrefix + 'chat/getChatList?userId=$loggedUserId'),
        headers: headers);

    if (response.statusCode == 200) {
      //print(response.body);
      return ChatSessionResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load chat');
    }
  }

  // Get Chat Messages
  static Future<ChatMessageResponse> fetchChat(
      int loggedUserId, int sessionId) async {
    var headers = UserAPIManager().getAPIHeader();

    final response = await http.get(
        Uri.parse(urlPrefix +
            'chat/getChatHistoryById?userId=$loggedUserId&chatSessionId=$sessionId'),
        headers: headers);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print(response.body);
      return ChatMessageResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load chat');
    }
  }

  //Get chat session for opponents
  static Future<NewChatSessionResponse> fetchUserChatSession(
      int currentUserId, int opponentId) async {
    var headers = UserAPIManager().getAPIHeader();
    final response = await http.get(
        Uri.parse(urlPrefix +
            'chat/checkAndInsertChatSession?currentUserId=$currentUserId&opponentUserId=$opponentId'),
        headers: headers);
    if (response.statusCode == 200) {
      //print(response.body);
      return NewChatSessionResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Feeds');
    }
  }

  //fetch notifications
  static Future<NotificationResponse> fetchChatNotificationCount(
      int loggedUserId) async {
    var headers = UserAPIManager().getAPIHeader();
    final response = await http.get(
        Uri.parse(urlPrefix + 'chat/getNotification?userId=$loggedUserId'),
        headers: headers);

    if (response.statusCode == 200) {
      //print(response.body);
      return NotificationResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load chat');
    }
  }
}
