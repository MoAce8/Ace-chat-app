import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/screens/chat/widgets/chat_bubble.dart';
import 'package:ace_chat_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({
    Key? key,
    required this.roomId,
    required this.scroller,
    required this.callback,
  }) : super(key: key);
  final String roomId;
  final ScrollController scroller;
  final Function(List list) callback;

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  List selectedMsg = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('rooms')
              .doc(widget.roomId)
              .collection('messages')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MessageModel> messages = snapshot.data!.docs
                  .map((e) => MessageModel.fromJson(e.data()))
                  .toList()
                ..sort(
                  (a, b) => b.createdAt.compareTo(a.createdAt),
                );
              return ListView.builder(
                reverse: true,
                controller: widget.scroller,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => GestureDetector(
                  onLongPress: () {
                    setState(() {
                      selectedMsg.contains(messages[index].id)
                          ? selectedMsg.remove(messages[index].id)
                          : selectedMsg.add(messages[index].id);
                    });
                    widget.callback(selectedMsg);
                  },
                  onTap: () {
                    setState(() {
                      if (selectedMsg.isNotEmpty) {
                        selectedMsg.contains(messages[index].id)
                            ? selectedMsg.remove(messages[index].id)
                            : selectedMsg.add(messages[index].id);
                      }
                    });
                    widget.callback(selectedMsg);
                  },
                  child: ChatBubble(
                    roomId: widget.roomId,
                    msg: messages[index],
                    selected: selectedMsg.contains(messages[index].id),
                  ),
                ),
              );
            } else {
              return const LoadingIndicator();
            }
          }),
    );
  }
}
