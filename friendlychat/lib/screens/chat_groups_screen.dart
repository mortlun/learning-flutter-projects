import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/bloc.dart';
import 'package:friendlychat/blocs/chat_groups_bloc/chat_groups_bloc.dart';
import 'package:friendlychat/blocs/chat_groups_bloc/chat_groups_state.dart';
import 'package:friendlychat/widgets/Triangle.dart';
import 'chat_screen.dart';

class ChatGroupsScreen extends StatelessWidget {
  const ChatGroupsScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loadingIndicator = Center(
      child: CircularProgressIndicator(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Groups"),
      ),
      body: BlocBuilder<ChatGroupsBloc, ChatGroupsState>(builder: (
        context,
        state,
      ) {
        if (state is ChatGroupsLoading) {
          return loadingIndicator;
        }
        if (state is ChatGroupsLoaded) {
          final tiles = state.loadedGroups.map((group) => ListTile(
                onTap: () {
                  BlocProvider.of<ChatBloc>(context).add(LoadChat(group));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              group: group,
                            )),
                  );
                },
                title: Text(group.name),
              ));
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          // return Center(
          //   child: Container(
          //     child: CustomPaint(
          //       painter: Triangle(),
          //       size: Size(400, 400),
          //     ),
          //     color: Colors.blue,
          //   ),
          // );
          return ListView(
            children: divided,
          );
        }
      }),
    );
  }
}
