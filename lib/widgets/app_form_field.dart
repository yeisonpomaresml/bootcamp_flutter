import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  final String name;
  final String label;
  final IconData? icon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const AppFormField(
    this.name,
    this.label, {
    Key? key,
    this.icon,
    this.validator,
    this.obscureText = false,
    this.controller,
    required this.formData,
  }) : super(key: key);

  final Map<String, String> formData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {
        formData[name] = value;
      },
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(icon: Icon(icon), hintText: label),
    );
  }
}
