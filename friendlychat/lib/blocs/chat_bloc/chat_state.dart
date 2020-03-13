import 'package:equatable/equatable.dart';
import 'package:chat_repository/chat_repository.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messagesLoaded;
  const ChatLoaded([this.messagesLoaded = const []]);

  @override
  // TODO: implement props
  List<Object> get props => [messagesLoaded];
}
