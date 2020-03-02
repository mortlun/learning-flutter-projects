class Message {
  String content;
  String id;
  DateTime timestamp;
  String senderId;

  Message(this.id, this.content, this.timestamp, this.senderId);

  Message.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        content = json["content"],
        timestamp = json["timestamp"],
        senderId = json["senderId"];

  Message.fromSnapshot(String id, Map<String, dynamic> json)
      : id = id,
        content = json["content"],
        timestamp = json["timestamp"],
        senderId = json["senderId"];

  Map<String, dynamic> toJson() =>
      {"content": content, "timestamp": timestamp, "senderId": senderId};
}
