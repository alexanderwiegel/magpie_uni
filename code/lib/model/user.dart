import 'package:magpie_uni/sort.mode.dart';

class User {
  late SortMode sortMode;
  late bool asc;
  late bool onlyFavored;

  User({required this.sortMode, required this.asc, required this.onlyFavored});

  User.fromMap(dynamic obj) {
    switch (obj["sort_mode"]) {
      case "SortByName":
        sortMode = SortMode.SortByName;
        break;
      case "SortByWorth":
        sortMode = SortMode.SortByWorth;
        break;
      case "SortByFavored":
        sortMode = SortMode.SortByFavored;
        break;
      case "SortById":
        sortMode = SortMode.SortById;
    }
    asc = obj["is_asc"] == 1;
    onlyFavored = obj["only_favored"] == 1;
  }
}