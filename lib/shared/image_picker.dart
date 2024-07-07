import 'dart:async';
import 'dart:io';

import 'package:ace_chat_app/firebase/fire_storage.dart';
import 'package:image_picker/image_picker.dart';

pickFromGallery({
  required String roomId,
  required String userId,
  required String token,
  required String sender,
}) async {
  final ImagePicker picker = ImagePicker();
  XFile? file = await picker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    FireStorage().sendImage(
      file: File(file.path),
      roomId: roomId,
      userId: userId,
      token: token,
      sender: sender,
    );
  }
}

pickFromGalleryGroup({
  required String groupId,
}) async {
  final ImagePicker picker = ImagePicker();
  XFile? file = await picker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    FireStorage().sendGImage(file: File(file.path), groupId: groupId);
  }
}

pickFromCamera() async {
  final ImagePicker picker = ImagePicker();
  XFile? file = await picker.pickImage(source: ImageSource.camera);
  if (file != null) {
    return await file.readAsBytes();
  }
}

Future<String> pickProfilePic() async {
  final ImagePicker picker = ImagePicker();
  XFile? file = await picker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    String path = await FireStorage().updateProfilePic(file: File(file.path));
    return path;
  }
  return '';
}
