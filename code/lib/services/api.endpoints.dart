import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

// import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/model/feed.user.nest.items.model.dart';
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
import 'package:magpie_uni/sort.mode.dart';

class ApiEndpoints {
  static String urlPrefix = "http://10.0.2.2:3000/";
  static Map<String, String> headers = {
    "Accept": "application/json",
    "Content-type": "application/json",
    "Authorization": "Bearer ${UserAPIManager.token}"
  };

  static Future<dynamic> getUserProfile() async {
    String url =
        urlPrefix + "user/userProfile?userId=${UserAPIManager.currentUserId}";
    final response = await http.get(Uri.parse(url), headers: headers);
    final result = response.statusCode == 200 ? response.body : null;
    UserAPIManager.currentUserProfile = welcomeFromJson(result!);
    return result;
  }

  static Future<User> getHomeScreen() async {
    String url = urlPrefix + "user/getUser?id=${UserAPIManager.currentUserId}";

    final response = await http.get(Uri.parse(url), headers: headers);
    final result =
        response.statusCode == 200 ? jsonDecode(response.body)["user"] : null;

    return User.fromMap(result);
  }

  static Future<void> updateHomeScreen(
      String sortMode, bool isAsc, bool onlyFavored) async {
    String url = urlPrefix + "user/editUser";

    final body = {
      "id": UserAPIManager.currentUserId.toString(),
      "sort_mode": sortMode,
      "is_asc": isAsc ? "1" : "0",
      "only_favored": onlyFavored ? "1" : "0",
    };

    final req = http.Request("PUT", Uri.parse(url));

    final customHeader = {
      "Accept": "application/json",
      "Content-type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer ${UserAPIManager.token}"
    };
    customHeader.forEach((key, value) => req.headers[key] = value);
    req.bodyFields = body;

    await req.send();
  }

  static Future<List> getNests(
      SortMode sortMode, bool asc, bool onlyFavored) async {
    String url = urlPrefix +
        "nest/userNests?user_id=${UserAPIManager.currentUserId}&sort_mode=$sortMode&is_asc=$asc&only_favored=$onlyFavored";
    final response = await http.get(Uri.parse(url), headers: headers);
    final result = response.statusCode == 200
        ? await json.decode(response.body)["result"]
        : null;
    List list = result.map((item) => Nest.fromMap(item)).toList();
    return list;
  }

  static Future<List> getNestItems(
      int nestId, SortMode sortMode, bool asc, bool onlyFavored) async {
    String url = urlPrefix +
        "nest/nestItems?nest_id=$nestId&sort_mode=$sortMode&is_asc=$asc&only_favored=$onlyFavored";
    final response = await http.get(Uri.parse(url), headers: headers);
    final result = response.statusCode == 200
        ? await json.decode(response.body)["result"]
        : null;
    List list = result.map((item) => NestItem.fromMap(item)).toList();
    return list;
  }

  static Future<Map<String, dynamic>> uploadNestOrNestItem(
      NestOrNestItem nestOrNestItem, bool isNest, bool isNew,
      {bool compare = true}) async {
    String url = urlPrefix + "nest/";
    url += isNew ? "add" : "edit";
    url += isNest ? "Nest" : "NestItem";

    // TODO: use PATCH here and in the backend instead
    String method = isNew ? "POST" : "PUT";
    var req = http.MultipartRequest(method, Uri.parse(url));

    headers.forEach((key, value) => req.headers[key] = value);

    Map nestOrNestItemAsMap = nestOrNestItem.toMap();

    nestOrNestItemAsMap.forEach((key, value) {
      req.fields[key] = value.toString();
    });
    req.fields["compare"] = compare.toString();

    if (!nestOrNestItem.photo!.startsWith("http")) {
      req.files.add(await http.MultipartFile.fromPath(
        'image',
        nestOrNestItem.photo!,
        contentType: MediaType('image', 'jpg'),
      ));
    }

    final streamedResponse = await req.send();
    final response = await http.Response.fromStream(streamedResponse);
    return json.decode(response.body);
  }

  static Future<void> deleteNestOrNestItem(
      bool isNest, int nestOrNestItemId) async {
    String url = urlPrefix + "nest/deleteNest";
    if (!isNest) url += "Item";
    final reqKey = isNest ? "nest_id" : "nest_item_id";
    final body = {reqKey: nestOrNestItemId.toString()};

    final req = http.Request("DELETE", Uri.parse(url));

    final customHeader = {
      "Accept": "application/json",
      "Content-type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer ${UserAPIManager.token}"
    };
    customHeader.forEach((key, value) => req.headers[key] = value);
    req.bodyFields = body;

    await req.send();
  }

  // Get Feeds
  static Future<FeedResponse> fetchFeeds(int loggedUserId) async {
    var headers = UserAPIManager().getAPIHeader();
    final response = await http.get(
        Uri.parse(urlPrefix + 'feed/getFeeds?userId=$loggedUserId'),
        headers: headers);

    if (response.statusCode == 200) {
      // If the server returned a 200 OK response then parse the JSON.
      return FeedResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response throw an exception.
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
      // If the server returned a 200 OK response then parse the JSON.
      return ChatMessageResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response throw an exception.
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
      return NotificationResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load chat');
    }
  }
}
