import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/screens/chat/widgets/chat_bubble.dart';
import 'package:ace_chat_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final Function(List selected, List received, List copied) callback;

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  List selectedMsg = [];
  List userSelectedMsg = [];
  List copiedMsg = [];
  String uid = FirebaseAuth.instance.currentUser!.uid;

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

                      if (messages[index].toId == uid) {
                        userSelectedMsg.contains(messages[index].id)
                            ? userSelectedMsg.remove(messages[index].id)
                            : userSelectedMsg.add(messages[index].id);
                      }

                      if (messages[index].type == 'text') {
                        copiedMsg.contains(messages[index].msg)
                            ? copiedMsg.remove(messages[index].msg)
                            : copiedMsg.add(messages[index].msg);
                      }
                    });
                    widget.callback(selectedMsg, userSelectedMsg, copiedMsg);
                  },
                  onTap: () {
                    setState(() {
                      if (selectedMsg.isNotEmpty) {
                        selectedMsg.contains(messages[index].id)
                            ? selectedMsg.remove(messages[index].id)
                            : selectedMsg.add(messages[index].id);

                        if (messages[index].toId == uid) {
                          userSelectedMsg.contains(messages[index].id)
                              ? userSelectedMsg.remove(messages[index].id)
                              : userSelectedMsg.add(messages[index].id);
                        }

                        if (messages[index].type == 'text') {
                          copiedMsg.contains(messages[index].msg)
                              ? copiedMsg.remove(messages[index].msg)
                              : copiedMsg.add(messages[index].msg);
                        }
                      }
                    });
                    widget.callback(selectedMsg, userSelectedMsg, copiedMsg);
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
