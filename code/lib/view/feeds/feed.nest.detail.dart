import 'package:flutter/material.dart';

import 'package:magpie_uni/model/feeds.model.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/view/chat/chat.detail.page.dart';
import 'package:magpie_uni/model/chat.session.model.dart';
import 'package:magpie_uni/services/api.endpoints.dart';

class FeedNestDetail extends StatefulWidget {
  final Feed feed;

  const FeedNestDetail({Key? key, required this.feed}) : super(key: key);

  @override
  _FeedNestDetailState createState() => _FeedNestDetailState();
}

class _FeedNestDetailState extends State<FeedNestDetail> {
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
                    image: NetworkImage(widget.feed.getImage()),
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
                widget.feed.title,
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
                widget.feed.description,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(4, 9, 35, 1),
        child: const Icon(Icons.chat_outlined),
        onPressed: () => floatingBtnPressed(),
      ),
    );
  }

  Future<void> floatingBtnPressed() async {
    NewChatSessionResponse response = await ApiEndpoints.fetchUserChatSession(
      UserAPIManager.currentUserId,
      widget.feed.userId,
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
