import 'dart:async';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/bloc.dart';
import 'package:friendlychat/blocs/chat_groups_bloc/chat_groups_event.dart';
import 'package:friendlychat/blocs/chat_groups_bloc/chat_groups_state.dart';
import 'package:meta/meta.dart';

class ChatGroupsBloc extends Bloc<ChatGroupsEvent, ChatGroupsState> {
  StreamSubscription _chatGroupsSubscription;
  final ChatRepository _chatRepository;

  ChatGroupsBloc({@required ChatRepository chatRepository})
      : assert(chatRepository != null),
        _chatRepository = chatRepository;

  @override
  get initialState => ChatGroupsLoading();

  @override
  Stream<ChatGroupsState> mapEventToState(event) async* {
    if (event is LoadChatGroups) {
      _chatGroupsSubscription?.cancel();
      _chatGroupsSubscription = _chatRepository.chatGroups().listen((groups) {
        add(ChatGroupsUpdated(groups));
      });
    } else if (event is ChatGroupsUpdated) {
      yield ChatGroupsLoaded(event.chatGroups);
    }
  }

  @override
  Future<void> close() {
    print("CLOSED chat_groups_bloc");
    _chatGroupsSubscription?.cancel();
    return super.close();
  }
}
