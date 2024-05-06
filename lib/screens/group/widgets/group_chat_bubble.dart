import 'package:ace_chat_app/shared/constants.dart';
import 'package:flutter/material.dart';

class GroupChatBubble extends StatelessWidget {
  const GroupChatBubble({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(
          bottom: 8,
        ),
        constraints: BoxConstraints(maxWidth: screenWidth(context) * .6),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Mohammed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'meeeesssssssssssssaaagggeeeeeeeeee',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '13:07',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GroupChatBubble2 extends StatelessWidget {
  const GroupChatBubble2({
    Key? key,
    required this.seen,
  }) : super(key: key);
  final bool seen;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
        constraints: BoxConstraints(maxWidth: screenWidth(context) * .6),
        decoration: const BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'grdshrsdhrsdgsgsegsg',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '13:07',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  seen ? Icons.check_circle_outline : Icons.check_circle,
                  size: 18,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
