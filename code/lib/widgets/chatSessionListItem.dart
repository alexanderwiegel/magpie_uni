import 'package:flutter/material.dart';
import 'package:magpie_uni/view/chat/chatDetailPage.dart';
import 'package:magpie_uni/model/chatSessionModel.dart';
import '../Constants.dart' as Constants;

class ChatSessionListItem extends StatefulWidget {
  final ValueChanged onBackPressed;
  ChatSession chatSession;
  ChatSessionListItem({required this.chatSession, required this.onBackPressed});
  @override
  _ChatSessionListItemState createState() => _ChatSessionListItemState();
}

class _ChatSessionListItemState extends State<ChatSessionListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage(
            chatSession: widget.chatSession,
            onBackPressed: (value) {
              this.widget.onBackPressed(value);
              print(value);
            },
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJGNHFnbUHLoK_9zZ8nM1aI0HLu7P6eyu83eJAs_D9lv9qY_au3YFraMk01LgqOm6ju5I&usqp=CAU"),
                        maxRadius: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.chatSession.opponentUserName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      widget.chatSession.unreadMessages != 0
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                widget.chatSession.topMessage ?? "",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    fontWeight:
                                        widget.chatSession.unreadMessages != 0
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      widget.chatSession.lastMessageTime ?? "",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: widget.chatSession.unreadMessages != 0
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: this.widget.chatSession.unreadMessages == 0
                            ? Colors.white
                            : Constants.mainColor,
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 25,
                        minHeight: 25,
                      ),
                      child: Center(
                        child: new Text(
                          this.widget.chatSession.unreadMessages == 0
                              ? ""
                              : this
                                  .widget
                                  .chatSession
                                  .unreadMessages
                                  .toString(),
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
