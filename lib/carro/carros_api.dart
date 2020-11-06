import 'package:carros_flutter/carro/carro.dart';

class CarrosApi {
  static Future<List<Carro>> getCarros() async {
    final carros = List<Carro>();

    await Future.delayed(Duration(seconds: 2));

    carros.add(Carro(
        nome: "AUDI GT Spyder",
        urlFoto:
            "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Porsche_Panamera.png"));
    carros.add(Carro(
        nome: "Porsche Panamera",
        urlFoto:
            "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Porsche_Panamera.png"));
    carros.add(Carro(
        nome: "Lamborghini Aventador",
        urlFoto:
            "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Lamborghini_Aventador.png"));

    return carros;
  }
}
