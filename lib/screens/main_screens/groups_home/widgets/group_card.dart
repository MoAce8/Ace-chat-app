import 'package:ace_chat_app/models/group_model.dart';
import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/screens/group/group_chat_screen.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({Key? key, required this.group}) : super(key: key);
  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupChatScreen(group: group),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: group.img.isNotEmpty
              ? CircleAvatar(
            backgroundImage: NetworkImage(group.img),
          )
              : const CircleAvatar(
            backgroundImage:
            AssetImage('assets/images/group.png'),
          ),
          title: Text(
            group.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            group.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateTime.fromMillisecondsSinceEpoch(
                        int.parse(group.lastMessageTime))
                    .toString(),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('groups')
                      .doc(group.id)
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
  }
}
