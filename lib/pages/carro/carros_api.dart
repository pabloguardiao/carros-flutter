
import 'dart:convert';
import 'dart:io';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/carro_dao.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer ${user.token}"
    };

    final url = "http://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo";

    var response = await http.get(url, headers: headers);

    List list = json.decode(response.body);

    List<Carro> carros = List();
    for(Map map in list) {
      Carro c = Carro.fromJson(map);
      carros.add(c);
    }
    final dao = CarroDAO();
    carros.forEach(dao.save);

    return carros;
  }
}