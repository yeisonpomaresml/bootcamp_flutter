import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class RegisterProvider extends ChangeNotifier {
  String endpoint = 'https://identitytoolkit.googleapis.com/v1/';
  RegisterProvider() {
    print("iniciando register_provider...");
  }

  Future<bool> registrarUsuario(Map<String, String> formData) async {
    var url = Uri.parse(endpoint +
        'accounts:signUp?key=AIzaSyAokmx5tRFANitWLEs1tB_VK7m6r1Lnas0');

    var response = await http.post(url, body: jsonEncode(formData));
    if (response.statusCode == 200) {
      var usuario = User.fromJson(jsonDecode(response.body));

      var urlDb = Uri.parse(
          'https://fir-notificacion-38f03.firebaseio.com/users/' +
              usuario.localId! +
              '.json');

      var responseDb = await http.put(urlDb,
          body: jsonEncode(
              {'name': formData['name'], 'lastname': formData['lastname']}));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
