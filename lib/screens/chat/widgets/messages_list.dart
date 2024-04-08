import 'package:ace_chat_app/screens/chat/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: 10,
        itemBuilder: (context, index) => index % 2 == 0
            ? ChatBubble()
            : ChatBubble2(seen: index % 3 == 0 ? true : false),
      ),
    );
  }
}
