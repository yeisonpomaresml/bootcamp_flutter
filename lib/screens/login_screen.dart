import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'email': '', 'password': ''};
  LoginProvider loginProvider = LoginProvider();
  @override
  Widget build(BuildContext context) {
    loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
        body: Container(
      width: double.infinity,
      color: Colors.indigo,
      child: Column(
        children: [
          const SizedBox(height: 35),
          const Icon(
            Icons.supervised_user_circle,
            size: 200,
            color: Colors.white,
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const AppTitle(title: 'Iniciar Session'),
                      const SizedBox(height: 25),
                      AppFormField('email', 'Correo Electronico',
                          formData: formData, validator: (value) {
                        if (value!.length < 5) {
                          return "Correo no valido";
                        }
                        return null;
                      }, icon: Icons.email),
                      AppFormField('password', 'Contraseña', formData: formData,
                          validator: (value) {
                        if (value!.length < 3) {
                          return "Contraseña no es valida.";
                        }
                        return null;
                      }, obscureText: true, icon: Icons.password),
                      ElevatedButton(
                          onPressed: loginForm, child: const Text('Ingresar'))
                    ],
                  ),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'register');
              },
              child: const Text(
                'Registrar nueva cuenta',
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(height: 35),
        ],
      ),
    ));
  }

  void loginForm() async {
    if (formKey.currentState!.validate()) {
      bool respuesta = await loginProvider.loginUsuario(formData);
      if (respuesta) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, 'home');
                    },
                    child: Text('Ok'))
              ], title: Text('Usuario Autenticado!'));
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                  title: Text('No se pudo iniciar sesion'));
            });
      }
    } else {
      print("No se pudo validar. ");
    }
  }
}
