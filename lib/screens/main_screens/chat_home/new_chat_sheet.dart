import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/widgets/app_button.dart';
import 'package:ace_chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class NewChatSheet extends StatefulWidget {
  const NewChatSheet({Key? key}) : super(key: key);

  @override
  State<NewChatSheet> createState() => _NewChatSheetState();
}

class _NewChatSheetState extends State<NewChatSheet> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          right: 20,
          left: 20,
          top: 20,
          bottom: 20 + keyboardHeight(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enter Friend\'s Email:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.qr_code_scanner),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            AppTextFormField(
              label: 'Email',
              controller: emailController,
            ),
            const SizedBox(
              height: 16,
            ),
            AppButton(
              text: 'Start Chat',
              function: () {
                if (emailController.text.isNotEmpty) {
                  FireData()
                      .createRoom(context, email: emailController.text)
                      .then(
                        (value) => Navigator.pop(context),
                      );
                  FireData().addContact(email: emailController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
