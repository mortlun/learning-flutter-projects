import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/chat_event.dart';
import 'package:chat_repository/chat_repository.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  StreamSubscription _chatSubscription;

  ChatBloc({@required ChatRepository chatRepository})
      : assert(chatRepository != null),
        _chatRepository = chatRepository;

  @override
  // TODO: implement initialState
  ChatState get initialState => ChatGroupsLoading();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is LoadChatGroups) {
      _chatSubscription?.cancel();
      _chatSubscription = _chatRepository.chatGroups().listen((groups) {
        add(ChatGroupsUpdated(groups));
      });
    } else if (event is LoadChat) {
      _chatSubscription?.cancel();
      _chatSubscription = _chatRepository
          .messagesForGroup(event.group.id)
          .listen((chatMessages) => add(ChatUpdated(chatMessages)));
    } else if (event is ChatGroupsUpdated) {
      yield ChatGroupsLoaded(event.chatGroups);
    } else if (event is ChatUpdated) {
      yield ChatLoaded(event.chatMessages);
    }
  }
}
