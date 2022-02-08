import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:magpie_uni/model/nest.or.nest.item.dart';

class apiEndpoints {
  static String urlPrefix = "http://10.0.2.2:3000/";
  static String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoxLCJpYXQiOjE2NDQwNzA4NzYsImV4cCI6MTY0NDA3NDQ3Nn0.JvlRQCLTH2bUAcx1RJVNW10_KQMccWAnlyNapW-9kfM";

  static Future<bool> addNestOrNestItem(NestOrNestItem nestOrNestItem, bool isNest) async {
    String url = urlPrefix;
    url += isNest ? "nest/addNest" : "nestItem/addNestItem";

    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    headers['Authorization'] = "Bearer " + token;
    var req = http.MultipartRequest('POST', Uri.parse(url));
    headers.forEach((key, value) {
      req.headers[key] = value;
    });
    // TODO: use real instead of dummy values
    // nestOrNestItem.forEach((key, value) {
    //   req.fields[key] = value;
    // });
    req.fields["user_id"] = "1";
    // TODO: ask Huzaifa why it's undefined in the DB no matter if I use "name" or "title"
    req.fields["title"] = "Vinyl";
    req.fields["description"] = "";
    req.files.add(await http.MultipartFile.fromPath('image', nestOrNestItem.photo.path,
        contentType: MediaType('image', 'jpg')
      // contentType: MediaType('application', 'x-tar')
    ));
    print("Send request");
    var response = await req.send();
    print(response);
    return (response.statusCode == 200) ? true : false;
  }
}