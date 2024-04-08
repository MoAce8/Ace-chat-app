import 'package:flutter/material.dart';

class ContactsHomeScreen extends StatelessWidget {
  const ContactsHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
    );
  }
}
