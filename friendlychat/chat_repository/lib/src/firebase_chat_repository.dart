import 'package:cloud_firestore/cloud_firestore.dart';
import '../chat_repository.dart';
import 'chat_repository.dart';

class FirebaseChatRepository implements ChatRepository {
  final groupsCollection = Firestore.instance.collection('groups');

  @override
  Future<void> sendMessage(String groupId, Message message) {
    final group = groupsCollection.document(groupId);
    return group.collection('messages').add(message.toJson());
  }

  @override
  Stream<List<Message>> messagesForGroup(String groupId) {
    final group = groupsCollection.document(groupId);
    return group
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.documents.map((doc) {
              return Message.fromSnapshot(doc.documentID, doc.data);
            }).toList());
  }

  @override
  Stream<List<Group>> chatGroups() {
    return groupsCollection.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.documents.map((DocumentSnapshot doc) {
        print(doc.data);
        return Group.fromSnapshot(doc.documentID, doc.data);
      }).toList();
    });
  }
}
