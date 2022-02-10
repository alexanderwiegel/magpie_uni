import 'dart:async';
import 'package:flutter/material.dart';
import 'package:magpie_uni/model/chatMessage.dart';
import 'package:magpie_uni/model/chatSessionModel.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:magpie_uni/Constants.dart' as Constants;
import 'package:magpie_uni/services/apiEndpoints.dart';

// Future<ChatMessageResponse> fetchChat(int loggedUserId, int sessionId) async {
//   var headers = UserAPIManager().getAPIHeader();

//   final response = await http.get(
//       Uri.parse(
//           'http://localhost:3000/chat/getChatHistoryById?userId=$loggedUserId&chatSessionId=$sessionId'),
//       headers: headers);

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     print(response.body);
//     return ChatMessageResponse.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load chat');
//   }
// }

Future<http.Response?> updateReadBit(int loggedUserId, int sessionId) async {
  var headers = UserAPIManager().getAPIHeader();
  final response = await http.get(
      Uri.parse(ApiEndpoints.urlPrefix +
          '/chat/updateReadBit?userId=$loggedUserId&chatSessionId=$sessionId'),
      headers: headers);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return null;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load chat');
  }
}

class ChatDetailPage extends StatefulWidget {
  final ValueChanged onBackPressed;
  int currentUserId = UserAPIManager.currentUserId;
  ChatSession chatSession;
  ChatDetailPage({required this.chatSession, required this.onBackPressed});
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController messageTxtField = new TextEditingController();
  ScrollController scrollController = new ScrollController();
  dynamic socket;
  late Future<ChatMessageResponse> response;

  @override
  void initState() {
    super.initState();
    // response = fetchChat(this.widget.currentUserId, this.widget.chatSession.id);
    updateReadBit(this.widget.currentUserId, this.widget.chatSession.id);
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
      if (newMessage.chatSessionId == this.widget.chatSession.id &&
          newMessage.senderId != this.widget.currentUserId) {
        this.setState(() {
          this.messages.insert(
                0,
                newMessage,
              );
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    this.widget.onBackPressed(true);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJGNHFnbUHLoK_9zZ8nM1aI0HLu7P6eyu83eJAs_D9lv9qY_au3YFraMk01LgqOm6ju5I&usqp=CAU"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.chatSession.opponentUserName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder<ChatMessageResponse>(
            future: ApiEndpoints.fetchChat(
                this.widget.currentUserId, this.widget.chatSession.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                this.messages = snapshot.data!.chat;
                if (snapshot.data!.chat.isNotEmpty) {
                  return ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    reverse: true,
                    padding: EdgeInsets.only(top: 10, bottom: 90),
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: messages[index].senderId !=
                                this.widget.currentUserId
                            ? EdgeInsets.only(
                                left: 14, right: 50, top: 5, bottom: 5)
                            : EdgeInsets.only(
                                left: 50, right: 14, top: 5, bottom: 5),
                        // EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
                        child: Align(
                          alignment: (messages[index].senderId !=
                                  this.widget.currentUserId
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].senderId !=
                                      this.widget.currentUserId
                                  ? Colors.grey.shade200
                                  : Constants.mainColor[200]),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              messages[index].message,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Text(
                        "No Chat History Available.",
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
                  child: Text("Unable to load."),
                );
              }

              // By default, show a loading spinner.
              return Container(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 30, top: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                      controller: messageTxtField,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      this.sendMessage();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Constants.mainColor,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<ChatMessage> messages = [];

  void sendMessage() {
    if (messageTxtField.text.trim().isNotEmpty) {
      //Send the message as JSON data to send_message event
      var newMessage = ChatMessage(
          message: messageTxtField.text.trim(),
          senderId: this.widget.currentUserId,
          receiverId: this.widget.chatSession.opponentUserId,
          chatSessionId: this.widget.chatSession.id);
      socket.emit("send_message", newMessage.toJson());

      print("Send Message: ");
      print(newMessage.toJson());

      //Add the message to the list
      if (this.widget.currentUserId == 1) {
        this.setState(() {
          messages.insert(
            0,
            newMessage,
          );
          messageTxtField.text = '';

          if (this.messages.length > 1) {
            scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 600),
              curve: Curves.ease,
            );
          }
        });
      }
    }
  }
}
