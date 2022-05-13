import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bootcamp/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  String endpoint = 'https://identitytoolkit.googleapis.com/v1/';
  User user = User();

  setUser(User _user) {
    user = _user;
    notifyListeners();
  }

  Future<bool> updateUsuario(Map<String, String> formData) async {
    var urlDb = Uri.parse(
        'https://fir-notificacion-38f03.firebaseio.com/users/' +
            formData['localId']! +
            '.json');

    var responseDb = await http.put(urlDb, body: jsonEncode(formData));
    if (responseDb.statusCode == 200) {
      user.setUserData(jsonDecode(responseDb.body));
      notifyListeners();
      return true;
    }

    return false;
  }
}
