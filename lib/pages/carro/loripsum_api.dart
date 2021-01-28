import 'dart:async';
import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:http/http.dart' as http;

class LoripsumBloc extends SimpleBloc<String> {

  fetch() async{
    try {
      String res  = await LoripsumApi.getLoripsum();
      add(res);
    } on Exception catch (e) {
      addError(e);
    }
  }

}

class LoripsumApi {
  static getLoripsum() async {
    var url = 'https://loripsum.net/api';

    var res = await http.get(url);

    String text = res.body;

    return text.replaceAll("<p>", "").replaceAll("</p>", "");
  }

}