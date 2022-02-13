import 'dart:async';
import 'package:flutter/material.dart';

import 'package:magpie_uni/model/chat.session.model.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/widgets/chat.session.list.item.dart';
import 'package:magpie_uni/model/chat.message.dart';
import 'package:magpie_uni/widgets/magpie.drawer.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:magpie_uni/network/user_api_manager.dart';

class ChatList extends StatefulWidget {
  final ValueChanged onBackPressed;

  const ChatList({Key? key, required this.onBackPressed}) : super(key: key);

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
    getData();
    initSocket();
  }

  void initSocket() {
    socket = io(ApiEndpoints.urlPrefix, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    socket.on("receive_message", (message) {
      //print("Received Message: ");
      //print(message);
      ChatMessage newMessage = ChatMessage.fromJson(message);
      //print(newMessage.message);
      if (newMessage.senderId == UserAPIManager.currentUserId ||
          newMessage.receiverId == UserAPIManager.currentUserId) {
        getData();
      }
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void getData() {
    setState(() {
      response = ApiEndpoints.fetchChatSessions(UserAPIManager.currentUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MagpieDrawer(),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                child: TextField(
                  controller: searchTxtField,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (text) {
                    didEditSearchTextField(text);
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
                    contentPadding: const EdgeInsets.all(8),
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
                  chatSessions = snapshot.data!.chat;
                  filteredSession = searchTxtField.text.trim().isNotEmpty
                      ? chatSessions
                          .where((element) => element.opponentUserName
                              .toLowerCase()
                              .contains(
                                  searchTxtField.text.trim().toLowerCase()))
                          .toList()
                      : chatSessions;
                  if (snapshot.data!.chat.isNotEmpty) {
                    if (filteredSession.isEmpty &&
                        searchTxtField.text.trim().isNotEmpty) {
                      return Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Center(
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
                        padding: const EdgeInsets.only(top: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChatSessionListItem(
                            chatSession: filteredSession[index],
                            onBackPressed: (value) {
                              widget.onBackPressed(value);
                              //print(value);
                              getData();
                            },
                          );
                        },
                      );
                    }
                  } else {
                    return Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: const Center(
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
                  return Text("$snapshot");
                }
                // By default, show a loading spinner.
                return Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: const Center(
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
    setState(() {
      //Scrolldown the list to show the latest message
      //print('Inside Function: $text');
      if (text.isNotEmpty) {
        //print('text not empty: $text');
        filteredSession = chatSessions
            .where((element) => element.opponentUserName
                .toLowerCase()
                .contains(text.toLowerCase()))
            .toList();
        //print(filteredSession.length);
      } else {
        filteredSession = chatSessions;
      }
    });
  }
}
