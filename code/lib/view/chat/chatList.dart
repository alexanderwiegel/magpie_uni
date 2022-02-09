import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:magpie_uni/model/chatSessionModel.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/widgets/chatSessionListItem.dart';
import 'package:magpie_uni/model/chatMessage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:magpie_uni/network/user_api_manager.dart';

// Future<ChatSessionResponse> fetchChatSessions(int loggedUserId) async {
//   var headers = UserAPIManager().getAPIHeader();
//   final response = await http.get(
//       Uri.parse('http://localhost:3000/chat/getChatList?userId=$loggedUserId'),
//       headers: headers);

//   if (response.statusCode == 200) {
//     print(response.body);
//     return ChatSessionResponse.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load chat');
//   }
// }

class ChatList extends StatefulWidget {
  final ValueChanged onBackPressed;
  ChatList({required this.onBackPressed});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatList> {
  TextEditingController searchTxtField = TextEditingController();
  late Future<ChatSessionResponse> response;
  dynamic socket;

  @override
  void initState() {
    super.initState();
    this.getData();
    initSocket();
  }

  void initSocket() {
    socket = IO.io(ApiEndpoints.urlPrefix, <String, dynamic>{
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
        this.getData();
      }
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void getData() {
    this.setState(() {
      response = ApiEndpoints.fetchChatSessions(UserAPIManager.currentUserId);
    });
  }

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
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Chats",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                child: TextField(
                  controller: searchTxtField,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (text) {
                    this.didEditSearchTextField(text);
                  },
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                  ),
                ),
              ),
            ),
            FutureBuilder<ChatSessionResponse>(
              future: response,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  this.chatSessions = snapshot.data!.chat;
                  this.filteredSession = searchTxtField.text.trim().isNotEmpty
                      ? chatSessions
                          .where((element) => element.opponentUserName
                              .toLowerCase()
                              .contains(
                                  searchTxtField.text.trim().toLowerCase()))
                          .toList()
                      : this.chatSessions;
                  if (snapshot.data!.chat.isNotEmpty) {
                    if (filteredSession.isEmpty &&
                        searchTxtField.text.trim().isNotEmpty) {
                      return Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            "No search results founds.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey[350],
                          indent: 90.0,
                          endIndent: 16.0,
                        ),
                        itemCount: filteredSession.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChatSessionListItem(
                            chatSession: filteredSession[index],
                            onBackPressed: (value) {
                              this.widget.onBackPressed(value);
                              print(value);
                              this.getData();
                            },
                          );
                        },
                      );
                    }
                  } else {
                    return Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          "No Chats Available.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Container(
                    child: Text("$snapshot"),
                  );
                }
                // By default, show a loading spinner.
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                // return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  List<ChatSession> chatSessions = [];

  List<ChatSession> filteredSession = [];

  void didEditSearchTextField(String text) {
    this.setState(() {
      //Scrolldown the list to show the latest message
      print('Inside Function: $text');
      if (text.isNotEmpty) {
        print('text not empty: $text');
        this.filteredSession = chatSessions
            .where((element) => element.opponentUserName
                .toLowerCase()
                .contains(text.toLowerCase()))
            .toList();
        print(filteredSession.length);
      } else {
        this.filteredSession = chatSessions;
      }
    });
  }
}
