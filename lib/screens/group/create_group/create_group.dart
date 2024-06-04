import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/models/user_model.dart';
import 'package:ace_chat_app/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController gName = TextEditingController();
  List members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
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
                const Text('Members'),
                Text(members.length.toString()),
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
                      List myContacts = users
                          .where((element) => contacts.contains(element.id))
                          .where((element) =>
                              element.id !=
                              FirebaseAuth.instance.currentUser!.uid)
                          .toList()
                        ..sort(
                          (a, b) => a.name
                              .toLowerCase()
                              .compareTo(b.name.toLowerCase()),
                        );
                      return ListView.builder(
                        itemCount: myContacts.length,
                        itemBuilder: (context, index) => CheckboxListTile(
                          title: Text(myContacts[index].name),
                          checkboxShape: const CircleBorder(),
                          value: members.contains(myContacts[index].id),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                members.add(myContacts[index].id);
                              } else {
                                members.remove(myContacts[index].id);
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
      floatingActionButton: members.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                if (gName.text.trim().isNotEmpty) {
                  FireData()
                      .createGroup(name: gName.text, members: members)
                      .then((value) => Navigator.pop(context));
                }
              },
              label: const Text('Done'),
              icon: const Icon(Icons.check_circle_outline),
            )
          : const SizedBox(),
    );
  }
}
