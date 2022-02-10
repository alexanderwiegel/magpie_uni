import 'package:flutter/material.dart';
import 'package:magpie_uni/view/chat/chat.detail.page.dart';
import 'package:magpie_uni/model/chat.session.model.dart';
import 'package:magpie_uni/constants.dart';

class ChatSessionListItem extends StatefulWidget {
  final ValueChanged onBackPressed;
  final ChatSession chatSession;

  const ChatSessionListItem({
    Key? key,
    required this.chatSession,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  _ChatSessionListItemState createState() => _ChatSessionListItemState();
}

class _ChatSessionListItemState extends State<ChatSessionListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatDetailPage(
            chatSession: widget.chatSession,
            onBackPressed: (value) {
              widget.onBackPressed(value);
              //print(value);
            },
          ),
        ),
      ),
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJGNHFnbUHLoK_9zZ8nM1aI0HLu7P6eyu83eJAs_D9lv9qY_au3YFraMk01LgqOm6ju5I&usqp=CAU"),
                        maxRadius: 30,
                      ),
                      const SizedBox(width: 16),
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
                              const SizedBox(height: 6),
                              Text(
                                widget.chatSession.topMessage ?? "",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                  fontWeight:
                                      widget.chatSession.unreadMessages != 0
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
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
                            : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: widget.chatSession.unreadMessages == 0
                            ? Colors.white
                            : mainColor,
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 25,
                        minHeight: 25,
                      ),
                      child: Center(
                        child: Text(
                          widget.chatSession.unreadMessages == 0
                              ? ""
                              : widget.chatSession.unreadMessages.toString(),
                          style: const TextStyle(
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
