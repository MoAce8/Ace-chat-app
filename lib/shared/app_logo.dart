import 'package:ace_chat_app/shared/constants.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      height: screenHeight(context) * .2,
      color: kPrimaryColor,
    );
  }
}