import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneFormField extends FormField<String> {
  PhoneFormField({
    super.key,
    required String label,
    required String hintText,
    required String errorText,
    TextEditingController? controller,
  }) : super(
          validator: (value) {
            final phoneRegex = RegExp(r"^\+?[0-9]{10,13}");
            if (value == null || value.isEmpty) return errorText;
            if (!phoneRegex.hasMatch(value.trim())) return errorText;
            return null;
          },
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label),
                const SizedBox(height: 8),
                CupertinoTextField(
                  placeholder: hintText,
                  controller: controller,
                  onChanged: (value) => state.didChange(value),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: state.hasError ? Colors.red : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: CupertinoColors.systemGrey6,
                  ),
                  keyboardType: TextInputType.phone,
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 4),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
              ],
            );
          },
        );
}
