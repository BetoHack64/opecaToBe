import 'package:flutter/material.dart';

class MensagemLogin {
  static erroConexao(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Conexão"),
              content: new Text(
                  "Falha ao acessar a internet. Verifique a sua ligação!"),
              actions: <Widget>[
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("Fechar"))
              ]);
        });
  }

  static erroLogin(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Autenticação"),
              content: new Text("Usuário ou senha inválidos!"),
              actions: <Widget>[
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("Fechar"))
              ]);
        });
  }
}
