import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text(user.name),
          ),
      body: Column(
        children: [
          widget.user.image.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: NetworkImage(widget.user.image),
                  radius: 70,
                )
              : const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.png'),
                  radius: 70,
                ),
          SizedBox(
            height: screenHeight(context) * .02,
          ),
          Text(
            widget.user.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: screenHeight(context) * .005,
          ),
          Text(
            widget.user.email,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: screenHeight(context) * .01,
          ),
          Container(
            color: Colors.black,
            width: double.infinity,
            height: screenHeight(context) * .01,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) * .025,
                  vertical: screenHeight(context) * .02,
                ),
                child: SizedBox(
                  width: screenWidth(context)*.95,
                  child: Text(widget.user.about,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      maxLines: 5,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.black,
            width: double.infinity,
            height: screenHeight(context) * .01,
          ),
          SizedBox(
            height: screenHeight(context) * .01,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                List contacts = snapshot.data!.data()!['contacts'];
                return ListTile(
                  title: Text(contacts.contains(widget.user.id)
                      ? 'Friends on Ace chat'
                      : 'Add friend'),
                  trailing: contacts.contains(widget.user.id)
                      ? const Icon(Icons.check)
                      : IconButton(
                          onPressed: () {
                            FireData().addContact(email: widget.user.email);
                          },
                          icon: const Icon(Icons.person_add),
                        ),
                );
              })
        ],
      ),
    );
  }
}
