import 'package:ace_chat_app/widgets/chat_card.dart';
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
    );
  }
}
