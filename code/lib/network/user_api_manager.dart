class UserAPIManager {
  static final UserAPIManager _shared = UserAPIManager._internal();

  factory UserAPIManager() {
    return _shared;
  }

  static int currentUserId = 2;

  Map<String, String> getAPIHeader() {
    var header = {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoxLCJpYXQiOjE2NDQyNzY4ODMsImV4cCI6MTY0NDI4MDQ4M30.scAAgewA8E7SdG9TxFknTy1jI4Jskl1G-yR_9m_Pugw"
    };
    return header;
  }

  UserAPIManager._internal();

  static const routePrefix = 'user/';
}
