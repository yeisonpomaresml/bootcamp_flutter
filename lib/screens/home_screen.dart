import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bootcamp App'),
      ),
      body: const Center(
        child: Text('Bienvenido a la aplicacion....'),
      ),
    );
  }
}
