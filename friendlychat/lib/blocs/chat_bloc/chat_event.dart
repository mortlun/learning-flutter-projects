import 'package:equatable/equatable.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:friendlychat/blocs/chat_bloc/bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadChat extends ChatEvent {
  final Group group;
  LoadChat(this.group);
}

class ChatUpdated extends ChatEvent {
  final List<Message> chatMessages;
  ChatUpdated(this.chatMessages);
}

class SendChatMessage extends ChatEvent {
  final Message message;
  final String groupId;
  SendChatMessage(this.groupId, this.message);
}
