import 'package:ace_chat_app/models/user_model.dart';
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
        onTap: () {},
        child: ListTile(
          title: Text(
            user.id!=FirebaseAuth.instance.currentUser!.uid?
            user.name:'${user.name} (You)',
          ),
          trailing: const Icon(FontAwesomeIcons.commentDots),
        ),
      ),
    );
  }
}
