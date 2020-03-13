import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

abstract class ChatGroupsEvent extends Equatable {
  const ChatGroupsEvent();
  @override
  List<Object> get props => null;
}

class LoadChatGroups extends ChatGroupsEvent {}

class ChatGroupsUpdated extends ChatGroupsEvent {
  final List<Group> chatGroups;
  const ChatGroupsUpdated(this.chatGroups);
}
