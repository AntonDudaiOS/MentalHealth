import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final String label;
  final String hintText;
  final String errorText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmit;

  const PasswordFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.errorText,
    this.controller,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onSubmit,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscure = true;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return widget.errorText;

    if (value.length < 8) {
      return 'Pass must contains 8 char';
    }

    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    final hasDigit = RegExp(r'\d').hasMatch(value);
    final hasSpecialChar = RegExp(r'[!?\-;]').hasMatch(value);

    if (!hasUppercase) return 'Need contain 1 Upper case char';
    if (!hasLowercase) return 'Need contain 1 lower case char';
    if (!hasDigit) return 'Need contain 1 number';
    if (!hasSpecialChar) {
      return 'Need contain 1 special char (!?;-)';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onSubmit,
      controller: widget.controller,
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
      ),
      validator: widget.validator ?? _validatePassword,
      autovalidateMode: AutovalidateMode.disabled,
    );
  }
}
