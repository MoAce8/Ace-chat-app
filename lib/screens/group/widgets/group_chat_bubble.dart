import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupChatBubble extends StatelessWidget {
  const GroupChatBubble({
    Key? key,
    required this.msg,
    required this.groupId,
    required this.selected,
  }) : super(key: key);
  final MessageModel msg;
  final String groupId;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    bool isMe = msg.fromId == FirebaseAuth.instance.currentUser!.uid;
    return Container(
      color: selected ? Colors.blueGrey : Colors.transparent,
      margin: const EdgeInsets.all(1),
      child: Align(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isMe
                  ? const SizedBox()
                  : const Text(
                      'Mohammed',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                      ),
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  msg.type == 'text'
                      ? Text(
                          msg.msg,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      : CachedNetworkImage(
                          imageUrl: msg.msg,
                          placeholder: (context, url) => const LoadingIndicator(),
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
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              size: 18,
                            )
                          ],
                        )
                      : Text(
                          '13:07',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
