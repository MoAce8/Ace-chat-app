import 'package:ace_chat_app/shared/constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key,
    this.width = double.infinity,
    this.background = Colors.blue,
    this.isUperCase = false,
    required this.text,
    required this.function,
  });

  final double width;
  final Color background;
  final bool isUperCase;
  final String text;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
            color: background, borderRadius: BorderRadius.circular(12)),
        width: width,
        height: screenHeight(context) * 0.055,
        child: Center(
          child: Text(
            isUperCase ? text.toUpperCase() : text,
            style: TextStyle(
                fontSize: screenWidth(context) * 0.046,
                fontWeight: FontWeight.w500,
            color: Colors.white),
          ),
        ),
      ),
    );
  }
}
