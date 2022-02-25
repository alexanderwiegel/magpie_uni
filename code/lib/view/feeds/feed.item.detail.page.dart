import 'dart:math';

import 'package:flutter/material.dart';

import 'package:magpie_uni/model/feeds.model.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/view/chat/chat.detail.page.dart';
import 'package:magpie_uni/model/chat.session.model.dart';
import 'package:magpie_uni/model/feed.user.profile.model.dart';
import 'package:magpie_uni/constants.dart';

class FeedItemDetail extends StatefulWidget {
  final Feed? feed;
  final FeedNestItem? nestItem;

  const FeedItemDetail({Key? key, required this.feed, required this.nestItem})
      : super(key: key);

  @override
  _FeedItemDetailState createState() => _FeedItemDetailState();
}

class _FeedItemDetailState extends State<FeedItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Item detail",
          style: TextStyle(fontSize: SizeConfig.iconSize / 1.75),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: min(SizeConfig.screenWidth, 600),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.network(
                    widget.feed != null
                        ? widget.feed!.getImage()
                        : widget.nestItem!.getImage(),
                    fit: BoxFit.cover,
                    width: SizeConfig.screenWidth,
                    height: min(SizeConfig.screenWidth, 600) / 1.6,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 2),
                  child: Text(
                    "Title:",
                    style: TextStyle(
                      fontSize: SizeConfig.iconSize / 1.75,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                  child: Text(
                    widget.feed != null
                        ? widget.feed!.title
                        : widget.nestItem!.title,
                    style: TextStyle(
                      fontSize: SizeConfig.iconSize / 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 2),
                  child: Text(
                    "Description:",
                    style: TextStyle(
                      fontSize: SizeConfig.iconSize / 1.75,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 15),
                  child: Text(
                    widget.feed != null
                        ? widget.feed!.description
                        : widget.nestItem!.description,
                    style: TextStyle(
                      fontSize: SizeConfig.iconSize / 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
        child: FloatingActionButton(
          backgroundColor: mainColor[900],
          child: const Icon(Icons.chat_outlined),
          onPressed: () => floatingBtnPressed(),
        ),
      ),
    );
  }

  Future<void> floatingBtnPressed() async {
    var userId =
        widget.feed != null ? widget.feed!.userId : widget.nestItem!.userId;
    NewChatSessionResponse response = await ApiEndpoints.fetchUserChatSession(
      UserAPIManager.currentUserId,
      userId,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailPage(
          chatSession: response.chat,
          onBackPressed: (value) => print(value),
        ),
      ),
    );
  }
}
