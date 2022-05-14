import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  UserProvider userProvider = UserProvider();
  bool checkSaveData = false;
  SharedPreferences? pref;
  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
    if (pref != null &&
        pref!.getString("email") != null &&
        pref!.getString("password") != null) {
      emailController.text = pref!.getString("email").toString();
      passwordController.text = pref!.getString("password").toString();
      formData['email'] = emailController.text;
      formData['password'] = passwordController.text;
      checkSaveData = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    loginProvider = Provider.of<LoginProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

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
                        const AppTitle('Iniciar Sesion'),
                        const SizedBox(height: 25),
                        AppFormField(
                          'email',
                          'Correo electronico',
                          controller: emailController,
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
                          controller: passwordController,
                          obscureText: true,
                          formData: formData,
                          validator: (value) {
                            if (value!.length < 3) {
                              return "Contraseña no es valida.";
                            }
                            return null;
                          },
                        ),
                        CheckboxListTile(
                            title: const Text(
                              'Desea guardar sus datos',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                            value: checkSaveData,
                            onChanged: (value) {
                              checkSaveData = value!;
                              setState(() {});
                            }),
                        (loading == false)
                            ? ElevatedButton(
                                onPressed: formLogin,
                                child: const Text('Ingresar'))
                            : const CircularProgressIndicator()
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
      ),
    ));
  }

  formLogin() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      var usuario = await loginProvider.loginUsuario(formData);
      setState(() {
        loading = false;
      });
      if (usuario != null) {
        userProvider.setUser(usuario);

        if (checkSaveData && pref != null) {
          pref!.setString("email", usuario.email!);
          pref!.setString("password", formData['password']!);
        } else {
          pref!.remove('email');
          pref!.remove('password');
        }

        AppDialogs.showDialog2(context, 'Usuario Autenticado!', [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, 'home');
              },
              child: const Text('Ok'))
        ]);
      } else {
        AppDialogs.showDialog1(context, 'No se pudo iniciar sesion');
      }
    } else {
      AppDialogs.showDialog1(context, 'No se pudo validar. ');
    }
  }
}
