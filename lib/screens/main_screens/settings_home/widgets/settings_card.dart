import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    Key? key,
    this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final IconData? icon;
  final String title;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: trailing,
        ),
      ),
    );
  }
}
