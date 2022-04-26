import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String title;
  const AppTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 18));
  }
}
