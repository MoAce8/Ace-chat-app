import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:ace_chat_app/screens/chat/widgets/messages_list.dart';
import 'package:ace_chat_app/screens/chat/widgets/no_messages.dart';
import 'package:ace_chat_app/shared/image_picker.dart';
import 'package:ace_chat_app/widgets/custom_text_field.dart';
import 'package:ace_chat_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  List selectedMsg = [];
  List copiedMsg = [];
  bool showDelete = true;
  List<MessageModel> messages = [];

  @override
  Widget build(BuildContext context) {
    int ln = widget.user.name.length;

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
                Text(
                  ln > 10 && selectedMsg.isNotEmpty
                      ? '${widget.user.name.substring(0, 10)}...'
                      : ln <= 20
                          ? widget.user.name
                          : '${widget.user.name.substring(0, 20)}...',
                ),
                Text(
                  'Last seen '
                  // '${DateTime.fromMillisecondsSinceEpoch(int.parse(widget.user.lastSeen)).toString()}'
                  ,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
        actions: [
          selectedMsg.isNotEmpty
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    showDelete
                        ? IconButton(
                            onPressed: () {
                              FireData()
                                  .deleteMessage(
                                    roomId: widget.roomId,
                                    selectedMessages: selectedMsg,
                                    messages: messages,
                                  )
                                  .then((value) => setState(() {
                                        selectedMsg.clear();
                                        copiedMsg.clear();
                                      }));
                            },
                            icon: const Icon(CupertinoIcons.trash),
                          )
                        : const SizedBox(),
                    copiedMsg.length == selectedMsg.length
                        ? IconButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: copiedMsg.join('\n')));
                              setState(() {
                                selectedMsg.clear();
                                copiedMsg.clear();
                              });
                            },
                            icon: const Icon(Icons.copy),
                          )
                        : const SizedBox(),
                  ],
                )
              : const SizedBox()
        ],
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
                    messages = snapshot.data!.docs
                        .map((e) => MessageModel.fromJson(e.data()))
                        .toList()
                      ..sort(
                        (a, b) => b.createdAt.compareTo(a.createdAt),
                      );
                    return messages.isNotEmpty
                        ? ChatMessages(
                            messages: messages,
                            roomId: widget.roomId,
                            scroller: scroller,
                            callback: (selected, received, copied) =>
                                setState(() {
                              selectedMsg = selected;
                              copiedMsg = copied;
                              showDelete = received.isEmpty;
                            }),
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
                      if (messages.isNotEmpty) {
                        scroller.jumpTo(0);
                      }
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
