import 'dart:convert';

import 'package:http/http.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';

class HttpService {
  Future<int> signIn(data) async {
    var response = await post(Uri.parse(ApiEndpoints.urlPrefix + 'user/login'),
        body: data);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonResponse["user"];
      UserAPIManager.token = jsonResponse["token"].toString();
      UserAPIManager.currentUserId = user["id"];
      print(user);
      print(UserAPIManager.token);
      print(UserAPIManager.currentUserId);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int> signUp(data) async {
    var response = await post(
        Uri.parse(ApiEndpoints.urlPrefix + 'user/register'),
        body: data);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
