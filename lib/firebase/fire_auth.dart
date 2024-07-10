import 'package:ace_chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static User currentUser = auth.currentUser!;

  static Future createUser({required String name}) async {
    UserModel newUser = UserModel(
      id: currentUser.uid,
      name: name,
      email: currentUser.email!,
      image: '',
      about: 'Hey, I\'m using Ace chat',
      lastSeen: DateTime.now().millisecondsSinceEpoch.toString(),
      pushToken: '',
      online: false,
      contacts: [],
    );
    await fireStore
        .collection('users')
        .doc(currentUser.uid)
        .set(newUser.toJson());
  }

  Future updateToken(String token) async {
    await fireStore
        .collection('users')
        .doc(currentUser.uid)
        .update({'push_token': token});
  }

  Future updateOnline(bool online) async {
    await fireStore.collection('users').doc(currentUser.uid).update({
      'online': online,
      'last_seen': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }
}
