import 'dart:math';

import 'package:flutter/material.dart';

import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/view/feeds/feed.item.detail.page.dart';
import 'package:magpie_uni/view/feeds/feed.user.profile.page.dart';
import 'package:magpie_uni/model/feeds.model.dart';

class FeedListItem extends StatefulWidget {
  final Feed feed;

  const FeedListItem({Key? key, required this.feed}) : super(key: key);

  @override
  _FeedListItemState createState() => _FeedListItemState();
}

class _FeedListItemState extends State<FeedListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedUserProfile(
                      userName: widget.feed.username,
                      email: widget.feed.email,
                      userId: widget.feed.userId,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: const NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJGNHFnbUHLoK_9zZ8nM1aI0HLu7P6eyu83eJAs_D9lv9qY_au3YFraMk01LgqOm6ju5I&usqp=CAU"),
                      maxRadius: SizeConfig.iconSize,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.feed.username,
                            style: TextStyle(
                              fontSize: SizeConfig.iconSize / 1.75,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "@" + widget.feed.email.split("@").first,
                            style: TextStyle(
                              fontSize: SizeConfig.iconSize / 2,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.feed.createdAt,
                          style: TextStyle(
                            fontSize: SizeConfig.iconSize / 2.25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedItemDetail(
                    feed: widget.feed,
                    nestItem: null,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Image.network(
                        widget.feed.getImage(),
                        fit: BoxFit.cover,
                        width: SizeConfig.screenWidth,
                        height: min(SizeConfig.screenWidth, 390) / 1.6,
                      ),
                    ),
                  ),
                  Text(
                    widget.feed.title,
                    style: TextStyle(
                      fontSize: SizeConfig.iconSize / 1.75,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: SizeConfig.iconSize / 2,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.feed.description.length > 200
                              ? widget.feed.description.substring(0, 130) +
                                  "... "
                              : widget.feed.description,
                        ),
                        TextSpan(
                          text: widget.feed.description.length > 200
                              ? "See more"
                              : "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
