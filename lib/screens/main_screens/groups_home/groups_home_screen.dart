import 'package:ace_chat_app/screens/main_screens/groups_home/widgets/group_card.dart';
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
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) => const GroupCard(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.group_add),
      ),
    );
  }
}
