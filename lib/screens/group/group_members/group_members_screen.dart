import 'package:ace_chat_app/screens/group/edit_group/edit_group_screen.dart';
import 'package:flutter/material.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditGroupScreen(),
                  ));
            },
            icon: const Icon(Icons.edit_note),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) => ListTile(
            title: const Text('Name'),
            subtitle: const Text('Admin'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.admin_panel_settings),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
