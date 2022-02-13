import 'dart:convert';

import 'package:http/http.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/services/api.endpoints.dart';

class HttpService {
  Future<Response> signIn(data) async {
    var response = await post(Uri.parse(ApiEndpoints.urlPrefix + 'user/login'),
        body: data);

    return response;

    //Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    //print(jsonResponse);

    //if (response.statusCode == 200) {
    //  Map<String, dynamic> user = jsonResponse["user"];
    //  UserAPIManager.token = jsonResponse["token"].toString();
    //  UserAPIManager.currentUserId = user["id"];
      //print(user);
      //print(UserAPIManager.token);
      //print(UserAPIManager.currentUserId);
    //}
    //return response.statusCode;
  }

  Future<Response> signUp(data) async {
    var response = await post(
        Uri.parse(ApiEndpoints.urlPrefix + 'user/register'),
        body: data);
    return response;
  }
}
