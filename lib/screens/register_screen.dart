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
  bool loading = false;
  Map<String, String> formData = {
    'email': '',
    'password': '',
    'name': '',
    'lastname': ''
  };
  RegisterProvider registerProvider = RegisterProvider();

  @override
  Widget build(BuildContext context) {
    registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Colors.indigo,
        child: Column(
          children: [
            const SizedBox(height: 60),
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
                          'name',
                          'Nombre',
                          formData: formData,
                          validator: (value) {
                            if (value!.length < 4) {
                              return "Nombre no valido.";
                            }
                            return null;
                          },
                        ),
                        AppFormField(
                          'lastname',
                          'Apellido',
                          formData: formData,
                          validator: (value) {
                            if (value!.length < 4) {
                              return "Apellido no valido.";
                            }
                            return null;
                          },
                        ),
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
                        (loading == false)
                            ? ElevatedButton(
                                onPressed: formRegister,
                                child: const Text('Registrar'))
                            : const CircularProgressIndicator()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 15),
          ],
        ),
      ),
    ));
  }

  formRegister() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      bool respuesta = await registerProvider.registrarUsuario(formData);
      setState(() {
        loading = false;
      });
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
