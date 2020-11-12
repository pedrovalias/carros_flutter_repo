import 'dart:convert';
// declara a biblioteca e atribui uma variavel para chamar
import 'package:carros_flutter/pages/api_response.dart';
import 'package:carros_flutter/login/usuario.dart';
import 'package:http/http.dart' as http;

// classe simples que vai encapsular a lógica para chamar o webservice
class LoginApi {
  // Metodo estatico que vai retornar um boolean
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    // Tratamento de erro (erros não esperados: falhade conexao, bug, etc)
    try {
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

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);

        user.save();

        // TESTE
        // Usuario user2 = await Usuario.get();
        // print("user2: $user2");

        return ApiResponse.ok(user);
      }

      return ApiResponse.error(mapResponse["error"]);
    } catch (error, exception) {
      print("Erro no login. $error > $exception");
      return ApiResponse.error("Não foi possível fazer o login.");
    }
  }
}
