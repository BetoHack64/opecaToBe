import 'package:flutter/material.dart';

class GridDashboard extends StatelessWidget {
  Item item1 = new Item(
    titulo: "Calendar",
    subTitulo: "Março, Quarta feira",
    evento: "3 Eventos",
    imagem: "assets/calendar.png",
  );

  @override
  Widget build(BuildContext context) {
    return new Card();
  }
}

class Item {
  String titulo;
  String subTitulo;
  String evento;
  String imagem;
  Item(
      {required this.titulo,
      required this.subTitulo,
      required this.evento,
      required this.imagem});
}
