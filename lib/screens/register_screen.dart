import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/providers/providers.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'email': '', 'password': ''};
  RegisterProvider registerProvider = RegisterProvider();

  @override
  Widget build(BuildContext context) {
    registerProvider = Provider.of<RegisterProvider>(context);

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
                      const AppTitle('Registro de Usuario'),
                      const SizedBox(height: 25),
                      AppFormField(
                        'email',
                        'Correo electronico',
                        formData: formData,
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Correo electronico no valido.";
                          }
                          return null;
                        },
                      ),
                      AppFormField(
                        'password',
                        'Contraseña',
                        obscureText: true,
                        formData: formData,
                        validator: (value) {
                          if (value!.length < 3) {
                            return "Contraseña no es valida.";
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                          onPressed: formRegister,
                          child: const Text('Registrar'))
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    ));
  }

  formRegister() async {
    if (formKey.currentState!.validate()) {
      bool respuesta = await registerProvider.registrarUsuario(formData);
      if (respuesta) {
        AppDialogs.showDialog1(context, 'Usuario registrado con exito.');
      } else {
        AppDialogs.showDialog1(context, 'No se pudo registrar el usuario.');
      }
    } else {
      AppDialogs.showDialog1(context, 'No se pudo validar. ');
    }
  }
}
