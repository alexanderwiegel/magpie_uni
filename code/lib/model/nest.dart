import 'package:flutter/material.dart';

import 'package:magpie_uni/sort.mode.dart';
import 'package:magpie_uni/model/nest.or.nest.item.dart';

//ignore: must_be_immutable
class Nest extends NestOrNestItem {
  // late final SortMode sortMode;
  // late final bool asc;
  // late final bool onlyFavored;
  late final int itemCount;

  Nest({
    Key? key,
    // this.sortMode = SortMode.sortById,
    // this.asc = true,
    // this.onlyFavored = false,
  }) : super(key: key);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> nest = super.toMap();
    // nest.addAll(
    //   {'sort_mode': sortMode, 'is_asc': asc, 'only_favored': onlyFavored},
    // );
    return nest;
  }

  Nest.fromMap(dynamic obj, {Key? key}) : super.fromMap(obj, key: key) {
    super.worth =
        obj["total_worth"].runtimeType == Null ? 0 : obj["total_worth"];
    itemCount = obj["nestItemCount"];
    // switch (obj["sort_mode"]) {
    //   case "sortByName":
    //     sortMode = SortMode.sortByName;
    //     break;
    //   case "sortByWorth":
    //     sortMode = SortMode.sortByWorth;
    //     break;
    //   case "sortByFavored":
    //     sortMode = SortMode.sortByFavored;
    //     break;
    //   case "sortById":
    //     sortMode = SortMode.sortById;
    // }
    // asc = obj["is_asc"] == 1 ? true : false;
    // onlyFavored = obj["only_favored"] == 1 ? true : false;
  }

  @override
  _NestState createState() => _NestState();
}

class _NestState extends NestOrNestItemState<Nest> {
  late Nest currentNest;

  @override
  void initState() {
    currentNest = Nest(
      key: widget.key,
      // asc: widget.asc,
      // onlyFavored: widget.onlyFavored,
      // sortMode: widget.sortMode,
    );
    currentNest.id = super.widget.id;
    currentNest.userId = super.widget.userId;
    currentNest.name = super.widget.name;
    currentNest.photo = super.widget.photo;
    currentNest.description = super.widget.description;
    currentNest.worth = super.widget.worth;
    // currentNest.favored = super.widget.favored;
    currentNest.public = super.widget.public;
    currentNest.createdAt = super.widget.createdAt;
    super.initState();
  }

  @override
  String getItemCount() => widget.itemCount.toString();

  @override
  void openNextScreen(BuildContext context) async {
    // print("Old nest: " + currentNest.toMap().toString());
    // print("Created at: " + currentNest.createdAt.toString());

    //print("Context: " + context.toString());

    await Navigator.pushNamed(
      context,
      "/nestItems",
      arguments: currentNest,
    ).then(onChange);
  }

// @override
// void toggleFavored(BuildContext context) async {
//   super.toggleFavored(context);
//   await ApiEndpoints.uploadNestOrNestItem(
//       currentNest, true, currentNest.id == null);
// }
}
