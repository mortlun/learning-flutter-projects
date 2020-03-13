import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  String content;
  String id;
  DateTime timestamp;
  String senderId;

  Message(this.content, {this.id, this.senderId});

  Message.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        content = json["content"],
        timestamp = json["timestamp"],
        senderId = json["senderId"];

  Message.fromSnapshot(String id, Map<String, dynamic> json)
      : id = id,
        content = json["content"],
        timestamp = json["timestamp"]?.toDate(),
        senderId = json["senderId"];

  Map<String, dynamic> toJson() => {
        "content": content,
        "timestamp": FieldValue.serverTimestamp(),
        "senderId": senderId
      };

  @override
  // TODO: implement props
  List<Object> get props => [id, content, timestamp, senderId];
}
