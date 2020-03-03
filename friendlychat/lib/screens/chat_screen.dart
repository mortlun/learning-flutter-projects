import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/bloc.dart';
import 'package:friendlychat/blocs/chat_bloc/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
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
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Friendlychat"),
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
          if (state is ChatLoaded) {
            final List<Widget> messageTiles = state.messagesLoaded
                .map((message) => ListTile(title: Text(message.content)))
                .toList();
            return Container(
              child: new Column(
                children: <Widget>[
                  new Flexible(
                      child: new ListView.builder(
                    padding: new EdgeInsets.all(8),
                    reverse: true,
                    itemBuilder: (_, int index) => messageTiles[index],
                    itemCount: messageTiles.length,
                  )),
                  new Divider(height: 1),
                  new Container(
                    decoration:
                        new BoxDecoration(color: Theme.of(context).cardColor),
                    child: _buildTextComposer(),
                  ),
                ],
              ),
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

  Widget _buildTextComposer() {
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
                          ? () => _handleSubmitted(_textController.text)
                          : null)
                  : new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null),
            )
          ],
        ));
  }

  void _handleSubmitted(String value) {
    _textController.clear();

    ChatMessageWithAnimation message = new ChatMessageWithAnimation(
      text: value,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 700)),
    );
    setState(() {
      _messages.insert(0, message);
      _isComposing = false;
    });
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatMessageWithAnimation message in _messages) //new
      message.animationController.dispose();
    super.dispose();
  }
}

class ChatMessageWithAnimation extends StatelessWidget {
  ChatMessageWithAnimation({this.text, this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        child: ChatMessage(
          text: text,
        ));
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  ChatMessage({this.text});

  @override
  Widget build(BuildContext context) {
    const String _name = "Morten";
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16),
              child: new CircleAvatar(child: new Text(_name[0])),
            ),
            Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(_name, style: Theme.of(context).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: new Text(text),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
