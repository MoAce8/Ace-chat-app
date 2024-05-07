import 'package:ace_chat_app/widgets/custom_labeled_text_field.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    this.icon,
    required this.title,
    this.trailing,
    required this.controller,
    required this.enabled,
  }) : super(key: key);

  final IconData? icon;
  final String title;
  final Widget? trailing;
  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: AppLabeledTextField(
          label: title,
          controller: controller,
          enabled: enabled,
        ),
        trailing: trailing,
      ),
    );
  }
}
