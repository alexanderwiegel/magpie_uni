import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:magpie_uni/model/chatSessionModel.dart';
import 'package:magpie_uni/model/feedUserProfileModel.dart';
import 'package:magpie_uni/view/chat/chatDetailPage.dart';
import 'package:magpie_uni/widgets/nestGridItem.dart';
import 'package:http/http.dart' as http;
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/Constants.dart' as Constants;

class FeedUserProfile extends StatefulWidget {
  String userName;
  String email;
  int userId;
  FeedUserProfile({
    required this.userName,
    required this.email,
    required this.userId,
  });
  @override
  _NestUserProfileState createState() => _NestUserProfileState();
}

class _NestUserProfileState extends State<FeedUserProfile> {
  late Future<FeedUserProfileResponse> response;
  List<FeedNest> nests = [];
  List<NestItem> nestItems = [];
  Profile? profile;
  bool isNestSelected = true;

  @override
  void initState() {
    super.initState();
    this.profile = Profile(
      username: this.widget.userName,
      photo: null,
      email: this.widget.email,
      nestCount: 0,
      nestItemCount: 0,
    );
    fetchFeedUserProfile(this.widget.userId);
  }

  Future fetchFeedUserProfile(int feedUserId) async {
    var headers = UserAPIManager().getAPIHeader();
    final response = await http.get(
        Uri.parse('http://localhost:3000/feed/userProfile?userId=$feedUserId'),
        headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        FeedUserProfileResponse result =
            FeedUserProfileResponse.fromJson(jsonDecode(response.body));
        print(result);
        this.nestItems = result.nestItems == null ? [] : result.nestItems!;
        this.nests = result.nests == null ? [] : result.nests!;
        this.profile = result.profile;
      });
    } else {
      throw Exception('Failed to load Feeds');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Constants.mainColor.shade900,
                  Constants.mainColor.shade200,
                  // Colors.blue,
                ],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        height: height * 0.40,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double innerHeight = constraints.maxHeight;
                            double innerWidth = constraints.maxWidth;
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  bottom: 15,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: innerHeight * 0.65,
                                    width: innerWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 80,
                                        ),
                                        Text(
                                          this.widget.userName,
                                          style: TextStyle(
                                            color: Constants.mainColor[900],
                                            fontSize: 30,
                                          ),
                                        ),
                                        Text(
                                          '@' +
                                              this
                                                  .widget
                                                  .email
                                                  .split("@")
                                                  .first,
                                          style: TextStyle(
                                            color: Color.fromRGBO(4, 9, 35, 1),
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                print("testing");
                                                this.isNestSelected = true;
                                                this.setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Nests',
                                                    style: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    this
                                                        .profile!
                                                        .nestCount
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Constants
                                                          .mainColor[900],
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 50,
                                                vertical: 8,
                                              ),
                                              child: Container(
                                                height: 50,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                print("testing");
                                                this.isNestSelected = false;
                                                this.setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Items',
                                                    style: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    this
                                                        .profile!
                                                        .nestItemCount
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Constants
                                                          .mainColor[900],
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Container(
                                      child: Image.asset(
                                        "pics/profile.png",
                                        width: innerWidth * 0.45,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      //
                      ConstrainedBox(
                        constraints: new BoxConstraints(
                          minHeight: height * 0.30,
                          minWidth: width,
                        ),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(
                              children: [
                                Text(
                                  this.isNestSelected ? "Nests" : "Items",
                                  style: TextStyle(
                                    color: Constants.mainColor[900],
                                    fontSize: 25,
                                  ),
                                ),
                                Divider(
                                  thickness: 1.5,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.0,
                                      mainAxisSpacing: 5.0,
                                      crossAxisSpacing: 5.0,
                                    ),
                                    itemCount: isNestSelected
                                        ? this.nests.length
                                        : this.nestItems.length,
                                    itemBuilder: (context, index) {
                                      var nest = isNestSelected
                                          ? this.nests[index]
                                          : null;
                                      var nestItem = isNestSelected
                                          ? null
                                          : this.nestItems[index];
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
                      ),
                      //
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
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

  void floatingBtnPressed() {
    var userId = this.widget.userId;
    this.fetchUserChatSession(UserAPIManager.currentUserId, userId);
  }

  Future fetchUserChatSession(int currentUserId, int opponentId) async {
    var headers = UserAPIManager().getAPIHeader();
    final response = await http.get(
        Uri.parse(
            'http://localhost:3000/chat/checkAndInsertChatSession?currentUserId=$currentUserId&opponentUserId=$opponentId'),
        headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      NewChatSessionResponse result =
          NewChatSessionResponse.fromJson(jsonDecode(response.body));

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ChatDetailPage(
          chatSession: result.chat,
          onBackPressed: (value) {
            print(value);
          },
        );
      }));
    } else {
      throw Exception('Failed to load Feeds');
    }
  }
}
