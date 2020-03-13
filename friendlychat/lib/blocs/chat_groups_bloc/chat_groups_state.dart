import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

abstract class ChatGroupsState extends Equatable {
  const ChatGroupsState();

  @override
  List<Object> get props => null;
}

class ChatGroupsLoading extends ChatGroupsState {}

class ChatGroupsLoaded extends ChatGroupsState {
  final List<Group> loadedGroups;
  const ChatGroupsLoaded([this.loadedGroups = const []]);
  @override
  List<Object> get props => [loadedGroups];
}
