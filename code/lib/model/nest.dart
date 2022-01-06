import 'package:flutter/material.dart';

import '../sort.mode.dart';
import 'nest.or.nest.item.dart';

class Nest extends NestOrNestItem {
  late SortMode sortMode;
  late bool asc;
  late bool onlyFavored;

  Nest({
    Key? key,
    this.sortMode = SortMode.sortById,
    this.asc = false,
    this.onlyFavored = false,
  }) : super(key: key);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> nest = super.toMap();
    nest.addAll({
      'sortMode': sortMode.toString(),
      'asc': asc ? 1 : 0,
      'onlyFavored': onlyFavored ? 1 : 0});
    return nest;
  }

  Nest.fromMap(dynamic obj, {Key? key}) : super.fromMap(obj, key: key) {
    switch (obj["sortMode"]) {
      case "SortMode.sortByName":
        sortMode = SortMode.sortByName;
        break;
      case "SortMode.sortByWorth":
        sortMode = SortMode.sortByWorth;
        break;
      case "SortMode.sortByFavored":
        sortMode = SortMode.sortByFavored;
        break;
      case "SortMode.sortByDate":
        sortMode = SortMode.sortById;
    }
    asc = obj["asc"] == 0 ? false : true;
    onlyFavored = obj["onlyFavored"] == 0 ? false : true;
  }

  @override
  _NestState createState() => _NestState();
}

class _NestState extends NestOrNestItemState<Nest> {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}