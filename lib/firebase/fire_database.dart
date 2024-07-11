import 'dart:io';

import 'package:ace_chat_app/firebase/fire_storage.dart';
import 'package:ace_chat_app/models/group_model.dart';
import 'package:ace_chat_app/models/message_model.dart';
import 'package:ace_chat_app/models/room_model.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:ace_chat_app/services/send_notification.dart';
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
          lastMessage: 'Send your first message',
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
    required String token,
    required String sender,
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

    PushNotificationService().sendNotification(
      token: token,
      sender: sender,
      msg: type ?? msg,
    );
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
          .delete();
    }

    if (selectedMessages.contains(messages.first.id)) {
      await fireStore.collection('rooms').doc(roomId).update({
        'last_message': messages.length == selectedMessages.length
            ? 'Send your first message'
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

  ////////Group

  Future createGroup(
      {required String name,
      required List members,
      required String imgPath}) async {
    members.add(myId);
    String groupId = const Uuid().v1();
    String img = '';
    if (imgPath.isNotEmpty) {
      img = await FireStorage()
          .updateGroupPic(file: File(imgPath), groupId: groupId, newG: true);
    }
    GroupModel newGroup = GroupModel(
      id: groupId,
      name: name,
      img: img,
      members: members,
      admins: [myId],
      lastMessage: 'New group created',
      lastMessageTime: now,
      createdAt: now,
    );

    await fireStore.collection('groups').doc(groupId).set(newGroup.toJson());
  }

  Future sendGroupMessage({
    required String msg,
    required String groupId,
    String? type,
    required List groupMembers,
    required String sender,
    required String gName,
  }) async {
    List<UserModel> users = [];
    groupMembers = groupMembers
        .where(
          (element) => element != myId,
        )
        .toList();
    fireStore.collection('users').where('id', whereIn: groupMembers).get().then(
          (value) => users.addAll(
            value.docs.map(
              (e) => UserModel.fromJson(e.data()),
            ),
          ),
        );
    String msgId = const Uuid().v1();
    MessageModel newMessage = MessageModel(
      id: msgId,
      fromId: myId,
      toId: 'group',
      msg: msg,
      createdAt: now,
      type: type ?? 'text',
      read: false,
    );
    await fireStore
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .doc(msgId)
        .set(newMessage.toJson());

    await fireStore.collection('groups').doc(groupId).update({
      'last_message': type ?? msg,
      'last_message_time': now,
    });

    for (var user in users) {
      PushNotificationService().sendNotification(
        token: user.pushToken,
        sender: sender,
        msg: type ?? msg,
        groupName: gName,
      );
    }
  }

  Future deleteGroupMessage({
    required String groupId,
    required List selectedMessages,
    required List<MessageModel> messages,
  }) async {
    for (var msg in selectedMessages) {
      await fireStore
          .collection('groups')
          .doc(groupId)
          .collection('messages')
          .doc(msg)
          .delete();
    }

    if (selectedMessages.contains(messages.first.id)) {
      await fireStore.collection('groups').doc(groupId).update({
        'last_message': messages.length == selectedMessages.length
            ? 'New group created'
            : messages.first.type == 'text'
                ? messages[1].msg
                : messages[1].type,
      });
      String groupTime = '';
      await fireStore.collection('groups').doc(groupId).get().then((value) {
        RoomModel data = RoomModel.fromJson(value.data());
        groupTime = data.createdAt;
      });

      await fireStore.collection('rooms').doc(groupId).update({
        'last_message_time': messages.length == selectedMessages.length
            ? groupTime
            : messages[1].createdAt
      });
    }
  }

  Future editGroup({
    required String groupId,
    required String name,
    required List members,
  }) async {
    await fireStore
        .collection('groups')
        .doc(groupId)
        .update({'name': name, 'members': FieldValue.arrayUnion(members)});
  }

  Future removeMember({
    required String groupId,
    required String member,
    required bool admin,
  }) async {
    await fireStore.collection('groups').doc(groupId).update({
      'members': FieldValue.arrayRemove([member])
    });
    if (admin) {
      removeAdmin(groupId: groupId, member: member);
    }
  }

  Future addAdmin({
    required String groupId,
    required String member,
  }) async {
    await fireStore.collection('groups').doc(groupId).update({
      'admins': FieldValue.arrayUnion([member])
    });
  }

  Future removeAdmin({
    required String groupId,
    required String member,
  }) async {
    await fireStore.collection('groups').doc(groupId).update({
      'admins': FieldValue.arrayRemove([member])
    });
  }

  Future editProfile({
    required String name,
    required String about,
  }) async {
    await fireStore
        .collection('users')
        .doc(myId)
        .update({'name': name, 'about': about});
  }
}
