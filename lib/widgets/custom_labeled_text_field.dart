import 'package:ace_chat_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLabeledTextField extends StatelessWidget {
  const AppLabeledTextField({
    Key? key,
    required this.label,
    this.controller,
    this.suffix,
    this.obscure = false,
    this.keyboard,
    this.validator,
    this.inputFormatters,
    this.denySpaces = false,
    this.onChanged,
    this.maxLines = 10,
    this.prefix,
    this.autofocus = false,
    this.enabled = true,
  }) : super(key: key);

  final String label;
  final TextEditingController? controller;
  final Function(String? s)? onChanged;
  final Widget? suffix;
  final Widget? prefix;
  final bool obscure;
  final TextInputType? keyboard;
  final List<TextInputFormatter>? inputFormatters;
  final bool denySpaces;
  final String? Function(String? st)? validator;
  final int maxLines;
  final bool autofocus;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: inputFormatters ?? [],
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: 1,
      style: const TextStyle(fontSize: 16),
      autofocus:autofocus,
      enabled: enabled,
      decoration: InputDecoration(
        label: Text(label),
          labelStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          prefixIcon: prefix,
          prefixIconColor: Colors.grey,
          suffixIcon: suffix,
          suffixIconColor: Colors.grey,
          suffixIconConstraints:
          BoxConstraints(maxHeight: screenHeight(context) * 0.04)),
    );
  }
}
