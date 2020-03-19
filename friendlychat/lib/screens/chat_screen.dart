import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlychat/blocs/auth_bloc/auth_bloc.dart';
import 'package:friendlychat/blocs/auth_bloc/auth_state.dart';
import 'package:friendlychat/blocs/chat_bloc/bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/chat_bloc.dart';
import 'package:friendlychat/blocs/chat_groups_bloc/chat_groups_bloc.dart';
import 'package:friendlychat/widgets/ChatMessage.dart';
import 'package:friendlychat/widgets/ChatMessageWIthAnimation.dart';
import 'package:friendlychat/widgets/Triangle.dart';

class ChatScreen extends StatefulWidget {
  final Group group;
  final String id;
  ChatScreen({Key key, this.group, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController =
      new TextEditingController(); //new
  final List<ChatMessageWithAnimation> _messages = <ChatMessageWithAnimation>[];
  bool _isComposing = false; //new

  @override
  Widget build(BuildContext context) {
    final ChatBloc chatBloc = BlocProvider.of<ChatBloc>(context);
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    final ChatGroupsBloc chatGroupsBloc =
        BlocProvider.of<ChatGroupsBloc>(context);

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.group.name),
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
          if (state is ChatLoaded) {
            final messages = state.messagesLoaded;
            return Container(
              child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                final listBuilder = ListView.builder(
                  padding: new EdgeInsets.all(8),
                  reverse: true,
                  itemBuilder: (_, int index) {
                    final message = messages[index];
                    print('index $index');
                    print('Length ${messages.length}');
                    // if (index == 0) {
                    //   print("YES");
                    //   var msg = ChatMessageWithAnimation(
                    //     child: ChatMessage(
                    //       message: message,
                    //       userId: authState is AuthAuthenticated
                    //           ? authState.userId
                    //           : null,
                    //     ),
                    //     animationController: new AnimationController(
                    //         vsync: this,
                    //         duration: new Duration(milliseconds: 700)),
                    //   );
                    //   msg.animationController.forward();
                    //   return msg;
                    // }

                    return ChatMessage(
                      message: message,
                      userId: authState is AuthAuthenticated
                          ? authState.userId
                          : null,
                    );
                  },
                  itemCount: messages.length,
                );

                return Column(
                  children: <Widget>[
                    Flexible(
                      child: listBuilder,
                    ),
                    new Divider(height: 1),
                    new Container(
                      decoration:
                          new BoxDecoration(color: Theme.of(context).cardColor),
                      child: _buildTextComposer(authState is AuthAuthenticated
                          ? authState.userId
                          : null),
                    ),
                  ],
                );
              }),
              decoration: Theme.of(context).platform == TargetPlatform.iOS
                  ? new BoxDecoration(
                      border:
                          Border(top: new BorderSide(color: Colors.grey[200])))
                  : null,
            );
          }
          return Container();
        }));
  }

  Widget _buildTextComposer(String senderId) {
    final ChatBloc chatBloc = BlocProvider.of<ChatBloc>(context);

    return new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? new CupertinoButton(
                      child: new Text("Send"),
                      onPressed: _isComposing
                          ? () {
                              chatBloc.add(SendChatMessage(
                                  widget.group.id,
                                  Message(_textController.text,
                                      senderId: senderId)));
                              _handleSubmitted(_textController.text);
                            }
                          : null)
                  : new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: _isComposing
                          ? () {
                              chatBloc.add(SendChatMessage(
                                  widget.group.id,
                                  Message(_textController.text,
                                      senderId: senderId)));
                              _handleSubmitted(_textController.text);
                            }
                          : null),
            )
          ],
        ));
  }

  void _handleSubmitted(String value) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    // ChatMessageWithAnimation message = new ChatMessageWithAnimation(
    //   text: value,
    //   animationController: new AnimationController(
    //       vsync: this, duration: new Duration(milliseconds: 700)),
    // );
    // message.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatMessageWithAnimation message in _messages) //new
      message.animationController.dispose();
    super.dispose();
  }
}
