import 'package:flutter/material.dart';
import 'package:opeca_app/AprovarRejeitar.dart';

class ItemsLista extends StatelessWidget {
  final String title;
  final String data;
  final String valor;
  final String subtitle;
  final String sistema;
  final String id;
  void _selecionaSistema(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return AprovarRejeitar(this.sistema, this.id);
        },
      ),
    );
  }

  //oid Function() onTap;
  //String sistema = '';

  ItemsLista(
      {required this.title,
      required this.subtitle,
      required this.sistema,
      required this.id,
      required this.data,
      required this.valor});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      color: Colors.white,
      elevation: 2.0,
      margin: new EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 4.0,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 2.0,
        ),
        leading: Container(
          padding: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 0.6,
                color: Colors.grey,
              ),
            ),
          ),
          child: Icon(
            Icons.storage,
            color: Colors.grey[600],

          ),
        ),
        title: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
            SizedBox(width: 5),
            Text(
              data + " | ", //+ valor,
              style: TextStyle(
                color: Colors.grey[800],
                //fontWeight: FontWeight.bold,
              ),
          
          ),
           Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            SizedBox(width: 5),
            Text(
              title, //+ valor,
              style: TextStyle(
                color: Colors.grey[800],
                //fontWeight: FontWeight.bold,
              ),
            ),
        ],
        ),
        subtitle: Row(children: [
          Icon(
            Icons.person_outline,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey),
          )
        ]),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
          size: 20.0,
        ),
        onTap: () => _selecionaSistema(context),
      ),
    );
  }
}
