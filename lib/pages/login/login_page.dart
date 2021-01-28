import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/util/alert.dart';
import 'package:carros/util/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

//  bool _showProgress = false;

  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'carros',
          textAlign: TextAlign.center,
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppTextFormField(
              "Login",
              "Digite o login",
              controller: _tLogin,
              validator: _validatorLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(
              height: 10,
            ),
            AppTextFormField(
              "Senha",
              "Digite o senha",
              controller: _tSenha,
              validator: _validatorSenha,
              keyboardType: TextInputType.number,
              focusNode: _focusSenha,
              password: true,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
              stream: _bloc.btnBloc.stream,
              initialData: false,
              builder: (context, snapshot) {
                return AppButton(
                  "Login",
                  onPressed: onPressed,
                  showProgress: snapshot.data,
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  onPressed() async {
    try {

      bool formOk = _formKey.currentState.validate();
      if (!formOk) {
        return;
      }

      String login = _tLogin.text;
      String senha = _tSenha.text;

      print("Login: $login e Senha: $senha ");

//      _streamController.add(true);
//      setState(() {
//        _showProgress = true;
//      });

      ApiResponse<Usuario> response = await _bloc.login(login, senha);
      if (response.ok) {
        print(response.result);
        push(context, HomePage(), replace: true);
      } else {
        alert(context, response.msg);
      }
    } catch(e) {
      alert(context, "Não foi possível fazer o login");
    }
//    _streamController.add(false);
//    setState(() {
//      _showProgress = false;
//    });
  }

  String _validatorLogin(String value) {
    if (value.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validatorSenha(String value) {
    if (value.isEmpty) {
      return "Digite a senha";
    }

    if (value.length < 3) {
      return "Senha menor que o permitido";
    }

    return null;
  }
}
