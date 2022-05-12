import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class LoginProvider extends ChangeNotifier {
  String endpoint = 'https://identitytoolkit.googleapis.com/v1';

  Future<User?> loginUsuario(Map<String, String> formData) async {
    var url = Uri.parse(endpoint +
        '/accounts:signInWithPassword?key=AIzaSyAokmx5tRFANitWLEs1tB_VK7m6r1Lnas0');

    var response = await http.post(url, body: jsonEncode(formData));
    if (response.statusCode == 200) {
      var usuario = User.fromJson(jsonDecode(response.body));
      var urlDb = Uri.parse(
          'https://fir-notificacion-38f03.firebaseio.com/users/' +
              usuario.localId! +
              '.json');

      var responseDb = await http.get(urlDb);
      if (responseDb.statusCode == 200) {
        usuario.setUserData(jsonDecode(responseDb.body));
        return usuario;
      }
    }
    return null;
  }
}
