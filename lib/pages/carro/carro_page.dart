import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/loripsum_api.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsonBloc = LoripsumBloc();

  @override
  void initState() {
    super.initState();

    _loripsonBloc.fetch();
  }

  @override
  void dispose() {
    _loripsonBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa(),
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo(),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopupMenu(value),
            itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(value: "Editar", child: Text("Editar"),),
              PopupMenuItem(value: "Deletar", child: Text("Deletar"),),
              PopupMenuItem(value: "Share", child: Text("Share"),),
            ];
          },)
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Image.network(widget.carro.urlFoto),
            _bloco1(),
            Divider(),
            _bloco2()
          ],
        )
    );
  }

  Row _bloco1() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text(widget.carro.nome, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(widget.carro.tipo, style: TextStyle(fontSize: 16),)
            ]),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red, size: 40,),
                  onPressed: _onClickFavorito(),
                ),
                IconButton(
                  icon: Icon(Icons.share, size: 40,),
                  onPressed: _onClickFavorito(),
                )
              ],
            ),
          ],);
  }

  _onClickMapa() {}

  _onClickVideo() {}

  _onClickPopupMenu(String value) {}

  _onClickFavorito() {}

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20,),
        Text(widget.carro.descricao, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        StreamBuilder(
          stream: _loripsonBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return Text(snapshot.data, style: TextStyle(fontSize: 16),);
          },
        )
      ],
    );
  }
}
