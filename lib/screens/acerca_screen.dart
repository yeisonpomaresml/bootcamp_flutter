import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class AcercaScreen extends StatefulWidget {
  const AcercaScreen({Key? key}) : super(key: key);

  @override
  State<AcercaScreen> createState() => _AcercaScreenState();
}

class _AcercaScreenState extends State<AcercaScreen> {
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: getAppBar(context, 'Acerca', userProvider.user),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('App V.1.0'),
      ),
    );
  }
}
