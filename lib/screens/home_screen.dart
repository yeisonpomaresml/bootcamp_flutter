import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    String name = userProvider.user.name!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bootcamp App'),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Text('Bienvenido ' + name + ' a la aplicacion....'),
      ),
    );
  }
}
