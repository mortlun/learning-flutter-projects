import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final Message message;
  final String userId;
  ChatMessage({this.message, this.userId});

  @override
  Widget build(BuildContext context) {
    final bool senderSameAsUser = message.senderId == userId;
    const String _name = "Morten";
    final circleWithName = Container(
      margin: const EdgeInsets.only(right: 16),
      child:
          new CircleAvatar(child: senderSameAsUser ? Text("Me") : Text("Anon")),
    );
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: new Row(
          mainAxisAlignment: senderSameAsUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            senderSameAsUser ? Container() : circleWithName,
            Flexible(
              child: new Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: new Text(
                  message.content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
                decoration: BoxDecoration(
                    color: senderSameAsUser
                        ? Colors.lightBlueAccent
                        : Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(27.5)),
              ),
            ),
          ],
        ));
  }
}
