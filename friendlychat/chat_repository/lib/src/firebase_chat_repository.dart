import 'package:chat_repository/src/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../chat_repository.dart';
import 'chat_repository.dart';

class FirebaseChatRepository implements ChatRepository {
  final groupsCollection = Firestore.instance.collection('groups');

  @override
  Future<void> sendMessage() {
    // TODO: implement sendMessage
    return null;
  }

  @override
  Stream<List<Message>> messagesForGroup(String groupId) {
    // TODO: implement messagesForGroup
    final group = groupsCollection.document(groupId);
    return group
        .collection('messages')
        .snapshots()
        .map((QuerySnapshot doc) => {
          doc.documents.map((doc) => new Message(doc.))
        });
  }
}
