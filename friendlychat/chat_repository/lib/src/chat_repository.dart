import 'package:chat_repository/chat_repository.dart';

abstract class ChatRepository {
  Future<void> sendMessage();
  Stream<List<Message>> messagesForGroup(String groupId);
}
