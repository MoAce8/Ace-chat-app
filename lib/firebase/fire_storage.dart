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
  }) async {
    String ext = file.path.split('.').last;

    final ref = fireStorage
        .ref()
        .child('images/$roomId/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref.putFile(file);

    String imageUrl = await ref.getDownloadURL();
    FireData().sendMessage(
        userId: userId, msg: imageUrl, roomId: roomId, type: 'image');
  }

  sendGImage({
    required File file,
    required String groupId,
  }) async {
    String ext = file.path.split('.').last;

    final ref = fireStorage
        .ref()
        .child('images/$groupId/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref.putFile(file);

    String imageUrl = await ref.getDownloadURL();
    FireData().sendGroupMessage(msg: imageUrl, groupId: groupId, type: 'image');
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
}
