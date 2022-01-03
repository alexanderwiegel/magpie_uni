import 'dart:io';

import 'package:flutter/material.dart';

import '../sort.mode.dart';

abstract class NestOrNestItem extends StatefulWidget {
  late final int? id;
  late final String? userId;
  late final dynamic photo;
  late final String? name;
  late final String description;
  late final int worth;
  late final bool favored;
  late final DateTime? createdAt;
  late final bool public;
  // TODO: remove every occurrence of sortMode, asc and onlyFavored,
  //  because they only appear in nests
  late final SortMode sortMode;
  late final bool asc;
  late final bool onlyFavored;

  NestOrNestItem({
    Key? key,
    this.id,
    this.userId,
    this.photo,
    this.name,
    this.description = "",
    this.worth = 0,
    this.favored = false,
    this.createdAt,
    this.public = false,
    this.sortMode = SortMode.sortById,
    this.asc = false,
    this.onlyFavored = false,
  }) : super(key: key);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'photo': photo.toString(),
      'name': name,
      'description': description,
      'worth': worth,
      'favored': favored ? -1 : 0,
      'createdAt': createdAt!.toIso8601String().substring(0, 10),
      'public': public ? -1 : 0,
      'sortMode': sortMode.toString(),
      'asc': asc ? 1 : 0,
      'onlyFavored': onlyFavored ? 1 : 0
    };
  }

  NestOrNestItem.fromMap(dynamic obj, {Key? key}) : super(key: key) {
    id = obj["id"];
    userId = obj["userId"];
    String path = obj["photo"].toString();
    if (!path.startsWith("http")) {
      path = path.substring(path.indexOf("/"), path.length - 1);
      photo = File(path);
    } else {
      photo = path;
    }
    name = obj["name"];
    description = obj["description"];
    worth = obj["worth"];
    favored = obj["favored"] == 0 ? false : true;
    createdAt = DateTime.parse(obj["createdAt"]);
    public = obj["public"];
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
  NestOrNestItemState createState() => NestOrNestItemState();
}

class NestOrNestItemState<T extends NestOrNestItem> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}