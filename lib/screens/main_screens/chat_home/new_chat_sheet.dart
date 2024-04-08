import 'package:ace_chat_app/widgets/app_button.dart';
import 'package:ace_chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class NewChatSheet extends StatelessWidget {
  const NewChatSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter Friend Email:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16,),
          const AppTextFormField(
            label: 'email',
          ),
          const SizedBox(height: 16,),
          AppButton(
            text: 'Start Chat',
            function: () {},
          ),
        ],
      ),
    );
  }
}
