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
          const SizedBox(height: 16,),
          const AppTextFormField(
            label: 'Email',
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
