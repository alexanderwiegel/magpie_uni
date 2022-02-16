import 'package:http/http.dart';
import 'package:magpie_uni/services/api.endpoints.dart';

class HttpService {
  Future<Response> signIn(data) async {
    return await post(
      Uri.parse(ApiEndpoints.urlPrefix + 'user/login'),
      body: data,
    );
  }

  Future<Response> signUp(data) async {
    var response = await post(
        Uri.parse(ApiEndpoints.urlPrefix + 'user/register'),
        body: data);
    return response;
  }
}
