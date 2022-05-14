// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.kind,
    this.idToken,
    this.email,
    this.refreshToken,
    this.expiresIn,
    this.localId,
  });

  String? kind;
  String? idToken;
  String? email;
  String? refreshToken;
  String? expiresIn;
  String? localId;
  String? name;
  String? lastname;
  String? image;
  double? latitude;
  double? longitude;

  setUserData(Map<String, dynamic> json) {
    name = json['name'];
    lastname = json['lastname'];
    image = json['image'];
  }

  setLocation(double latitude, double longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        kind: json["kind"],
        idToken: json["idToken"],
        email: json["email"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
        localId: json["localId"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "idToken": idToken,
        "email": email,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
        "localId": localId,
      };
}
