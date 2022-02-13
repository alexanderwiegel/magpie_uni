import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/model/feed.user.profile.model.dart';
import 'package:magpie_uni/view/feeds/feed.item.detail.page.dart';
import 'package:magpie_uni/view/feeds/feed.nest.detail.dart';

class NestGridItem extends StatefulWidget {
  final FeedNest? nest;
  final FeedNestItem? nestItem;

  const NestGridItem({
    Key? key,
    required this.nest,
    required this.nestItem,
  }) : super(key: key);

  @override
  _NestGridItemState createState() => _NestGridItemState();
}

class _NestGridItemState extends State<NestGridItem> {
  var photo =
      "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png";

  @override
  void initState() {
    super.initState();
    photo = widget.nest != null
        ? widget.nest!.getImage()
        : widget.nestItem!.getImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(photo, fit: BoxFit.cover),
    );

    return GestureDetector(
      // #region onTap
      onTap: () {
        //print("Item Tapped");
        if (widget.nest != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FeedNestDetail(
                nest: widget.nest!,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FeedItemDetail(
                feed: null,
                nestItem: widget.nestItem!,
              ),
            ),
          );
        }
      },
      //#endregion
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
                widget.nest != null ? widget.nest!.title : widget.nestItem!.title,
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
}
