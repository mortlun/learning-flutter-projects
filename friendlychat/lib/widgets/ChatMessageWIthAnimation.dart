import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

class ChatMessageWithAnimation extends StatelessWidget {
  ChatMessageWithAnimation({this.text, this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        child: null);
  }
}
