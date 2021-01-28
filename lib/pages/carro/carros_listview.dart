import 'dart:async';

import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/util/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'carro.dart';
import 'carros_api.dart';

class CarrosListView extends StatelessWidget {
  List<Carro> carros;

  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Image.network(
                    c.urlFoto ?? 'https://gartic.com.br/imgs/mural/ta/tatahbarbosa/carro.png',
                    width: 150,
                  ),
                ),
                Text(
                  c.nome,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 28),
                ),
                Text(
                  "Descrição...",
                  style: TextStyle(fontSize: 16),
                ),
                ButtonBarTheme(
                  data: ButtonBarTheme.of(context),
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('DETALHES'),
                        onPressed: () => _onClickCarro(context, c),
                      ),
                      FlatButton(
                        child: const Text('SHARE'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

          return ListTile(
            leading: Image.network(c.urlFoto),
            title: Text(
              c.nome,
              style: TextStyle(fontSize: 22),
            ),
          );
//        return
        },
      ),
    );
  }

  _onClickCarro(context, Carro c) {
    print("CARRO PAGE");
    push(context, CarroPage(c));
  }
}
