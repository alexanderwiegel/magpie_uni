import 'package:http/http.dart';

class HttpService {
  Future<int> signIn(data) async {
    var response =
        await post(Uri.parse('http://192.168.0.5:3000/user/login'), body: data);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<int> signUp(data) async {
    var response = await post(
        Uri.parse('http://192.168.0.5:3000/user/register'),
        body: data);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
