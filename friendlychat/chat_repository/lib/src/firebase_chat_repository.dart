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
    return group.collection('messages').snapshots().map(
        (QuerySnapshot snapshot) => snapshot.documents
            .map((doc) => Message.fromSnapshot(doc.documentID, doc.data))
            .toList());
  }

  @override
  Stream<List<Group>> chatGroups() {
    print("chatgroups");
    return groupsCollection.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.documents.map((DocumentSnapshot doc) {
        // print((doc.data["participants"].length));
        return Group.fromSnapshot(doc.documentID, doc.data);
      }).toList();
    });
  }
}
