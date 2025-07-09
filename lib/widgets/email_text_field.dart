import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final String errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmit;

  EmailFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.errorText,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.onSubmit,
  });

  final _emailRegex = RegExp(
      r"^[-A-Za-z0-9!#$%&'*+/=?^_`{|}~]+(?:\.[-A-Za-z0-9!#$%&'*+/=?^_`{|}~]+)*@(?:[A-Za-z0-9](?:[-A-Za-z0-9]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[-A-Za-z0-9]*[A-Za-z0-9])?$");

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return errorText;
        if (!_emailRegex.hasMatch(value.trim())) return errorText;
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.disabled,
    );
  }
}
