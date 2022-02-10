import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 6.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 15, 8, 5),
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
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJGNHFnbUHLoK_9zZ8nM1aI0HLu7P6eyu83eJAs_D9lv9qY_au3YFraMk01LgqOm6ju5I&usqp=CAU"),
                      maxRadius: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.feed.username,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              "@" + widget.feed.email.split("@").first,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
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
                          style: const TextStyle(
                            fontSize: 12,
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
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(widget.feed.getImage()),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 2),
                    child: Text(
                      widget.feed.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 15),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16.0,
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
                                ? "See More"
                                : "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
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
