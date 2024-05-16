import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.msg,
  }) : super(key: key);
  final MessageModel msg;

  @override
  Widget build(BuildContext context) {
    bool isMe = msg.fromId == FirebaseAuth.instance.currentUser!.uid;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        constraints: BoxConstraints(maxWidth: screenWidth(context) * .6),
        decoration: BoxDecoration(
            color: isMe ? Colors.teal : kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
              bottomRight: isMe ? Radius.zero : const Radius.circular(16),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msg.msg,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            isMe
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(
                                int.parse(msg.createdAt))
                            .toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        msg.read
                            ? Icons.check_circle_outline
                            : Icons.check_circle,
                        size: 18,
                      )
                    ],
                  )
                : Text(
                    '12:01',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
          ],
        ),
      ),
    );
  }
}
