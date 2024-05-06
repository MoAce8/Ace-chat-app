import 'package:ace_chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
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
                const Expanded(
                  child: AppTextFormField(label: 'Group Name'),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Members'),
                Text('0'),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  CheckboxListTile(
                    title: const Text('Mohammed'),
                    checkboxShape: const CircleBorder(),
                    value: true,
                    onChanged: (value) {},
                  ),
                  CheckboxListTile(
                    title: const Text('Tharwat'),
                    checkboxShape: const CircleBorder(),
                    value: false,
                    onChanged: (value) {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Done'),
        icon: const Icon(Icons.check_circle_outline),
      ),
    );
  }
}
