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
    nest.addAll({
      'sort_mode': sortMode.toString(),
      'is_asc': asc ? 1 : 0,
      'only_favored': onlyFavored ? 1 : 0
    });
    return nest;
  }

  Nest.fromMap(dynamic obj, {Key? key}) : super.fromMap(obj, key: key) {
    switch (obj["sort_mode"]) {
      case "SortMode.sortByName":
        sortMode = SortMode.SortByName;
        break;
      case "SortMode.sortByWorth":
        sortMode = SortMode.SortByWorth;
        break;
      case "SortMode.sortByFavored":
        sortMode = SortMode.SortByFavored;
        break;
      case "SortMode.sortByDate":
        sortMode = SortMode.SortById;
    }
    asc = obj["is_asc"] == 0 ? false : true;
    onlyFavored = obj["only_favored"] == 0 ? false : true;
  }

  @override
  _NestState createState() => _NestState();
}

class _NestState extends NestOrNestItemState<Nest> {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  void openNextScreen(BuildContext context) async {
    Nest oldNest = Nest(
      key: widget.key,
      asc: widget.asc,
      onlyFavored: widget.onlyFavored,
      sortMode: widget.sortMode,
    );
    oldNest.id = super.widget.id;
    oldNest.userId = super.widget.userId;
    oldNest.name = super.widget.name;
    oldNest.photo = super.widget.photo;
    oldNest.description = super.widget.description;
    oldNest.worth = super.widget.worth;
    oldNest.favored = super.widget.favored;
    oldNest.public = super.widget.public;
    oldNest.createdAt = super.widget.createdAt;

    Nest newNest = await Navigator.push(
      context,
      // TODO: see if it is somehow possible to pass "widget.this"
      MaterialPageRoute(builder: (context) => NestItemsScreen(nest: oldNest)),
    );
  }
}
