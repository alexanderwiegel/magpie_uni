import 'package:flutter/material.dart';
import 'package:magpie_uni/view/home.dart';
import 'dart:convert';
import '../view/chat/chatList.dart';
import '../view/feeds/feedList.dart';
import '../model/chatMessage.dart';
import '../model/notificationModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../network/user_api_manager.dart';
import 'package:http/http.dart' as http;
import 'package:magpie_uni/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future fetchChatNotificationCount(int loggedUserId) async {
    var headers = UserAPIManager().getAPIHeader();
    final response = await http.get(
        Uri.parse(
            'http://10.0.2.2:3000/chat/getNotification?userId=$loggedUserId'),
        headers: headers);

    if (response.statusCode == 200) {
      print(response.body);
      NotificationResponse n =
          NotificationResponse.fromJson(jsonDecode(response.body));
      badgeCount = n.notificationCount;
    } else {
      throw Exception('Failed to load chat');
    }
  }

  int badgeCount = 0;
  int selectedIndex = 0;
  List<Widget> tabBarPages = <Widget>[];

  dynamic socket;

  @override
  void initState() {
    super.initState();
    tabBarPages = [
      Home(),
      FeedList(),
      ChatList(
        onBackPressed: (value) {
          print(value);
          print("home on back called");
          getNotifications();
        },
      ),
      Container(),
    ];
    getNotifications();
    initSocket();
  }

  void initSocket() {
    socket = IO.io("http://localhost:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    socket.on("receive_message", (message) {
      print("Received Message: ");
      print(message);
      ChatMessage newMessage = ChatMessage.fromJson(message);
      print(newMessage.message);
      if (newMessage.senderId == UserAPIManager.currentUserId ||
          newMessage.receiverId == UserAPIManager.currentUserId) {
        getNotifications();
      }
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void getNotifications() {
    setState(() {
      fetchChatNotificationCount(UserAPIManager.currentUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: ChatList(),
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
                      color: badgeCount == 0
                          ? Colors.transparent
                          : Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    // child: new Text(
                    //   '5',
                    //   style: new TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 10,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                  ),
                )
              ],
            ),
            label: "Chat",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              size: 30.0,
            ),
            label: "Menu",
          ),
        ],
        onTap: (index) {
          setState(() {
            getNotifications();
            selectedIndex = index;
          });
        },
      ),
      body: tabBarPages.elementAt(selectedIndex),
    );
  }
}
