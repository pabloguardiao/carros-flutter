import 'dart:convert';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/prefs.dart';
import 'package:http/http.dart' as http;

class LoginApi {

  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    var url = 'http://carros-springboot.herokuapp.com/api/v2/login';

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    Map params = {
      "username": login,
      "password": senha,
    };
    String p = json.encode(params);
    var response = await http.post(url, body: p, headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      final Usuario user = Usuario.fromJson(mapResponse);

      user.save();

      Usuario user2 = await Usuario.get();
      print("User2: $user2");
      return ApiResponse.ok(user);

    } else {
      return ApiResponse.error(mapResponse["error"]);
    }
  }

}

