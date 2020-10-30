import 'dart:convert';
// declara a biblioteca e atribui uma variavel para chamar
import 'package:http/http.dart' as http;

// classe simples que vai encapsular a lógica para chamar o webservice
class LoginApi {
  // Metodo estatico que vai retornar um boolean
  static Future<bool> login(String login, String senha) async {
    var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

    // Configuracao
    Map<String, String> headers = {"Content-Type": "application/json"};

    Map parametros = {"username": login, "password": senha};

    // Converte o hashmap para string
    String s = json.encode(parametros);
    print("> $s");

    // Retorna a resposta do post no webservice
    var response = await http.post(
      url,
      // passa a string para o body
      body: s,
      headers: headers,
    );

    // Imprime o status code da resposta do webservice
    print('Response status: ${response.statusCode}');
    // Imprime o JASON de resposta
    print('Response body: ${response.body}');

    Map mapResponse = json.decode(response.body);

    String nome = mapResponse["nome"];
    String email = mapResponse["email"];

    print("Nome: $nome");
    print("Email: $email");

    return true;
  }
}
