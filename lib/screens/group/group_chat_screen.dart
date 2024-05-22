import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/models/group_model.dart';
import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/screens/chat/widgets/no_messages.dart';
import 'package:ace_chat_app/screens/group/group_members/group_members_screen.dart';
import 'package:ace_chat_app/screens/group/widgets/group_messages_list.dart';
import 'package:ace_chat_app/shared/image_picker.dart';
import 'package:ace_chat_app/widgets/custom_text_field.dart';
import 'package:ace_chat_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({Key? key, required this.group}) : super(key: key);
  final GroupModel group;

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  TextEditingController messageCont = TextEditingController();
  ScrollController scroller = ScrollController();
  List<MessageModel> messages = [];
  List selectedMsg = [];
  List copiedMsg = [];
  List receivedMsg = [];

  @override
  Widget build(BuildContext context) {
    int ln = widget.group.name.length;

    return Scaffold(
      appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MembersScreen(),
                  ));
            },
            child: Row(
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
                          ? '${widget.group.name.substring(0, 10)}...'
                          : ln <= 20
                              ? widget.group.name
                              : '${widget.group.name.substring(0, 20)}...',
                    ),
                    Text(
                      'Mohammed, Tharwat, Ace',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            selectedMsg.isNotEmpty
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      receivedMsg.isEmpty
                          ? IconButton(
                              onPressed: () {
                                FireData()
                                    .deleteGroupMessage(
                                      groupId: widget.group.id,
                                      selectedMessages: selectedMsg,
                                      messages: messages,
                                    )
                                    .then((value) => setState(() {
                                          selectedMsg.clear();
                                          copiedMsg.clear();
                                          receivedMsg.clear();
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
                                  receivedMsg.clear();
                                });
                              },
                              icon: const Icon(Icons.copy),
                            )
                          : const SizedBox(),
                    ],
                  )
                : const SizedBox(),
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('groups')
                    .doc(widget.group.id)
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
                        ? GroupChatMessages(
                            groupId: widget.group.id,
                            messages: messages,
                            scroller: scroller,
                            callback: (selected, received, copied) =>
                                setState(() {
                              selectedMsg = selected;
                              copiedMsg = copied;
                              receivedMsg = received;
                            }),
                          )
                        : EmptyChat(
                            onTap: () {
                              FireData().sendGroupMessage(
                                  msg: 'Hi 👋', groupId: widget.group.id);
                            },
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
                        onPressed: () {
                          pickFromGalleryGroup(groupId: widget.group.id);
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
                          .sendGroupMessage(
                        msg: messageCont.text.trim(),
                        groupId: widget.group.id,
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
