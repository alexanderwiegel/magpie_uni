import 'dart:math';

import 'package:flutter/material.dart';

import 'package:magpie_uni/model/feed.user.nest.items.model.dart';
import 'package:magpie_uni/model/feed.user.profile.model.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/view/chat/chat.detail.page.dart';
import 'package:magpie_uni/model/chat.session.model.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/widgets/nest.grid.item.dart';

class FeedNestDetail extends StatefulWidget {
  final FeedNest nest;

  const FeedNestDetail({Key? key, required this.nest}) : super(key: key);

  @override
  _FeedNestDetailState createState() => _FeedNestDetailState();
}

class _FeedNestDetailState extends State<FeedNestDetail> {
  List<FeedNestItem> nestItems = [];

  @override
  void initState() {
    super.initState();
    fetchFeedUserNestItems();
  }

  Future<void> fetchFeedUserNestItems() async {
    FeedUserNestItemsResponse result =
        await ApiEndpoints.fetchFeedUserNestItems(widget.nest.id);
    setState(() {
      nestItems = result.nestItems!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Nest detail",
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
                    widget.nest.getImage(),
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
                    widget.nest.title,
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
                    widget.nest.description,
                    style: TextStyle(
                      fontSize: SizeConfig.iconSize / 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Nest items",
                            style: TextStyle(
                              color: mainColor,
                              fontSize: SizeConfig.iconSize / 1.5,
                            ),
                          ),
                          const Divider(thickness: 1.5),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.0,
                                mainAxisSpacing: 5.0,
                                crossAxisSpacing: 5.0,
                              ),
                              itemCount: nestItems.length,
                              itemBuilder: (context, index) {
                                var nestItem = nestItems[index];
                                return NestGridItem(
                                  nest: null,
                                  nestItem: nestItem,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        child: const Icon(Icons.chat_outlined),
        onPressed: () => floatingBtnPressed(),
      ),
    );
  }

  Future<void> floatingBtnPressed() async {
    NewChatSessionResponse response = await ApiEndpoints.fetchUserChatSession(
      UserAPIManager.currentUserId,
      widget.nest.userId,
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
