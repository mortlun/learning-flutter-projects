import 'package:cloud_firestore/cloud_firestore.dart';
import '../chat_repository.dart';
import 'chat_repository.dart';

class FirebaseChatRepository implements ChatRepository {
  final groupsCollection = Firestore.instance.collection('groups');

  @override
  Future<void> sendMessage(String groupId, Message message) {
    final group = groupsCollection.document(groupId);
    group.collection('messages').add(message.toJson());
    return null;
  }

  @override
  Stream<List<Message>> messagesForGroup(String groupId) {
    final group = groupsCollection.document(groupId);
    return group.collection('messages').snapshots().map((QuerySnapshot doc) =>
        doc.documents
            .map((doc) => Message.fromSnapshot(doc.documentID, doc.data)));
  }

  @override
  Stream<List<Group>> chatGroups() {
    // TODO: implement chatGroups
    return null;
  }
}
