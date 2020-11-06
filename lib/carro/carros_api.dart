import 'dart:convert' as convert;

import 'package:carros_flutter/carro/carro.dart';
import 'package:http/http.dart' as http;

class CarrosApi {
  static Future<List<Carro>> getCarros() async {
    var url = 'https://carros-springboot.herokuapp.com/api/v1/carros';

    // Retorna a resposta do get no webservice
    var response = await http.get(url);

    print("GET > $url");

    String json = response.body;

    List list = convert.json.decode(response.body);

    // UMA Maneira de fazer o PARSER
    // final carros = List<Carro>();
    //
    // for (Map map in list) {
    //   Carro c = Carro.fromJson(map);
    //   carros.add(c);
    // }

    // OUTRA Forma de fazer o PARSER (mais utilizada)
    // Função map percorre a lista original, gera outro objeto (carro)
    final carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();

    return carros;
  }
}
