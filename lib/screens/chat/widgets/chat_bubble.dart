import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/shared/date_time.dart';
import 'package:ace_chat_app/shared/photo_view.dart';
import 'package:ace_chat_app/widgets/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    Key? key,
    required this.msg,
    required this.roomId,
    required this.selected,
  }) : super(key: key);
  final MessageModel msg;
  final String roomId;
  final bool selected;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  void initState() {
    if (widget.msg.toId == FirebaseAuth.instance.currentUser!.uid) {
      FireData().readMessages(roomId: widget.roomId, msgId: widget.msg.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMe = widget.msg.fromId == FirebaseAuth.instance.currentUser!.uid;
    return Container(
      color: widget.selected ? Colors.blueGrey : Colors.transparent,
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget.msg.type == 'text'
                  ? Text(
                      widget.msg.msg,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  : GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhotoViewScreen(url: widget.msg.msg),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.msg.msg,
                        placeholder: (context, url) => const LoadingIndicator(),
                      ),
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
                          DateTimeFormatting.timeFormatter(widget.msg.createdAt),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Icon(
                          widget.msg.read
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
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
      ),
    );
  }
}
