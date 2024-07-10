import 'package:ace_chat_app/screens/group/widgets/group_chat_bubble.dart';
import 'package:ace_chat_app/shared/date_time.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupChatMessages extends StatefulWidget {
  const GroupChatMessages({
    Key? key,
    required this.groupId,
    required this.messages,
    required this.scroller,
    required this.callback,
  }) : super(key: key);
  final String groupId;
  final List messages;
  final ScrollController scroller;
  final Function(List selected, List received, List copied) callback;

  @override
  State<GroupChatMessages> createState() => _GroupChatMessagesState();
}

class _GroupChatMessagesState extends State<GroupChatMessages> {
  List selectedMsg = [];
  List userSelectedMsg = [];
  List copiedMsg = [];
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: widget.messages.length,
        itemBuilder: (context, index) {
          String newDate;
          if ((index == 0 && widget.messages.length == 1) ||
              index == widget.messages.length - 1) {
            newDate = DateTimeFormatting.dateAndTime(
                time: widget.messages[index].createdAt, lastSeen: false);
          } else {
            final DateTime date = DateTimeFormatting.dateFormatter(
                widget.messages[index].createdAt);
            final DateTime preDate = DateTimeFormatting.dateFormatter(
                widget.messages[index + 1].createdAt);

            bool isSameDate = date.isAtSameMomentAs(preDate);
            newDate = isSameDate
                ? ''
                : DateTimeFormatting.dateAndTime(
                time: widget.messages[index].createdAt, lastSeen: false);
          }

          return Column(
            children: [
              if (newDate.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[900]
                  ),
                  child: Text(newDate),
                ),
              GestureDetector(
              onLongPress: () {
                setState(() {
                  selectedMsg.contains(widget.messages[index].id)
                      ? selectedMsg.remove(widget.messages[index].id)
                      : selectedMsg.add(widget.messages[index].id);

                  if (widget.messages[index].fromId != uid) {
                    userSelectedMsg.contains(widget.messages[index].id)
                        ? userSelectedMsg.remove(widget.messages[index].id)
                        : userSelectedMsg.add(widget.messages[index].id);
                  }

                  if (widget.messages[index].type == 'text') {
                    copiedMsg.contains(widget.messages[index].msg)
                        ? copiedMsg.remove(widget.messages[index].msg)
                        : copiedMsg.add(widget.messages[index].msg);
                  }
                });
                widget.callback(selectedMsg, userSelectedMsg, copiedMsg);
              },
              onTap: () {
                setState(() {
                  if (selectedMsg.isNotEmpty) {
                    selectedMsg.contains(widget.messages[index].id)
                        ? selectedMsg.remove(widget.messages[index].id)
                        : selectedMsg.add(widget.messages[index].id);

                    if (widget.messages[index].fromId == uid) {
                      userSelectedMsg.contains(widget.messages[index].id)
                          ? userSelectedMsg.remove(widget.messages[index].id)
                          : userSelectedMsg.add(widget.messages[index].id);
                    }

                    if (widget.messages[index].type == 'text') {
                      copiedMsg.contains(widget.messages[index].msg)
                          ? copiedMsg.remove(widget.messages[index].msg)
                          : copiedMsg.add(widget.messages[index].msg);
                    }
                  }
                });
                widget.callback(selectedMsg, userSelectedMsg, copiedMsg);
              },
              child: GroupChatBubble(
                groupId: widget.groupId,
                msg: widget.messages[index],
                selected: selectedMsg.contains(widget.messages[index].id),
              ),
                      ),
            ],
          );
        },
      ),
    );
  }
}
