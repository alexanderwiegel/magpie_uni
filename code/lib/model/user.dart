import 'package:magpie_uni/sort.mode.dart';

class User {
  SortMode sortMode = SortMode.sortById;
  bool asc = true;
  bool onlyFavored = false;

  User({required this.sortMode, required this.asc, required this.onlyFavored});

  User.fromMap(dynamic obj) {
    switch (obj["sort_mode"]) {
      case "sortByName":
        sortMode = SortMode.sortByName;
        break;
      case "sortByWorth":
        sortMode = SortMode.sortByWorth;
        break;
      case "sortByFavored":
        sortMode = SortMode.sortByFavored;
        break;
      case "sortById":
        sortMode = SortMode.sortById;
    }
    asc = obj["is_asc"] == 1;
    onlyFavored = obj["only_favored"] == 1;
  }
}
