import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/model/nest.item.dart';
import 'package:magpie_uni/model/nest.or.nest.item.dart';
import 'package:magpie_uni/model/feedUserProfileModel.dart' as feedUserProfile;
import 'package:magpie_uni/model/user.dart';
import 'package:magpie_uni/network/user_api_manager.dart';

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
    final profile = feedUserProfile.welcomeFromJson(result!).profile;
    List counts = [profile.nestCount, profile.nestItemCount];
    return counts;
  }

  static Future<User> getHomeScreen() async {
    String url = urlPrefix + "user/getUser?id=$userId";

    final response = await http.get(Uri.parse(url), headers: headers);
    final result = response.statusCode == 200 ? jsonDecode(response.body)["user"] : null;
    print(result);

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
    print("Body: $body");

    final req = http.Request("PUT", Uri.parse(url));

    final customHeader = {
      "Accept": "application/json",
      "Content-type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer $token"
    };
    customHeader.forEach((key, value) => req.headers[key] = value);
    req.bodyFields = body;
    print(req.bodyFields);

    final response = await req.send();
    final result = response.statusCode == 200;
    print(result);
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
    print("Url: $url");

    // TODO: use PATCH here and in the backend instead
    String method = isNew ? "POST" : "PUT";
    var req = http.MultipartRequest(method, Uri.parse(url));

    headers.forEach((key, value) => req.headers[key] = value);

    Map nestOrNestItemAsMap = nestOrNestItem.toMap();

    print("NestOrNestItem: $nestOrNestItemAsMap");

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

    print("Path before sending request" + nestOrNestItem.photo!);
    print("Send request");
    var response = await req.send();
    return (response.statusCode == 200) ? true : false;
  }

  static Future<void> deleteNestOrNestItem(
      bool isNest, int nestOrNestItemId) async {
    String url = urlPrefix + "nest/deleteNest";
    if (!isNest) url += "Item";
    print("Url: $url");
    final reqKey = isNest ? "nest_id" : "nest_item_id";
    final body = {reqKey: nestOrNestItemId.toString()};
    print("Body: $body");

    final req = http.Request("DELETE", Uri.parse(url));

    final customHeader = {
      "Accept": "application/json",
      "Content-type": "application/x-www-form-urlencoded",
      "Authorization": "Bearer $token"
    };
    customHeader.forEach((key, value) => req.headers[key] = value);
    req.bodyFields = body;
    print(req.bodyFields);

    final response = await req.send();
    final result = response.statusCode == 200;
    // TODO: check if it works after Huzaifa finished it
    print(result);
  }
}
