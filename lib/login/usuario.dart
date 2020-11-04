class Usuario {
  // Mesmos atributos do JSON
  String login;
  String nome;
  String email;
  String token;

  List<String> roles;

  /* Formas comuns de fazer o Parser do objeto

  // Parser construtor padrão
  Usuario(Map<String, dynamic> map) {
    login = map["login"];
    nome = map["nome"];
    email = map["email"];
    token = map["token"];
  }

  // Parser utilizando construtor nomeado "fromJSON" (named Constructor)
  Usuario.fromJSON(Map<String, dynamic> map) {
    login = map["login"];
    nome = map["nome"];
    email = map["email"];
    token = map["token"];
  }
  */

  // Parser utilizando LISTA DE INICIALIZAÇÃO (modo mais utilizado hoje)
  Usuario.fromJSON(Map<String, dynamic> map)
      : login = map["login"],
        nome = map["nome"],
        email = map["email"],
        token = map["token"],
        // roles = getRoles(map); // Chamando método para fazer o PARSER DE LISTA

        /* 
          PARSER de LISTA direto utilizando if internário: condição ? ação condicionada : ação default
          Lê-se SE map[roles] diferente de null, faz ação, senão retorna null 
        */
        roles = map["roles"] != null
            ? map["roles"].map<String>((role) => role.toString()).toList()
            : null;

  @override
  String toString() {
    return 'Usuario(login: $login, nome: $nome, email: $email, token: $token, role: $roles)';
  }

  /* 
  // PARSER DE LISTAS
  //FORMA BÁSICA - criando um for pra percorrer uma lista e atribuir a outra lista
  static List<String> getRoles(Map<String, dynamic> map) {
    // Cria lista para ler as roles
    List list = map["roles"];
    // Gerar uma nova lista de Strings
    List<String> roles = [];

    // Percorrer a lista de roles e adicionar o role na nova lista criada
    for (String role in list) {
      roles.add(role);
    }
    return roles;
  }*/

  /*
  // FORMA PARA ENTENDIMENTO
  static List<String> getRoles(Map<String, dynamic> map) {
    // Cria lista para ler as roles
    List list = map["roles"];

    // Função map vai percorrer a lista e transformar os objetos, retornando uma nova lista no lugar.
    // Então nesse caso, queremos transformar em uma lista de Strings, por isso o nosso map será TIPADO: list.map<String>()
    // Nossa Função map precisa receber a função que será convertida: ela recebe a role convertendo para toString: (role) => role.toString()
    // No final utilizamos o toList para pegar essa nova lista
    // OBS.: TUDO ISSO PODE SER REALIZADO EM UMA MESMA LINHA, LÁ ONDE É CHAMADO
    List<String> roles = list.map<String>((role) => role.toString()).toList();

    return roles;
  }*/
}
