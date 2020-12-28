import 'dart:convert' as convert;

import 'package:carros/util/prefs.dart';

class Usuario {
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;

  List<String> roles;

  Usuario.fromJson(Map<String, dynamic> map):
        login = map['login'],
        nome = map['nome'],
        email = map['email'],
        urlFoto = map['urlFoto'],
        token = map['token'],
        roles = getRoles(map);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['login'] = login;
    data['nome'] = nome;
    data['email'] = email;
    data['urlFoto'] = urlFoto;
    data['token'] = token;
    data['roles'] = roles;
    return data;
  }

  void save() {
    Map map = toJson();

    String json = convert.json.encode(map);

    Prefs.setString("user.prefs", json);
  }

  static Future<Usuario> get() async {
    String json = await Prefs.getString("user.prefs");

    if (json == "") return null;

    Map map = convert.json.decode(json);

    Usuario user = Usuario.fromJson(map);

    return user;
  }


  static getRoles(Map<String, dynamic> map) {
    List<String> r = map['roles'].map<String>((role) => role.toString()).toList();
    return r;
  }

  @override
  String toString() {
    return 'Usuario{login: $login, nome: $nome, email: $email, token: $token}';
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }
}