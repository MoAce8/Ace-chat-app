import 'package:ace_chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EditGroupScreen extends StatefulWidget {
  const EditGroupScreen({Key? key}) : super(key: key);

  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  TextEditingController gName = TextEditingController();

  @override
  void initState() {
    super.initState();
    gName.text = 'Group Name';
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add Members'),
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
