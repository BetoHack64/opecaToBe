import 'package:flutter/material.dart';

class PaginaSnackBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Esse é o nosso SnackBar'),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                // Algum código para desfazer alguma alteração
              },
            ),
          );

          // Aqui nós usamos a Scaffold do contexto para
          // exibir o SnackBar corretamente como explicado antes
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}
