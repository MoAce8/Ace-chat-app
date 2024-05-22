import 'package:ace_chat_app/models/group_model.dart';
import 'package:ace_chat_app/screens/group/group_chat_screen.dart';
import 'package:ace_chat_app/shared/constants.dart';
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
            builder: (context) => const GroupChatScreen(),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: const CircleAvatar(),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                ),
                child: const Text('3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
