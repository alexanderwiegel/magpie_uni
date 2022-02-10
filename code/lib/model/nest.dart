import 'package:flutter/material.dart';

import 'package:magpie_uni/sort.mode.dart';
import 'package:magpie_uni/model/nest.or.nest.item.dart';
import 'package:magpie_uni/view/nest.items.screen.dart';

class Nest extends NestOrNestItem {
  late SortMode sortMode;
  late bool asc;
  late bool onlyFavored;

  Nest({
    Key? key,
    this.sortMode = SortMode.SortById,
    this.asc = false,
    this.onlyFavored = false,
  }) : super(key: key);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> nest = super.toMap();
    nest.addAll(
        // TODO: check if total_worth needs to be set to worth as well
        {
          'sort_mode': sortMode.name,
          'is_asc': asc,
          'only_favored': onlyFavored
        });
    return nest;
  }

  Nest.fromMap(dynamic obj, {Key? key}) : super.fromMap(obj, key: key) {
    super.worth = obj["total_worth"].runtimeType == Null ? 0 : obj["total_worth"];
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
    asc = obj["is_asc"] == 1 ? true : false;
    onlyFavored = obj["only_favored"] == 1 ? true : false;
  }

  @override
  _NestState createState() => _NestState();
}

class _NestState extends NestOrNestItemState<Nest> {
  @override
  void openNextScreen(BuildContext context) async {
    Nest currentNest = Nest(
      key: widget.key,
      asc: widget.asc,
      onlyFavored: widget.onlyFavored,
      sortMode: widget.sortMode,
    );
    currentNest.id = super.widget.id;
    currentNest.userId = super.widget.userId;
    currentNest.name = super.widget.name;
    currentNest.photo = super.widget.photo;
    currentNest.description = super.widget.description;
    currentNest.worth = super.widget.worth;
    currentNest.favored = super.widget.favored;
    currentNest.public = super.widget.public;
    currentNest.createdAt = super.widget.createdAt;
    // print("Old nest: " + currentNest.toMap().toString());
    // print("Created at: " + currentNest.createdAt.toString());

    print("Context: " + context.toString());

    await Navigator.push(
      context,
      // TODO: see if it is somehow possible to pass "widget.this"
      MaterialPageRoute(
          builder: (context) => NestItemsScreen(nest: currentNest)),
    ).then(onChange);
  }
}
