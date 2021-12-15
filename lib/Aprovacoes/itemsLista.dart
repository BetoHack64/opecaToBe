import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:SOP/Aprovacoes/AprovarRejeitar.dart';

class ItemsLista extends StatelessWidget {
  final String title;
  final String data;
  final String valor;
  final String subtitle;
  final String sistema;
  final String id;
  final String moeda;
  void _selecionaSistema(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return AprovarRejeitar(this.sistema, this.id, this.valor, true,
              this.title, this.data, this.moeda);
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
      required this.valor,
      required this.moeda});

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
        vertical: 6.0,
      ),
      child: ListTile(
        //minLeadingWidth: 40 - 20,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 6.0,
          vertical: 2.0,
        ),
        /*leading: Container(
          padding: EdgeInsets.only(left: 3.0),
          width: 28.0,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 0.2,
                color: Colors.grey,
              ),
            ),
          ),
          child: Icon(
            Icons.storage,
            color: Colors.grey[600],
          ),
        ),*/
        title: Transform.translate(
          offset: Offset(8, 0),
          child: Container(
            margin: EdgeInsets.only(left: 0),
            child: Row(
              children: [
                Container(
                  child: Text(
                    data + " | ", //+ valor,
                    style: TextStyle(
                        color: Colors.grey[800],
                        //fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  width: 77,
                ),
                Container(
                  child: AutoSizeText(title + " | ", //+ valor,
                      style: TextStyle(color: Colors.grey[800], fontSize: 13
                          //fontWeight: FontWeight.bold,
                          ),
                      minFontSize: 7,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2),
                  width: title.length == 15
                      ? 99
                      : title.length == 9
                          ? 80
                          : title.length == 22
                              ? 150
                              : title.length == 16
                                  ? 114
                                  : title.length == 7
                                      ? 53 
                                      : title.length == 8
                                          ? 72
                                          : title.length == 12
                                              ? 72
                                              : title.length == 17
                                              ? 119
                                              : title.length == 19
                                              ? 118
                                              : 100,
                ),
                Expanded(
                  child: Container(
                    margin: title.length == 15
                        ? EdgeInsets.only(right: 0)
                        : EdgeInsets.only(right: 20),
                    child: AutoSizeText(
                      valor + " akz",
                      style: TextStyle(
                        color: Colors.red[900],
                        fontSize: valor.length == 14
                            ? 15
                            : valor.length == 8
                                ? 15
                                : valor.length > 17
                                    ? 15
                                    : valor.length <= 11
                                        ? 15
                                        : valor.length == 12
                                            ? 15
                                            : valor.length == 9
                                                ? 15
                                                : valor.length == 13
                                                ? 15
                                                : valor.length == 22
                                                ? 15
                                                : 15,
                      ),
                      minFontSize: 7,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    width: valor.length == 22
                                                ? 245
                                                : 239,
                  ),
                )
              ],
            ),
          ),
        ),
        subtitle: Transform.translate(
          offset: Offset(8, 4),
          child: Row(
            children: [
              SizedBox(
                width: 2,
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
        ),
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
