import 'dart:io';

import 'package:flutter/material.dart';

import '../constants.dart' as constants;

class NestOrNestItem extends StatefulWidget {
  late final int? id;
  late final String? userId;
  late dynamic photo;
  late String? name;
  late String description;
  late int worth;
  late bool favored;
  late DateTime? createdAt;
  late bool public;

  NestOrNestItem({
    Key? key,
    this.id = -1,
    this.userId = "-1",
    this.photo = "pics/placeholder.jpg",
    this.name = "",
    this.description = "",
    this.worth = 0,
    this.favored = false,
    this.createdAt,
    this.public = false,
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
    };
  }

  NestOrNestItem.fromMap(dynamic obj, {Key? key}) : super(key: key) {
    id = obj["id"];
    userId = obj["userId"];
    String path = obj["photo"].toString();
    // TODO: change according to the way photos are saved
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
  }

  @override
  NestOrNestItemState createState() => NestOrNestItemState();
}

class NestOrNestItemState<T extends NestOrNestItem> extends State<T> {
  MaterialColor accentColor = constants.accentColor;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.antiAlias,
        child: Image.asset("pics/placeholder.jpg", fit: BoxFit.cover)
    );

    return GestureDetector(
      onTap: () => {},
      child: GridTile(
        footer: Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridTileBar(
            backgroundColor: Colors.black45,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                widget.name!,
                style: TextStyle(color: accentColor),
              ),
            ),
            subtitle: const FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text("0 nest items"),
            ),
            trailing: FittedBox(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "${widget.worth}€",
                style: TextStyle(
                  color: accentColor,
                ),
              ),
            ),
          ),
        ),
        child: image,
        header: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.topStart,
          child: IconButton(
            tooltip: widget.favored
                ? "Remove as favorite"
                : "Mark as favorite",
            alignment: AlignmentDirectional.centerStart,
            icon: Icon(
              widget.favored ? Icons.favorite : Icons.favorite_border,
              color: accentColor
            ),
            onPressed: toggleFavored,
          ),
        ),
      ),
    );
  }

  void toggleFavored() async {
    setState(() {
      widget.favored ^= true;
    });
  }
}