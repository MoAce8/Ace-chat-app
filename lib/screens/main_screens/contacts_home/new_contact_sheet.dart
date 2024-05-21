import 'package:ace_chat_app/firebase/fire_database.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/widgets/app_button.dart';
import 'package:ace_chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class NewContactSheet extends StatefulWidget {
  const NewContactSheet({Key? key}) : super(key: key);

  @override
  State<NewContactSheet> createState() => _NewContactSheetState();
}

class _NewContactSheetState extends State<NewContactSheet> {
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
              text: 'Add Contact',
              function: () {
                if (emailController.text.isNotEmpty) {
                  FireData()
                      .addContact(email: emailController.text)
                      .then((value) => Navigator.pop(context));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
