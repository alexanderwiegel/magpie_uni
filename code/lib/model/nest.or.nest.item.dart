import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/services/api.endpoints.dart';

//ignore: must_be_immutable
abstract class NestOrNestItem extends StatefulWidget {
  late int? id;
  late int? userId;
  late String? photo;
  late String name;
  late String description;
  late int worth;

  // late bool? favored;
  late DateTime? createdAt;
  late bool? public;

  NestOrNestItem({
    Key? key,
    this.id,
    this.userId,
    this.photo,
    this.name = "",
    this.description = "",
    this.worth = 0,
    // this.favored,
    this.createdAt,
    this.public,
  }) : super(key: key);

  NestOrNestItem.fromMap(dynamic obj, {Key? key}) : super(key: key) {
    id = obj["id"];
    userId = obj["user_id"];
    photo = getPhotoPath(obj["photo"]);
    name = obj["title"];
    description = obj["description"];
    // favored = obj["favored"] == 1 ? true : false;
    createdAt = DateTime.parse(obj["created_at"]);
    public = obj["is_public"] == 1 ? true : false;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> nestOrNestItem = {
      'id': id,
      'user_id': userId,
      'title': name,
      'description': description,
      'worth': worth,
      // 'favored': favored,
      'is_public': public,
    };
    if (!photo!.startsWith("http")) nestOrNestItem.addAll({'photo': photo});
    return nestOrNestItem;
  }

  String getPhotoPath(String path) {
    return ApiEndpoints.urlPrefix + path;
  }

  @override
  NestOrNestItemState createState() => NestOrNestItemState();
}

class NestOrNestItemState<T extends NestOrNestItem> extends State<T> {
  @override
  Widget build(BuildContext context) {
    final bool isNest = !context.toString().contains("NestItem");

    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(widget.photo!, fit: BoxFit.cover),
    );

    return GestureDetector(
      onTap: () => openNextScreen(context),
      child: GridTile(
        footer: Material(
          color: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridTileBar(
            backgroundColor: Colors.black.withOpacity(0.65),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                widget.name,
                style: const TextStyle(color: accentColor),
              ),
            ),
            subtitle: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                isNest
                    ? getItemCount() + " nest items"
                    : widget.description.isEmpty || widget.description.length > 20
                        ? widget.createdAt.toString().substring(0, 10)
                        : widget.description,
                // : widget.createdAt.toString().substring(0, 10),
              ),
            ),
            trailing: FittedBox(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "${widget.worth}€",
                style: const TextStyle(color: accentColor),
              ),
            ),
          ),
        ),
        child: image,
        header: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.topStart,
          child: IconButton(
            //   tooltip: widget.favored! ? "Remove as favorite" : "Mark as favorite",
            //   alignment: AlignmentDirectional.centerStart,
            icon: const Icon(Icons.favorite, color: Colors.transparent),
            //   icon: Icon(widget.favored! ? Icons.favorite : Icons.favorite_border,
            //       color: accentColor),
            onPressed: () => {},
          ),
        ),
      ),
    );
  }

  String getItemCount() => "";

  onChange(dynamic value) => setState(() {});

  void openNextScreen(BuildContext context) async => throw UnimplementedError();

// void toggleFavored(BuildContext context) async {
//   setState(() =>
//       widget.favored == null ? false : widget.favored = !widget.favored!);
// }
}
