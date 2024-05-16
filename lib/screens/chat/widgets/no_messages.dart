import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

class EmptyChat extends StatelessWidget {
  const EmptyChat({Key? key, required this.roomId, required this.user}) : super(key: key);
  final String roomId;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: GestureDetector(
        onTap: () {
          FireData().sendMessage(userId: user.id, msg: 'Hi 👋', roomId: roomId);
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '👋',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'No messages yet...',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Try saying Hi',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
