import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:magpie_uni/model/chat.message.dart';
import 'package:magpie_uni/model/notification.model.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/view/chat/chat.list.dart';
import 'package:magpie_uni/view/feeds/feed.list.dart';
import 'package:magpie_uni/view/home.dart';
import 'package:magpie_uni/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int badgeCount = 0;
  int selectedIndex = 0;
  List<Widget> tabBarPages = <Widget>[];

  dynamic socket;

  @override
  void initState() {
    super.initState();
    tabBarPages = [
      const Home(),
      const FeedList(),
      ChatList(
        onBackPressed: (value) {
          getNotifications();
        },
      ),
      Container(),
    ];
    getNotifications();
    initSocket();
  }

  void getNotifications() async {
    await fetchChatNotificationCount(UserAPIManager.currentUserId);
    setState(() {});
  }

  Future fetchChatNotificationCount(int loggedUserId) async {
    var headers = UserAPIManager().getAPIHeader();
    final response = await get(
      Uri.parse(
        ApiEndpoints.urlPrefix + 'chat/getNotification?userId=$loggedUserId',
      ),
      headers: headers,
    );

    if (response.statusCode == 200) {
      NotificationResponse n = NotificationResponse.fromJson(
        jsonDecode(response.body),
      );
      badgeCount = n.notificationCount;
    } else {
      throw Exception('Failed to load chat');
    }
  }

  void initSocket() {
    socket = io(ApiEndpoints.urlPrefix, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    socket.on("receive_message", (message) {
      ChatMessage newMessage = ChatMessage.fromJson(message);
      if (newMessage.senderId == UserAPIManager.currentUserId ||
          newMessage.receiverId == UserAPIManager.currentUserId) {
        getNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin,
              size: 30.0,
            ),
            label: "Profile",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.feed_outlined,
              size: 30.0,
            ),
            label: "Feeds",
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                const Icon(
                  Icons.chat,
                  size: 30.0,
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: badgeCount == 0 ? Colors.transparent : Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                  ),
                )
              ],
            ),
            label: "Chat",
          ),
        ],
        onTap: (index) => setState(() {
          getNotifications();
          badgeCount = index == 2 ? 0 : badgeCount;
          selectedIndex = index;
        }),
      ),
      body: tabBarPages.elementAt(selectedIndex),
    );
  }
}
