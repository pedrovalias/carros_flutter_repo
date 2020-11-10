import 'package:carros_flutter/carro/carro.dart';
import 'package:carros_flutter/carro/carros_api.dart';
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
  @override
  // Sobrescreve o método para TRUE para manter o conteudo das abas ativo
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // USANDO O KEEPALIVE, NECESSARIO CHAMAR O SUPER DA CLASSE
    super.build(context);
    return _body();
  }

  _body() {
    Future<List<Carro>> future = CarrosApi.getCarros(widget.tipo);

    // Aula 106
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        // Tratamento de exceção da Future - Aula 107
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possível buscar os erros",
              style: TextStyle(color: Colors.red, fontSize: 22),
            ),
          );
        }
        // Se ele não tem dados antes de retornar do webservise (simulando do delay)
        // Ele exibe o circulo de progresso
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
                        onPressed: () {/* ... */},
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
}
