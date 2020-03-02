import 'package:chat_repository/chat_repository.dart';

abstract class ChatRepository {
  Future<void> sendMessage(String groupId, Message message);
  Stream<List<Message>> messagesForGroup(String groupId);
  Stream<List<Group>> chatGroups();
}
