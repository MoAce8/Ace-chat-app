import 'dart:io';

import 'package:ace_chat_app/firebase/fire_database.dart';
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
}
