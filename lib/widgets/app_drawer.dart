import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
            children: const [Icon(Icons.person, size: 100)],
          )),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
            selected: true,
          ),
          ListTile(
            title: const Text('Mapa'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'mapa');
            },
          ),
          ListTile(
            title: const Text('Temporal 1'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Temporal 2'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Acerca'),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'acerca');
            },
          ),
        ],
      ),
    );
  }
}
