class UserAPIManager {
  static final UserAPIManager _shared = UserAPIManager._internal();

  factory UserAPIManager() {
    return _shared;
  }

  static int currentUserId = 2;
  static String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjo1LCJpYXQiOjE2NDQzNDI2MzcsImV4cCI6MTY0NDM0NjIzN30.GV1vrW9eOmUmSaTSiM3nb-lNkPlhll7btDmTw0nXsZw";

  Map<String, String> getAPIHeader() {
    var header = {
      "Authorization":
          "Bearer $token"
    };
    return header;
  }

  UserAPIManager._internal();

  static const routePrefix = 'user/';
}
