import 'package:ace_chat_app/widgets/chat_bubble.dart';
import 'package:ace_chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Mohammed'),
                Text(
                  'Last seen 12:30',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: 10,
                itemBuilder: (context, index) => index % 2 == 0
                    ? ChatBubble()
                    : ChatBubble2(seen: index % 3 == 0 ? true : false),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    child: AppTextField(
                      label: 'Message',
                      controller: messageCont,
                      suffix: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_file),
                      ),
                      prefix: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.emoji_emotions),
                      ),
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
