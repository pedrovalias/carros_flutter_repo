import 'package:carros_flutter/carro/carro.dart';
import 'package:carros_flutter/carro/carros_api.dart';
import 'package:carros_flutter/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    List<Carro> carros = CarrosApi.getCarros();

    return ListView.builder(
      itemCount: carros.length,
      itemBuilder: (
        context,
        index,
      ) {
        Carro c = carros[index];

        return Row(
          children: <Widget>[
            Image.network(
              c.urlFoto,
              width: 150,
            ),
            // Flexible: ajusta o conteúdo ao espaço
            Flexible(
              child: Text(
                c.nome,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
