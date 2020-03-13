import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/chat_event.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:meta/meta.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  StreamSubscription _chatSubscription;

  ChatBloc({@required ChatRepository chatRepository})
      : assert(chatRepository != null),
        _chatRepository = chatRepository;

  @override
  ChatState get initialState => ChatLoading();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is LoadChat) {
      _chatSubscription?.cancel();
      _chatSubscription = _chatRepository
          .messagesForGroup(event.group.id)
          .listen((chatMessages) => add(ChatUpdated(chatMessages)));
    } else if (event is ChatUpdated) {
      yield ChatLoaded(event.chatMessages);
    } else if (event is SendChatMessage) {
      print('Message: ${event.message.content} sent!');
      _chatRepository.sendMessage(event.groupId, event.message);
    }
  }

  @override
  Future<void> close() {
    print("CLOSED chat_bloc");
    _chatSubscription?.cancel();
    return super.close();
  }
}
