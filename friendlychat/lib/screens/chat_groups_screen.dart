import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/bloc.dart';

import 'chat_screen.dart';

class ChatGroupsScreen extends StatelessWidget {
  const ChatGroupsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatBloc chatBloc = BlocProvider.of<ChatBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat groups"),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
        if (state is ChatGroupsLoaded) {
          final tiles = state.loadedGroups.map((group) => ListTile(
                onTap: () {
                  chatBloc.add(LoadChat(group));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                title: Text(group.name),
                trailing: Text(2.toString()),
              ));
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return ListView(
            children: divided,
          );
        }
        return RaisedButton(
          child: Text("test"),
          onPressed: () {
            chatBloc.add(LoadChatGroups());
          },
        );
      }),
    );
  }
}
