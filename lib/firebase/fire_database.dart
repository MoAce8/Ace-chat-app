import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/models/room_model.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FireData {
  final String myId = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future createRoom(BuildContext context, {required String email}) async {
    QuerySnapshot friend = await fireStore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (friend.docs.isNotEmpty) {
      String friendId = friend.docs.first.id;
      if (friendId != myId) {
        List<String> members = [myId, friendId]..sort(
            (a, b) => a.compareTo(b),
          );

        QuerySnapshot roomExist = await fireStore
            .collection('rooms')
            .where('members', isEqualTo: members)
            .get();

        if (roomExist.docs.isEmpty) {
          RoomModel newRoom = RoomModel(
            id: members.toString(),
            members: members,
            lastMessage: 'lastMessage',
            lastMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
            createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
          );

          await fireStore
              .collection('rooms')
              .doc(members.toString())
              .set(newRoom.toJson());
        }
      } else {
        showSnackBar(context, 'Why do you wanna text yourself??');
      }
    } else {
      showSnackBar(context, 'User not found');
    }
  }

  Future sendMessage({
    required String userId,
    required String msg,
    required String roomId,
    String? type,
  }) async {
    String msgId = const Uuid().v1();
    MessageModel newMessage = MessageModel(
      id: msgId,
      fromId: myId,
      toId: userId,
      msg: msg,
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type ?? 'text',
      read: true,
    );
    await fireStore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .set(newMessage.toJson());
  }
}
