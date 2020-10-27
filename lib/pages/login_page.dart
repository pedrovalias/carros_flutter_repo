import 'package:carros_flutter/pages/home_page.dart';
import 'package:carros_flutter/pages/login_api.dart';
import 'package:carros_flutter/pages/utils/nav.dart';
import 'package:carros_flutter/widget/app_button.dart';
import 'package:carros_flutter/widget/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController(text: "pedroValias");

  final _tSenha = TextEditingController(text: "123");

  final _focusSenha = FocusNode();

  // Chamado na inicializacao
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite o login",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              nextFocus: _focusSenha,
            ),
            SizedBox(height: 10),
            AppText(
              "Senha",
              "Digite a senha",
              controller: _tSenha,
              password: true,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: _focusSenha,
            ),
            SizedBox(height: 20),
            AppButton(
              "Login",
              onPressed: _onClickLogin,
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    // bool _formOk = _formKey.currentState.validate();
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    print("Login: $login, Senha: $senha");

    bool ok = await LoginApi.login(login, senha);

    if (ok) {
      push(context, HomePage());
    } else {
      print("Login incorreto");
    }
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha deve conter pelo menos 3 caracteres";
    }
    return null;
  }

  // Metodo responsavel por gerenciar a memoria das telas
  @override
  void dispose() {
    super.dispose();
  }
}
