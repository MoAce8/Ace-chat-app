import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:ace_chat_app/screens/chat/widgets/messages_list.dart';
import 'package:ace_chat_app/screens/chat/widgets/no_messages.dart';
import 'package:ace_chat_app/shared/image_picker.dart';
import 'package:ace_chat_app/widgets/custom_text_field.dart';
import 'package:ace_chat_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.roomId, required this.user})
      : super(key: key);
  final String roomId;
  final UserModel user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageCont = TextEditingController();
  ScrollController scroller = ScrollController();
  bool empty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.name),
                Text(
                  'Last seen ${DateTime.fromMillisecondsSinceEpoch(int.parse(widget.user.lastSeen)).toString()}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('rooms')
                    .doc(widget.roomId)
                    .collection('messages')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<MessageModel> messages = snapshot.data!.docs
                        .map((e) => MessageModel.fromJson(e.data()))
                        .toList();
                    return messages.isNotEmpty
                        ? ChatMessages(
                            roomId: widget.roomId,
                            scroller: scroller,
                          )
                        : EmptyChat(
                            roomId: widget.roomId,
                            user: widget.user,
                          );
                  } else {
                    return const LoadingIndicator();
                  }
                }),
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    child: AppTextField(
                      label: 'Message',
                      controller: messageCont,
                      suffix: IconButton(
                        onPressed: () async {
                          await pickFromGallery(
                              roomId: widget.roomId, userId: widget.user.id);
                        },
                        icon: const Icon(Icons.attach_file),
                      ),
                      prefix: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.emoji_emotions),
                      ),
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {
                    if (messageCont.text.trim().isNotEmpty) {
                      scroller.jumpTo(0);
                      FireData()
                          .sendMessage(
                        userId: widget.user.id,
                        msg: messageCont.text.trim(),
                        roomId: widget.roomId,
                      )
                          .then((value) {
                        messageCont.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
