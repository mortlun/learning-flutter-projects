// Replace the code in main.dart with the following.

import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlychat/blocs/auth_bloc/auth_bloc.dart';
import 'package:friendlychat/blocs/auth_bloc/auth_event.dart';
import 'package:friendlychat/blocs/chat_bloc/chat_bloc.dart';
import 'package:friendlychat/blocs/chat_groups_bloc/chat_groups_bloc.dart';
import 'package:friendlychat/blocs/simple_bloc_delegate.dart';
import 'package:friendlychat/screens/chat_groups_screen.dart';
import 'package:user_repository/user_repository.dart';

import 'blocs/chat_groups_bloc/chat_groups_event.dart'; //new
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

final ChatRepository _chatRepository = FirebaseChatRepository();
void main() {
  print("App started...");
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(new FriendlychatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(create: (context) {
          return ChatBloc(chatRepository: _chatRepository);
        }),
        BlocProvider<ChatGroupsBloc>(create: (context) {
          return ChatGroupsBloc(chatRepository: _chatRepository)
            ..add(LoadChatGroups());
        }),
        BlocProvider<AuthBloc>(create: (context) {
          return AuthBloc(userRepository: FirebaseUserRepository())
            ..add(AppStarted());
        })
      ],
      child: new MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? kIOSTheme
            : kDefaultTheme,
        title: "Friendlychat",
        home: new ChatGroupsScreen(),
      ),
    );
  }
}
