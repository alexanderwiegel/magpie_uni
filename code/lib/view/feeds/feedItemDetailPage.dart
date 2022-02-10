import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:magpie_uni/model/feedsModel.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/view/chat/chatDetailPage.dart';
import 'package:http/http.dart' as http;
import 'package:magpie_uni/model/chatSessionModel.dart';
import 'package:magpie_uni/model/feedUserProfileModel.dart';
import 'package:magpie_uni/Constants.dart' as Constants;

class FeedItemDetail extends StatefulWidget {
  Feed? feed;
  FeedNestItem? nestItem;
  FeedItemDetail({required this.feed, required this.nestItem});
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
            padding: EdgeInsets.only(left: 5, right: 16, top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Center(
                  child: Text(
                    "Item Detail",
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
        physics: BouncingScrollPhysics(),
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
                    image: NetworkImage(this.widget.feed != null
                        ? this.widget.feed!.getImage()
                        : this.widget.nestItem!.getImage()),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 2),
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
                this.widget.feed != null
                    ? this.widget.feed!.title
                    : this.widget.nestItem!.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 2),
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
                this.widget.feed != null
                    ? this.widget.feed!.description
                    : this.widget.nestItem!.description,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
        child: FloatingActionButton(
          backgroundColor: Constants.mainColor[900],
          child: Icon(Icons.chat_outlined),
          onPressed: () {
            this.floatingBtnPressed();
          },
        ),
      ),
    );
  }

  Future<void> floatingBtnPressed() async {
    var userId = this.widget.feed != null
        ? this.widget.feed!.userId
        : this.widget.nestItem!.userId;
    NewChatSessionResponse response = await ApiEndpoints.fetchUserChatSession(
        UserAPIManager.currentUserId, userId);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChatDetailPage(
        chatSession: response.chat,
        onBackPressed: (value) {
          print(value);
        },
      );
    }));
  }

  // Future fetchUserChatSession(int currentUserId, int opponentId) async {
  //   var headers = UserAPIManager().getAPIHeader();
  //   final response = await http.get(
  //       Uri.parse(
  //           ApiEndpoints.urlPrefix + 'chat/checkAndInsertChatSession?currentUserId=$currentUserId&opponentUserId=$opponentId'),
  //       headers: headers);
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     NewChatSessionResponse result =
  //         NewChatSessionResponse.fromJson(jsonDecode(response.body));

  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return ChatDetailPage(
  //         chatSession: result.chat,
  //         onBackPressed: (value) {
  //           print(value);
  //         },
  //       );
  //     }));
  //   } else {
  //     throw Exception('Failed to load Feeds');
  //   }
  // }
}
