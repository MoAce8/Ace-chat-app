import 'package:ace_chat_app/screens/chat/chat_screen.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatScreen(),
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: const CircleAvatar(),
          title: const Text('Name'),
          subtitle: const Text('Last message'),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('12:30'),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: kPrimaryColor,),
                child: const Text('3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
