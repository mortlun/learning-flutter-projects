// Replace the code in main.dart with the following.

import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/chat_bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/chat_event.dart';
import 'package:friendlychat/blocs/simple_bloc_delegate.dart';
import 'package:friendlychat/screens/chat_groups_screen.dart';
import 'package:friendlychat/screens/chat_screen.dart'; //new

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

void main() {
  print("App started...");
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(new FriendlychatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      create: (context) {
        return ChatBloc(chatRepository: FirebaseChatRepository())
          ..add(LoadChatGroups());
      },
      child: new MaterialApp(
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? kIOSTheme
            : kDefaultTheme,
        title: "Friendlychat",
        home: new ChatGroupsScreen(),
      ),
    );
  }
}
