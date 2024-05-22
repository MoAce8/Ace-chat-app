import 'package:flutter/material.dart';

class EmptyChat extends StatelessWidget {
  const EmptyChat({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '👋',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'No messages yet...',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'Try saying Hi',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
