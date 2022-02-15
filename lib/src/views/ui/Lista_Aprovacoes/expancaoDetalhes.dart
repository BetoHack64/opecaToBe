import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpancaoDetalhes extends StatefulWidget {
  @override
  State<ExpancaoDetalhes> createState() => _ExpancaoDetalhesState();
}

class _ExpancaoDetalhesState extends State<ExpancaoDetalhes> {
  late List<bool> _isOpen;
  Item item = Item(expandedValue: "Teste valor", headerValue: "Cabecalho");
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      animationDuration: Duration(seconds: 1),
      elevation: 0,
      children: [
        ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Container();
            },
            //backgroundColor: Colors.grey[200],
            body: ListTile(
              title: Text("Tudo bem"),
              subtitle: Text('Ola'),
            ),
            isExpanded: item.isExpanded)
      ],
      expansionCallback: (panelIndex, isExpanded) {
        setState(
          () {
            item.isExpanded = !isExpanded;
          },
        );
      },
    );
  }
}

class Item {
  late String expandedValue;
  late String headerValue;
  late bool isExpanded;
  Item(
      {required this.expandedValue,
      required this.headerValue,
      this.isExpanded = false});
}
