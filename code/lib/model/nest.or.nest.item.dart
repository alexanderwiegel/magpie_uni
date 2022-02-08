import 'dart:io';

import 'package:flutter/material.dart';

import 'package:magpie_uni/Constants.dart' as Constants;

abstract class NestOrNestItem extends StatefulWidget {
  late final int? id;
  late final int? userId;
  late dynamic photo;
  late String? name;
  late String description;
  late int worth;
  late bool favored;
  late DateTime? createdAt;
  late bool public;

  NestOrNestItem({
    Key? key,
    this.id = 1,
    this.userId = 1,
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
      'user_id': userId,
      'photo': photo.path,
      'title': name,
      'description': description,
      'worth': worth,
      'favored': favored,
      'is_public': public,
    };
  }

  NestOrNestItem.fromMap(dynamic obj, {Key? key}) : super(key: key) {
    id = obj["id"];
    userId = obj["user_id"];
    String path = obj["photo"].toString();
    // TODO: change according to the way photos are saved
    if (!path.startsWith("http")) {
      path = path.substring(path.indexOf("/"), path.length - 1);
      photo = File(path);
    } else {
      photo = path;
    }
    name = obj["title"];
    description = obj["description"];
    worth = obj["worth"];
    favored = obj["favored"] == 0 ? false : true;
    createdAt = DateTime.parse(obj["created_at"]);
    public = obj["is_public"];
  }

  @override
  NestOrNestItemState createState() => NestOrNestItemState();
}

class NestOrNestItemState<T extends NestOrNestItem> extends State<T> {
  MaterialColor accentColor = Constants.accentColor;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset("pics/placeholder.jpg", fit: BoxFit.cover),
    );

    return GestureDetector(
      onTap: () => openNextScreen(context),
      child: GridTile(
        footer: Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(4),
            ),
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
            tooltip: widget.favored ? "Remove as favorite" : "Mark as favorite",
            alignment: AlignmentDirectional.centerStart,
            icon: Icon(widget.favored ? Icons.favorite : Icons.favorite_border,
                color: accentColor),
            onPressed: toggleFavored,
          ),
        ),
      ),
    );
  }

  void openNextScreen(BuildContext context) async {}

  void toggleFavored() async {
    setState(() {
      widget.favored ^= true;
    });
  }
}
