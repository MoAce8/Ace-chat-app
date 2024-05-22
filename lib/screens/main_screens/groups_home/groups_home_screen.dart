import 'package:ace_chat_app/models/group_model.dart';
import 'package:ace_chat_app/screens/group/create_group/create_group.dart';
import 'package:ace_chat_app/screens/main_screens/groups_home/widgets/group_card.dart';
import 'package:ace_chat_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupsHomeScreen extends StatelessWidget {
  const GroupsHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
        surfaceTintColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('groups')
            .where('members',
            arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GroupModel> groups = snapshot.data!.docs
                .map((e) => GroupModel.fromJson(e.data()))
                .toList()
              ..sort(
                    (a, b) => b.lastMessageTime.compareTo(a.lastMessageTime),
              );
            return ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) => GroupCard(group: groups[index]),
            );
          }else{
            return const LoadingIndicator();
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateGroupScreen(),
              ));
        },
        child: const Icon(Icons.group_add),
      ),
    );
  }
}
