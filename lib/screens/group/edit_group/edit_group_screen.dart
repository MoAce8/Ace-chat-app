import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/models/group_model.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:ace_chat_app/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditGroupScreen extends StatefulWidget {
  const EditGroupScreen({Key? key, required this.group}) : super(key: key);
  final GroupModel group;

  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  TextEditingController gName = TextEditingController();
  List newMembers = [];

  @override
  void initState() {
    super.initState();
    gName.text = widget.group.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const CircleAvatar(
                    radius: 38,
                    child: Icon(
                      Icons.add_a_photo_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: AppTextFormField(
                    label: 'Group Name',
                    controller: gName,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            const Divider(),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Add Members'),
                Text(newMembers.length.toString()),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserModel> users = snapshot.data!.docs
                          .map((e) => UserModel.fromJson(e.data()))
                          .toList();
                      List contacts = users
                          .where((element) =>
                              element.id ==
                              FirebaseAuth.instance.currentUser!.uid)
                          .first
                          .contacts;
                      List availableContacts = users
                          .where((element) => contacts.contains(element.id))
                          .where((element) =>
                              element.id !=
                              FirebaseAuth.instance.currentUser!.uid)
                          .where((element) =>
                              !widget.group.members.contains(element.id))
                          .toList()
                        ..sort(
                          (a, b) => a.name
                              .toLowerCase()
                              .compareTo(b.name.toLowerCase()),
                        );
                      return ListView.builder(
                        itemCount: availableContacts.length,
                        itemBuilder: (context, index) => CheckboxListTile(
                          title: Text(availableContacts[index].name),
                          checkboxShape: const CircleBorder(),
                          value:
                              newMembers.contains(availableContacts[index].id),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                newMembers.add(availableContacts[index].id);
                              } else {
                                newMembers.remove(availableContacts[index].id);
                              }
                            });
                          },
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          FireData()
              .editGroup(
                  groupId: widget.group.id,
                  name: gName.text.trim(),
                  members: newMembers)
              .then((value) =>
                  Navigator.popUntil(context, (route) => route.isFirst));
        },
        label: const Text('Done'),
        icon: const Icon(Icons.check_circle_outline),
      ),
    );
  }
}
