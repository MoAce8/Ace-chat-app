import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:ace_chat_app/screens/chat/widgets/chat_bubble.dart';
import 'package:ace_chat_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key, required this.roomId, required this.user})
      : super(key: key);
  final String roomId;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('rooms')
              .doc(roomId)
              .collection('messages')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MessageModel> messages = snapshot.data!.docs
                  .map((e) => MessageModel.fromJson(e.data()))
                  .toList();
              return ListView.builder(
                reverse: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => index % 2 == 0
                    ? ChatBubble(
                        msg: messages[index],
                      )
                    : ChatBubble2(
                        msg: messages[index],
                        seen: index % 3 == 0 ? true : false),
              );
            } else {
              return const LoadingIndicator();
            }
          }),
    );
  }
}
