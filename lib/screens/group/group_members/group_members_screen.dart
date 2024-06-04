import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/models/group_model.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:ace_chat_app/screens/group/edit_group/edit_group_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({Key? key, required this.group}) : super(key: key);
  final GroupModel group;

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  @override
  Widget build(BuildContext context) {
    String myId = FirebaseAuth.instance.currentUser!.uid;
    bool isAdmin = widget.group.admins.contains(myId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        actions: [
          isAdmin
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditGroupScreen(group: widget.group),
                        ));
                  },
                  icon: const Icon(Icons.edit_note),
                )
              : const SizedBox(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('id', whereIn: widget.group.members)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List users = snapshot.data!.docs
                    .map((e) => UserModel.fromJson(e.data()))
                    .toList()
                  ..sort(
                    (a, b) =>
                        a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                  );
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    bool isUserAdmin =
                        widget.group.admins.contains(users[index].id);
                    return ListTile(
                      title: Text(users[index].name),
                      subtitle: isUserAdmin
                          ? const Text(
                              'Admin',
                              style: TextStyle(color: Colors.teal),
                            )
                          : const SizedBox(),
                      trailing: isAdmin && users[index].id != myId
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    isUserAdmin
                                        ? FireData()
                                            .removeAdmin(
                                                groupId: widget.group.id,
                                                member: users[index].id)
                                            .then((value) => setState(() {
                                                  widget.group.admins
                                                      .remove(users[index].id);
                                                }))
                                        : FireData()
                                            .addAdmin(
                                                groupId: widget.group.id,
                                                member: users[index].id)
                                            .then((value) => setState(() {
                                                  widget.group.admins
                                                      .add(users[index].id);
                                                }));
                                  },
                                  icon: const Icon(Icons.admin_panel_settings),
                                ),
                                IconButton(
                                  onPressed: () {
                                    FireData()
                                        .removeMember(
                                            groupId: widget.group.id,
                                            member: users[index].id,
                                            admin: isUserAdmin)
                                        .then((value) => setState(() {
                                              widget.group.members
                                                  .remove(users[index].id);
                                            }));
                                  },
                                  icon: const Icon(Icons.delete),
                                )
                              ],
                            )
                          : const SizedBox(),
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
