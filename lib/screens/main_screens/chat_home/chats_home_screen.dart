import 'package:ace_chat_app/models/room_model.dart';
import 'package:ace_chat_app/screens/main_screens/chat_home/new_chat_sheet.dart';
import 'package:ace_chat_app/screens/main_screens/chat_home/widgets/chat_card.dart';
import 'package:ace_chat_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('rooms')
              .where('members',
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<RoomModel> rooms = snapshot.data!.docs
                  .map((e) => RoomModel.fromJson(e.data()))
                  .toList()
                ..sort(
                  (a, b) => b.lastMessageTime.compareTo(a.lastMessageTime),
                );
              return ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) => ChatCard(room: rooms[index]),
              );
            } else {
              return const LoadingIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
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
