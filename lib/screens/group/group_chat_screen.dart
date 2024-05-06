import 'package:ace_chat_app/screens/chat/widgets/no_messages.dart';
import 'package:ace_chat_app/screens/group/group_members/group_members_screen.dart';
import 'package:ace_chat_app/screens/group/widgets/group_messages_list.dart';
import 'package:ace_chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({Key? key}) : super(key: key);

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  TextEditingController messageCont = TextEditingController();
  bool empty = false;

  @override
  Widget build(BuildContext context) {
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
                  const Text('Group Name'),
                  Text(
                    'Mohammed, Tharwat, Ace',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            empty ? const EmptyChat() : const GroupChatMessages(),
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
                        onPressed: () {},
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
                  onPressed: () {},
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
