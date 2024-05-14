import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.msg,}) : super(key: key);
  final MessageModel msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8,),
        constraints: BoxConstraints(maxWidth: screenWidth(context)*.6),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
             Text(
              msg.msg,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 5,),
            Text(
              msg.createdAt,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble2 extends StatelessWidget {
  const ChatBubble2({Key? key, required this.msg, required this.seen,}) : super(key: key);
  final MessageModel msg;
  final bool seen;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 8, bottom: 8, left: 95, right: 8),
        decoration: const BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
             Text(
              msg.msg,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '13:07',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 4,),
                Icon(seen?Icons.check_circle_outline:Icons.check_circle,size: 18,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
