import 'package:flutter/material.dart';

import 'package:magpie_uni/model/feeds.model.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/view/chat/chat.detail.page.dart';
import 'package:magpie_uni/model/chat.session.model.dart';
import 'package:magpie_uni/model/feed.user.profile.model.dart';
import 'package:magpie_uni/Constants.dart';

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
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 16, top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const Center(
                  child: Text(
                    "Item detail",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                      widget.feed != null
                          ? widget.feed!.getImage()
                          : widget.nestItem!.getImage(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 10, 8, 2),
              child: Text(
                "Title:",
                style: TextStyle(
                  fontSize: 14,
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
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 5, 8, 2),
              child: Text(
                "Description:",
                style: TextStyle(
                  fontSize: 14,
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
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
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
