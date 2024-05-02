import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String fieldKey;
  final Function(String?)? onChanged;
  final bool obscureText;
  final String? errorText;
  final Widget prefixIcon;

  const CustomTextFormField({
    required this.labelText,
    required this.fieldKey,
    this.onChanged,
    this.obscureText = false,
    super.key,
    this.errorText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      child: TextFormField(
        key: ValueKey(fieldKey),
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
            labelText: labelText,
            errorText: errorText,
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                50,
              ),
            )),
      ),
    );
  }
}
