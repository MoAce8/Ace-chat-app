import 'package:ace_chat_app/screens/main_screens/chat_home/new_chat_sheet.dart';
import 'package:ace_chat_app/screens/main_screens/chat_home/widgets/chat_card.dart';
import 'package:flutter/material.dart';

class ChatsHomeScreen extends StatelessWidget {
  const ChatsHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) => const ChatCard(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                )),
            context: context,
            builder: (context) => const NewChatSheet(),
          );
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
