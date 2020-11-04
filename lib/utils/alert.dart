import 'package:flutter/material.dart';

// Função alert GENÉRICA
alert(BuildContext context, String msg) {
  showDialog(
      // Desabilitar o fechamento do Dialog ao clicar fora da caixa
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          // Desabilitar o fechamento do Dialog ao clicar para voltar no Android
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("Carros"),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      });
}
