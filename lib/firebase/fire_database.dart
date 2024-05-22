import 'package:ace_chat_app/models/group_model.dart';
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
  final String now = DateTime.now().millisecondsSinceEpoch.toString();

  Future createRoom(BuildContext context, {required String email}) async {
    QuerySnapshot friend = await fireStore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (friend.docs.isNotEmpty) {
      String friendId = friend.docs.first.id;

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
          lastMessage: 'You started a chat',
          lastMessageTime: now,
          createdAt: now,
        );

        await fireStore
            .collection('rooms')
            .doc(members.toString())
            .set(newRoom.toJson());
      }
    } else {
      showSnackBar(context, 'User not found');
    }
  }

  Future createGroup({required String name, required List members}) async {
    members.add(myId);
    String groupId = const Uuid().v1();
    GroupModel newGroup = GroupModel(
      id: groupId,
      name: name,
      img: '',
      members: members,
      admins: [myId],
      lastMessage: 'You created a group',
      lastMessageTime: now,
      createdAt: now,
    );

    await fireStore.collection('groups').doc(groupId).set(newGroup.toJson());
  }

  Future addContact({required String email}) async {
    QuerySnapshot friend = await fireStore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (friend.docs.isNotEmpty) {
      fireStore.collection('users').doc(myId).update({
        'contacts': FieldValue.arrayUnion([friend.docs.first.id])
      });
    }
  }

  Future sendMessage({
    required String userId,
    required String msg,
    required String roomId,
    String? type,
  }) async {
    String msgId = const Uuid().v1();
    if (userId == myId) {
      userId = '';
    }
    MessageModel newMessage = MessageModel(
      id: msgId,
      fromId: myId,
      toId: userId,
      msg: msg,
      createdAt: now,
      type: type ?? 'text',
      read: false,
    );
    await fireStore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .set(newMessage.toJson());

    await fireStore.collection('rooms').doc(roomId).update({
      'last_message': type ?? msg,
      'last_message_time': now,
    });
  }

  Future readMessages({
    required String roomId,
    required String msgId,
  }) async {
    await fireStore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .update({'read': true});
  }

  Future deleteMessage({
    required String roomId,
    required List selectedMessages,
    required List<MessageModel> messages,
  }) async {
    for (var msg in selectedMessages) {
      await fireStore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .doc(msg)
          .delete()
          .then((value) {});
    }

    if (selectedMessages.contains(messages.first.id)) {
      await fireStore.collection('rooms').doc(roomId).update({
        'last_message': messages.length == selectedMessages.length
            ? 'You started a chat'
            : messages.first.type == 'text'
                ? messages[1].msg
                : messages[1].type,
      });
      String roomTime = '';
      await fireStore.collection('rooms').doc(roomId).get().then((value) {
        RoomModel data = RoomModel.fromJson(value.data());
        roomTime = data.createdAt;
      });

      await fireStore.collection('rooms').doc(roomId).update({
        'last_message_time': messages.length == selectedMessages.length
            ? roomTime
            : messages[1].createdAt
      });
    }
  }
}
