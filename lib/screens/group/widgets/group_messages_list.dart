import 'package:ace_chat_app/screens/group/widgets/group_chat_bubble.dart';
import 'package:flutter/material.dart';

class GroupChatMessages extends StatelessWidget {
  const GroupChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: 10,
        itemBuilder: (context, index) => index % 2 == 0
            ? const GroupChatBubble()
            : GroupChatBubble2(seen: index % 3 == 0 ? true : false),
      ),
    );
  }
}
