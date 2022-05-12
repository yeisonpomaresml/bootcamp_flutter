import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class AcercaScreen extends StatefulWidget {
  const AcercaScreen({Key? key}) : super(key: key);

  @override
  State<AcercaScreen> createState() => _AcercaScreenState();
}

class _AcercaScreenState extends State<AcercaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca'),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Text('App V.1.0'),
      ),
    );
  }
}
