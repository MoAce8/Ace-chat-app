import 'dart:io';

import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  final FirebaseStorage fireStorage = FirebaseStorage.instance;

  sendImage({
    required File file,
    required String roomId,
    required String userId,
    required String token,
    required String sender,
  }) async {
    String ext = file.path.split('.').last;

    final ref = fireStorage
        .ref()
        .child('images/$roomId/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref.putFile(file);

    String imageUrl = await ref.getDownloadURL();
    FireData().sendMessage(
      userId: userId,
      msg: imageUrl,
      roomId: roomId,
      type: 'image',
      token: token,
      sender: sender,
    );
  }

  sendGImage({
    required File file,
    required String groupId,
    required String sender,
    required List groupMembers,
    required String gName,
  }) async {
    String ext = file.path.split('.').last;

    final ref = fireStorage
        .ref()
        .child('images/$groupId/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref.putFile(file);

    String imageUrl = await ref.getDownloadURL();
    FireData().sendGroupMessage(
      msg: imageUrl,
      groupId: groupId,
      type: 'image',
      sender: sender,
      groupMembers: groupMembers,
      gName: gName,
    );
  }

  Future<String> updateProfilePic({
    required File file,
  }) async {
    String myId = FirebaseAuth.instance.currentUser!.uid;
    String ext = file.path.split('.').last;

    final ref = fireStorage
        .ref()
        .child('profile/$myId/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref.putFile(file);

    String imageUrl = await ref.getDownloadURL();
    print('****************************');
    print(imageUrl);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .update({'image': imageUrl});
    return imageUrl;
  }

  Future<String> updateGroupPic({
    required File file,
    required String groupId,
    bool? newG,
  }) async {
    String ext = file.path.split('.').last;

    final ref = fireStorage.ref().child(
        'groups/$groupId/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref.putFile(file);

    String imageUrl = await ref.getDownloadURL();
    print(imageUrl);
    if (newG == null || !newG) {
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupId)
          .update({'image': imageUrl});
      return imageUrl;
    }else{
      return imageUrl;
    }
  }
}
