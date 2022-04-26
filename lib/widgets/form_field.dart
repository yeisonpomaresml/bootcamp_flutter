import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  final String name;
  final String label;
  final IconData? icon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AppFormField(
    this.name,
    this.label, {
    Key? key,
    required this.formData,
    this.icon,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  final Map<String, String> formData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        formData[name] = value;
      },
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(icon: Icon(icon), hintText: label),
    );
  }
}
