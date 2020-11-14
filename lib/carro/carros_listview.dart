import 'dart:async';

import 'package:carros_flutter/carro/carro.dart';
import 'package:carros_flutter/carro/carro_page.dart';
import 'package:carros_flutter/carro/carros_api.dart';
import 'package:carros_flutter/utils/nav.dart';
import 'package:flutter/material.dart';

// ListView genérico
class CarrosListView extends StatefulWidget {
  // Cria uma variável e passa para o construtor
  final String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carro> carros;

  // Quando se atribui o StreamController a uma variável se mantém aberto o fluxod e dados
  final _streamController = StreamController<List<Carro>>();

  @override
  // Sobrescreve o método para TRUE para manter o conteudo das abas ativo
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _loadCarros();
  }

  _loadCarros() async {
    List<Carro> carros = await CarrosApi.getCarros(widget.tipo);

    _streamController.add(carros);
  }

  @override
  Widget build(BuildContext context) {
    // USANDO O KEEPALIVE, NECESSARIO CHAMAR O SUPER DA CLASSE
    super.build(context);

    print("CarrosListView build ${widget.tipo}");

    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possível buscar os carros",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        // Aula 106
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (
          context,
          index,
        ) {
          Carro c = carros[index];

          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      // ?? tipo um IF INTERNÁRIO - se um carro estiver sem foto no servidor, ele coloca uma outra
                      c.urlFoto ??
                          "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/classicos/Cadillac_Deville_Convertible.png",
                      width: 250,
                    ),
                  ),
                  // Flexible: ajusta o conteúdo ao espaço
                  Text(
                    c.nome,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Descrição..",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('DETALHES'),
                        onPressed: () => _onClickCarro(c),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('SHARE'),
                        onPressed: () {/* ... */},
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  // Metodo responsavel por gerenciar a memoria das telas
  @override
  void dispose() {
    super.dispose();

    // Fechar o fluxo de dados
    _streamController.close();
  }
}
