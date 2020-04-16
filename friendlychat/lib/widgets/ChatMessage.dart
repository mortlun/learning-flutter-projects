import 'package:bubble/bubble.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friendlychat/widgets/Triangle.dart';
import 'package:intl/intl.dart'; //for date format

class ChatMessage extends StatelessWidget {
  final Message message;
  final String userId;
  ChatMessage({this.message, this.userId});

  @override
  Widget build(BuildContext context) {
    final bool senderSameAsUser = message.senderId == userId;
    final circleWithName = Container(
      margin: const EdgeInsets.only(right: 5),
      child: new CircleAvatar(
        radius: 20,
        child: Text("Anon"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.black,
      ),
    );

    final _size = MediaQuery.of(context).size;
    final chatBubble = new Tooltip(
        message: message.timestamp != null
            ? new DateFormat.yMMMMd().add_Hm().format(message.timestamp)
            : "timestamp not set",
        verticalOffset: 20,
        preferBelow: false,
        child: Container(
          constraints: BoxConstraints(maxWidth: (_size.width / 3) * 2),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: new Text(
            message.content,
            style: TextStyle(
                color: senderSameAsUser ? Colors.white : Colors.black),
          ),
          decoration: BoxDecoration(
              color: senderSameAsUser ? Colors.blue[300] : Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(25))),
        ));

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: new Row(
        mainAxisAlignment:
            senderSameAsUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          senderSameAsUser ? Container() : circleWithName,
          Column(
            crossAxisAlignment: senderSameAsUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: <Widget>[
              chatBubble,
            ],
          ),
        ],
      ),
    );
  }
}
