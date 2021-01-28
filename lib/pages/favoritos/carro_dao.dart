import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/base_dao.dart';

// Data Access Object
class CarroDAO extends BaseDAO {
  @override
  fromJson(Map<String, dynamic> map) {
    return Carro.fromJson(map);
  }

  @override
  String get tableName => "carro";

  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from $tableName where tipo = ? ', [tipo]);

    final carros = list.map<Carro>((json) => fromJson(json)).toList();

    return carros;
  }


}
