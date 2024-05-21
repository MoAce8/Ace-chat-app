import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:ace_chat_app/screens/chat/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          List<String> members = [
            user.id,
            FirebaseAuth.instance.currentUser!.uid
          ]..sort(
              (a, b) => a.compareTo(b),
            );
          FireData()
              .createRoom(context, email: user.email)
              .then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatScreen(roomId: members.toString(), user: user),
                  )));
        },
        child: ListTile(
          title: Text(
            user.id != FirebaseAuth.instance.currentUser!.uid
                ? user.name
                : '${user.name} (You)',
          ),
          trailing: const Icon(FontAwesomeIcons.commentDots),
        ),
      ),
    );
  }
}
