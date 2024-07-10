import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/models/room_model.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:ace_chat_app/screens/chat/chat_screen.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/shared/date_time.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({Key? key, required this.room}) : super(key: key);
  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    List members = room.members
        .where((element) => element != FirebaseAuth.instance.currentUser!.uid)
        .toList();
    String userId = members.isEmpty
        ? FirebaseAuth.instance.currentUser!.uid
        : members.first;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel user = UserModel.fromJson(snapshot.data!.data());
            String lastMsgDate = DateTimeFormatting.dateAndTime(
                time: room.lastMessageTime, lastSeen: false);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      roomId: room.id,
                      user: user,
                    ),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: user.image.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(user.image),
                        )
                      : const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/profile.png'),
                        ),
                  title: Text(
                    user.id != FirebaseAuth.instance.currentUser!.uid
                        ? user.name
                        : '(You)',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    room.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        lastMsgDate == 'today'
                            ? DateTimeFormatting.timeFormatter(
                                room.lastMessageTime)
                            : lastMsgDate,
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('rooms')
                              .doc(room.id)
                              .collection('messages')
                              .snapshots(),
                          builder: (context, snapshot) {
                            final unreadList = snapshot.data?.docs
                                .map((e) => MessageModel.fromJson(e.data()))
                                .where((element) => !element.read)
                                .where((element) =>
                                    element.toId ==
                                    FirebaseAuth.instance.currentUser!.uid)
                                .toList();
                            if (snapshot.hasData && unreadList!.isNotEmpty) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kPrimaryColor,
                                ),
                                child: Text(unreadList.length.toString()),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
