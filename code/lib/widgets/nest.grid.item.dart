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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              //print("Item Tapped");
              // TODO: ask Huzaifa what this is supposed to do
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
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(photo),
                ),
              ),
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 0, 2, 5),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                widget.nest != null
                    ? widget.nest!.title
                    : widget.nestItem!.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
