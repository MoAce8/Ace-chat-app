import 'package:ace_chat_app/shared/constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.background = kPrimaryColor,
    this.isUperCase = false,
    required this.text,
    required this.function,
  });

  final Color background;
  final bool isUperCase;
  final String text;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: function,
        child: Center(
          child: Text(
            isUperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16
            ),
          ),
        ),
      ),
    );
  }
}
