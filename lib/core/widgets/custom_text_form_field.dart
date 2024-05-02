import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String fieldKey;
  final Function(String?)? onChanged;
  final bool obscureText;
  final String? errorText;

  const CustomTextFormField({
    required this.labelText,
    required this.fieldKey,
    this.onChanged,
    this.obscureText = false,
    super.key,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(fieldKey),
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
      ),
    );
  }
}
