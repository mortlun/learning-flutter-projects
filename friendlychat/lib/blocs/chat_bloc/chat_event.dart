import 'package:equatable/equatable.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:friendlychat/blocs/chat_bloc/bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadChatGroups extends ChatEvent {}

class ChatGroupsUpdated extends ChatEvent {
  final List<Group> chatGroups;
  const ChatGroupsUpdated(this.chatGroups);
}

class LoadChat extends ChatEvent {
  final Group group;
  LoadChat(this.group);
}

class ChatUpdated extends ChatEvent {
  final List<Message> chatMessages;
  ChatUpdated(this.chatMessages);
}
