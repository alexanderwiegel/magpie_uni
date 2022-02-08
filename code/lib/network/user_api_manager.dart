class UserAPIManager {
  static final UserAPIManager _shared = UserAPIManager._internal();

  factory UserAPIManager() {
    return _shared;
  }

  static int currentUserId = 2;

  Map<String, String> getAPIHeader() {
    var header = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoxLCJpYXQiOjE2NDQzMzkwMjMsImV4cCI6MTY0NDM0MjYyM30.LcyJlq2gtmX6zQcCIuDWerz5C6yAxzn-nQtaWTd8NFI"
    };
    return header;
  }

  UserAPIManager._internal();

  static const routePrefix = 'user/';
}
