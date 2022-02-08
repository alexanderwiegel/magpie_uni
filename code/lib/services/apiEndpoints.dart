import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:magpie_uni/model/nest.or.nest.item.dart';
import 'package:magpie_uni/network/user_api_manager.dart';

class apiEndpoints {
  static String urlPrefix = "http://10.0.2.2:3000/";
  static String token = UserAPIManager.token;
  static Map<String, String> headers = {
    "Accept": "application/json",
    "Content-type": "application/json",
    "Authorization": "Bearer $token"
  };

  static Future<void> getNests() async {

  }

  static Future<bool> uploadNestOrNestItem(
      NestOrNestItem nestOrNestItem, bool isNest, bool isNew) async {
    String url = urlPrefix;
    url += isNest ? "nest/" : "nestItem/";
    url += isNew ? "add" : "edit";
    url += isNest ? "Nest" : "NestItem";

    // TODO: ask Huzaifa why he didn't use PATCH
    String method = isNew ? "POST" : "PUT";
    var req = http.MultipartRequest(method, Uri.parse(url));

    headers.forEach((key, value) {
      req.headers[key] = value;
    });

    // TODO: fix this
    Map nestOrNestItemAsMap = nestOrNestItem.toMap();
    print(nestOrNestItemAsMap);
    nestOrNestItemAsMap.forEach((key, value) {
      req.fields[key] = value;
    });
    req.files.add(await http.MultipartFile.fromPath(
        'image', nestOrNestItem.photo.path,
        contentType: MediaType('image', 'jpg')
        // contentType: MediaType('application', 'x-tar')
        ));

    print("Send request");
    var response = await req.send();
    print(response);
    return (response.statusCode == 200) ? true : false;
  }
}
