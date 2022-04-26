import 'package:flutter/material.dart';

class AppDialogs {
  static showDialog1(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(message));
        });
  }
}
