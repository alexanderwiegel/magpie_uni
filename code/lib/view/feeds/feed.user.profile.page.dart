import 'dart:async';
import 'package:flutter/material.dart';

import 'package:magpie_uni/model/chat.session.model.dart';
import 'package:magpie_uni/model/feed.user.profile.model.dart';
import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/view/chat/chat.detail.page.dart';
import 'package:magpie_uni/widgets/nest.grid.item.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/services/api.endpoints.dart';

class FeedUserProfile extends StatefulWidget {
  final String userName;
  final String email;
  final int userId;

  const FeedUserProfile({
    Key? key,
    required this.userName,
    required this.email,
    required this.userId,
  }) : super(key: key);

  @override
  _NestUserProfileState createState() => _NestUserProfileState();
}

class _NestUserProfileState extends State<FeedUserProfile> {
  List<FeedNest> nests = [];
  List<FeedNestItem> nestItems = [];
  Profile? profile;
  bool isNestSelected = true;

  @override
  void initState() {
    super.initState();
    profile = Profile(
      username: widget.userName,
      photo: null,
      email: widget.email,
      nestCount: 0,
      nestItemCount: 0,
    );
    getFeedUserProfile();
  }

  Future<void> getFeedUserProfile() async {
    FeedUserProfileResponse result =
        await ApiEndpoints.fetchFeedUserProfile(widget.userId);
    setState(() {
      nestItems = result.nestItems;
      nests = result.nests;
      profile = result.profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontSize: SizeConfig.iconSize / 1.75),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  //user image
                  Center(
                    child: Image.asset(
                      "pics/profile.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        widget.userName,
                        style: TextStyle(
                          color: mainColor[900],
                          fontSize: SizeConfig.iconSize / 1.25,
                        ),
                      ),
                      Text(
                        '@' + widget.email.split("@").first,
                        style: TextStyle(
                          color: const Color.fromRGBO(4, 9, 35, 1),
                          fontSize: SizeConfig.iconSize / 2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //print("testing");
                              isNestSelected = true;
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Nests',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: SizeConfig.iconSize / 1.75,
                                  ),
                                ),
                                Text(
                                  profile!.nestCount.toString(),
                                  style: TextStyle(
                                    color: mainColor[900],
                                    fontSize: SizeConfig.iconSize / 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 8,
                            ),
                            child: Container(
                              height: 50,
                              width: 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() => isNestSelected = false);
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Items',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: SizeConfig.iconSize / 1.75,
                                  ),
                                ),
                                Text(
                                  profile!.nestItemCount.toString(),
                                  style: TextStyle(
                                    color: mainColor[900],
                                    fontSize: SizeConfig.iconSize / 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      isNestSelected ? "Nests" : "Items",
                      style: TextStyle(
                        color: mainColor[900],
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
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: SizeConfig.isTablet ? 4 : 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemCount:
                            isNestSelected ? nests.length : nestItems.length,
                        itemBuilder: (context, index) {
                          var nest = isNestSelected ? nests[index] : null;
                          var nestItem =
                              isNestSelected ? null : nestItems[index];
                          return NestGridItem(
                            nest: nest,
                            nestItem: nestItem,
                          );
                        },
                      ),
                    ),
                  ],
                ),
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

  void floatingBtnPressed() async {
    var userId = widget.userId;
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
