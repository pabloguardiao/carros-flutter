import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

class LoginBloc {
  final btnBloc = SimpleBloc<bool>();

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    btnBloc.add(true);
    ApiResponse<Usuario> response = await LoginApi.login(login, senha);
    btnBloc.add(false);
    return response;
  }

  void dispose() {
    btnBloc.dispose();
  }
}